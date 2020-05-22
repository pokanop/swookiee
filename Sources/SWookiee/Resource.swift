import Foundation

@frozen public struct AnyResource {
    
    public var base: Any
    
    public init<R: Resource>(_ base: R) {
        self.base = base
    }
    
}

public protocol Resource: Decodable, Hashable {
    
    static var endpoint: Endpoint { get }
    var id: UUID { get }
    var name: String { get }
    var url: URL { get }
    var created: Date { get }
    var updated: Date { get }
    
}

public extension Resource {
    
    var name: String { Self.endpoint.rawValue }
    var url: URL { Self.endpoint.baseURL }
    var created: Date { Date.distantPast }
    var updated: Date { Date.distantPast }
    
    static func fetch(id: Int, completion: ((Self?, Error?) -> ())? = nil) {
        fetch(url: endpoint.itemURL(id: id), completion: completion)
    }
    
    static func fetch(page: Int, completion: (([Self]?, Error?) -> ())? = nil) {
        fetch(url: endpoint.pageURL(page: page), completion: completion)
    }
    
    static func fetch(search: String, completion: (([Self]?, Error?) -> ())? = nil) {
        fetch(url: endpoint.searchURL(search: search), completion: completion)
    }
    
    static func fetch(completion: (([Self]?, Error?) -> ())? = nil) {
        fetch(url: endpoint.baseURL, completion: completion)
    }
    
}

extension Resource {
    
    static func fetch<T: Resource>(url: URL, completion: ((T?, Error?) -> ())? = nil) {
        if let resource: T = Cache.shared.get(url) {
            completion?(resource, nil)
            return
        }
        
        let innerCompletion: (T?, Error?) -> () = { resource, error in
            if let resource = resource {
                Cache.shared.set(resource, for: url)
            }
            completion?(resource, error)
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                assertionFailure(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                assertionFailure("response data is nil")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .custom(DateFormatter.dateDecoder)
            do {
                let resource = try decoder.decode(Self.self, from: data)
                innerCompletion(resource as? T, nil)
            } catch let error {
                assertionFailure(error.localizedDescription)
                innerCompletion(nil, error)
            }
        }.resume()
    }
    
    static func fetch<T: Resource>(url: URL, group: DispatchGroup? = nil, completion: (([T]?, Error?) -> ())? = nil) {
        if let resources: [T] = Cache.shared.get(url) {
            completion?(resources, nil)
            return
        }
            
        let firstRequest = group == nil
        let group: DispatchGroup = group ?? DispatchGroup()
        group.enter()
        
        var result: [T] = []
        var outerError: Error?
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                assertionFailure(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                assertionFailure("response data is nil")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .custom(DateFormatter.dateDecoder)
            do {
                let page = try decoder.decode(Page<Self>.self, from: data)
                if let next = page.next {
                    let innerCompletion: ([T]?, Error?) -> () = { resources, error in
                        guard let resources = resources else {
                            outerError = error
                            return
                        }
                        result += resources
                    }
                    fetch(url: next, group: group, completion: innerCompletion)
                }
                result += page.results as? [T] ?? []
            } catch let error {
                assertionFailure(error.localizedDescription)
                outerError = error
            }
            
            group.leave()
        }.resume()
        
        if firstRequest {
            group.wait()
            
            if result.count > 0 {
                Cache.shared.set(result, for: url)
            }
            
            completion?(result, outerError)
        }
    }
    
}
