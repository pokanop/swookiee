import Foundation

/// A generic type representing a resource available from SWAPI.
public protocol Resource: Hashable {
    
    /// The endpoint for the resource.
    static var endpoint: Endpoint { get }
    
    /// A unique id for the resource.
    var id: UUID { get }
    
    /// The name of the resource.
    var name: String { get }
    
    /// The `URL` for this resource.
    var url: URL { get }
    
    /// The date this resource was created.
    var created: Date { get }
    
    /// The date this resource was updated.
    var updated: Date { get }
    
}

/// A customized type for decoding `Resource` types
public protocol DecodableResource: Resource & Decodable {}

public extension DecodableResource {
    
    var name: String { Self.endpoint.rawValue }
    var url: URL { Self.endpoint.baseURL }
    var created: Date { Date.distantPast }
    var updated: Date { Date.distantPast }
    
    /// Fetch a resource for a given id.
    ///
    /// - Parameters:
    ///   - id: The id of a resource to fetch.
    ///   - completion: A completion handler with a result from the request.
    static func fetch(id: Int, completion: ((Result<Self, Error>) -> ())? = nil) {
        fetch(url: endpoint.itemURL(id: id), completion: completion)
    }
    
    /// Fetch a set of resources for a given page.
    ///
    /// - Parameters:
    ///   - page: The page of the resources to fetch.
    ///   - completion: A completion handler with a result from the request.
    static func fetch(page: Int, completion: ((Result<[Self], Error>) -> ())? = nil) {
        fetch(url: endpoint.pageURL(page: page), completion: completion)
    }
    
    /// Fetch a set of resources for a given search term.
    ///
    /// - Parameters:
    ///   - search: The term to search for when fetching resources.
    ///   - completion: A completion handler with a result from the request.
    static func fetch(search: String, completion: ((Result<[Self], Error>) -> ())? = nil) {
        fetch(url: endpoint.searchURL(search: search), completion: completion)
    }
    
    /// Fetch all resources of this type.
    ///
    /// - Note: This method will automatically follow all pages and aggregate all the resources
    /// before calling the completion handler with the result.
    ///
    /// - Parameters:
    ///   - completion: A completion handler with a result from the request.
    static func fetch(completion: ((Result<[Self], Error>) -> ())? = nil) {
        fetch(url: endpoint.baseURL, completion: completion)
    }
    
}

extension DecodableResource {
    
    static func fetch<T: DecodableResource>(url: URL, completion: ((Result<T, Error>) -> ())? = nil) {
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
    
    static func fetch<T: DecodableResource>(urls: [URL], completion: ((Result<[T], Error>) -> ())? = nil) {
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
    
    static func fetch<T: DecodableResource>(url: URL, completion: ((Result<[T], Error>) -> ())? = nil) {
        let completion = wrappedCompletion(completion)
        
        if let resources: [T] = Cache.shared.get(url) {
            completion?(.success(resources))
            return
        }
        
        let group = DispatchGroup()
        var results: [T]?
        var errors: [Error]?
        
        fetch(url: url, group: group) { (r: [T], e: [Error]) in
            results = r
            errors = e
        }
        
        // Wait for all requests to complete before caching and calling completion
        DispatchQueue.global().async {
            group.wait()
            
            if let errors = errors, errors.count > 0 {
                completion?(.failure(errors[0]))
            } else if let results = results {
                Cache.shared.set(results, for: url)
                completion?(.success(results))
            } else {
                completion?(.failure(SWookieeError.data))
            }
        }
    }
    
    private static func fetch<T: DecodableResource>(url: URL, group: DispatchGroup, completion: @escaping ([T], [Error]) -> ()) {
        group.enter()
        
        Network.shared.provider.dataTask(with: url) { (data, response, error) in
            DispatchQueue.global().async {
                let dsema = DispatchSemaphore(value: 0)
                var results: [T] = []
                var errors: [Error] = []
                
                defer {
                    dsema.wait()
                    completion(results, errors)
                    group.leave()
                }
                
                guard error == nil else {
                    errors.append(SWookieeError.network(underlyingError: error!))
                    return
                }
                
                guard let data = data else {
                    errors.append(SWookieeError.data)
                    return
                }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .custom(DateFormatter.dateDecoder)
                do {
                    let page = try decoder.decode(Page<Self>.self, from: data)
                    results += page.results as? [T] ?? []
                    
                    if let next = page.next {
                        fetch(url: next, group: group) { (r: [T], e: [Error]) in
                            results += r
                            errors += e
                            
                            dsema.signal()
                        }
                    } else {
                        dsema.signal()
                    }
                } catch let error {
                    errors.append(error)
                    dsema.signal()
                }
            }
        }.resume()
    }
    
    private static func wrappedCompletion<T: DecodableResource>(_ completion: ((Result<T, Error>) -> ())? = nil) -> ((Result<T, Error>) -> ())? {
        guard let completion = completion else { return nil }
        return { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    private static func wrappedCompletion<T: DecodableResource>(_ completion: ((Result<[T], Error>) -> ())? = nil) -> ((Result<[T], Error>) -> ())? {
        guard let completion = completion else { return nil }
        return { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
}
