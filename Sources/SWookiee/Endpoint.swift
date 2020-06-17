import Foundation

/// A type to represent SWAPI endpoints.
public enum Endpoint: String, CaseIterable {
    
    case root, films, people, planets, species, starships, vehicles
    
    /// The `URL` including the path of the endpoint.
    public var baseURL: URL {
        switch self {
        case .root: return URL(string: "https://swapi.dev/api/")!
        case .films: return URL(string: "https://swapi.dev/api/films/")!
        case .people: return URL(string: "https://swapi.dev/api/people/")!
        case .planets: return URL(string: "https://swapi.dev/api/planets/")!
        case .species: return URL(string: "https://swapi.dev/api/species/")!
        case .starships: return URL(string: "https://swapi.dev/api/starships/")!
        case .vehicles: return URL(string: "https://swapi.dev/api/vehicles/")!
        }
    }
    
    /// Constructs a `URL` from this endpoint and a given id.
    ///
    /// - Parameter id: The id of the resource.
    /// - Returns: The constructed `URL` for the resources.
    public func itemURL(id: Int) -> URL {
        return baseURL.appendingPathComponent("\(id)/")
    }
    
    /// Constructs a `URL` from this endpoint and a given page.
    ///
    /// - Parameter id: The page for the resources.
    /// - Returns: The constructed `URL` for the resources.
    public func pageURL(page: Int) -> URL {
        assert(self != .root)
        return baseURL.appendingPathComponent("?page=\(page)")
    }
    
    /// Constructs a `URL` from this endpoint and a given search term.
    ///
    /// - Parameter search: The search term to find resources.
    /// - Returns: The constructed `URL` for the resources.
    public func searchURL(search: String) -> URL {
        assert(self != .root)
        return baseURL.appendingPathComponent("?search=\(search)")
    }
    
}

extension URL {
    
    enum EndpointStyle {
        case none, root, resource, item, page, search
    }
    
    var endpoint: Endpoint? {
        guard Endpoint.root.baseURL != self else { return .root }
        return Endpoint.allCases.filter { $0 != .root }.first { self.absoluteString.contains($0.baseURL.absoluteString) }
    }
    
    var endpointStyle: EndpointStyle {
        guard let endpoint = endpoint else { return .none }
        switch endpoint {
        case .root: return .root
        default:
            if absoluteString.contains("?page=") { return .page }
            if absoluteString.contains("?search=") { return .search }
            if absoluteString == endpoint.baseURL.absoluteString { return .resource }
            if Int(lastPathComponent) != nil { return .item }
            return .none
        }
    }
    
    var isPagedResults: Bool {
        switch endpointStyle {
        case .resource, .page, .search: return true
        default: return false
        }
    }
    
}
