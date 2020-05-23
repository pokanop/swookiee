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
    
    static func fetch(id: Int, completion: ((Result<Self, Error>) -> ())? = nil) {
        fetch(url: endpoint.itemURL(id: id), completion: completion)
    }
    
    static func fetch(page: Int, completion: ((Result<[Self], Error>) -> ())? = nil) {
        fetch(url: endpoint.pageURL(page: page), completion: completion)
    }
    
    static func fetch(search: String, completion: ((Result<[Self], Error>) -> ())? = nil) {
        fetch(url: endpoint.searchURL(search: search), completion: completion)
    }
    
    static func fetch(completion: ((Result<[Self], Error>) -> ())? = nil) {
        fetch(url: endpoint.baseURL, completion: completion)
    }
    
}

extension Resource {
    
    static func fetch<T: Resource>(url: URL, completion: ((Result<T, Error>) -> ())? = nil) {
        let completion = wrappedCompletion(completion)
        
        if let resource: T = Cache.shared.get(url) {
            completion?(.success(resource))
            return
        }
        
        let innerCompletion: (Result<T, Error>) -> () = { result in
            if case .success(let resource) = result {
                Cache.shared.set(resource, for: url)
            }
            completion?(result)
        }
        
        Network.shared.provider.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion?(.failure(SWookieeError.network(underlyingError: error!)))
                return
            }
            
            guard let data = data else {
                completion?(.failure(SWookieeError.data))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .custom(DateFormatter.dateDecoder)
            do {
                if let resource = try decoder.decode(Self.self, from: data) as? T {
                    innerCompletion(.success(resource))
                }
            } catch let error {
                innerCompletion(.failure(SWookieeError.decoder(underlyingError: error)))
            }
        }.resume()
    }
    
    static func fetch<T: Resource>(urls: [URL], completion: ((Result<[T], Error>) -> ())? = nil) {
        let completion = wrappedCompletion(completion)
        
        var resources: [T] = []
        var pendingURLs: [URL] = []
        
        urls.forEach { url in
            if let resource: T = Cache.shared.get(url) {
                resources.append(resource)
            } else {
                pendingURLs.append(url)
            }
        }
        
        var errors: [Error] = []
        let group = DispatchGroup()
        
        pendingURLs.forEach { url in
            group.enter()
            
            fetch(url: url) { (result: Result<T, Error>) in
                switch result {
                case .failure(let error):
                    errors.append(error)
                case .success(let resource):
                    resources.append(resource)
                }
                group.leave()
            }
        }
        
        DispatchQueue.global().async {
            group.wait()
            
            guard errors.count == 0 else {
                completion?(.failure(errors[0]))    // returns the first error only
                return
            }
            
            completion?(.success(resources))
        }
    }
    
    static func fetch<T: Resource>(url: URL, group: DispatchGroup? = nil, completion: ((Result<[T], Error>) -> ())? = nil) {
        let completion = wrappedCompletion(completion)
        
        if let resources: [T] = Cache.shared.get(url) {
            completion?(.success(resources))
            return
        }
            
        let firstRequest = group == nil
        let group: DispatchGroup = group ?? DispatchGroup()
        group.enter()
        
        var outerResult: [T] = []
        var outerError: Error?
        
        Network.shared.provider.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion?(.failure(SWookieeError.network(underlyingError: error!)))
                return
            }
            
            guard let data = data else {
                completion?(.failure(SWookieeError.data))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .custom(DateFormatter.dateDecoder)
            do {
                let page = try decoder.decode(Page<Self>.self, from: data)
                if let next = page.next {
                    let innerCompletion: (Result<[T], Error>) -> () = { result in
                        guard case .success(let resources) = result else {
                            outerError = error
                            return
                        }
                        outerResult += resources
                    }
                    fetch(url: next, group: group, completion: innerCompletion)
                }
                outerResult += page.results as? [T] ?? []
            } catch let error {
                outerError = error
            }
            
            group.leave()
        }.resume()
        
        if firstRequest {
            DispatchQueue.global().async {
                group.wait()
                
                if outerResult.count > 0 {
                    Cache.shared.set(outerResult, for: url)
                }
                
                if let outerError = outerError {
                    completion?(.failure(outerError))
                } else {
                    completion?(.success(outerResult))
                }
            }
        }
    }
    
    static func wrappedCompletion<T: Resource>(_ completion: ((Result<T, Error>) -> ())? = nil) -> ((Result<T, Error>) -> ())? {
        guard let completion = completion else { return nil }
        return { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    static func wrappedCompletion<T: Resource>(_ completion: ((Result<[T], Error>) -> ())? = nil) -> ((Result<[T], Error>) -> ())? {
        guard let completion = completion else { return nil }
        return { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
}
