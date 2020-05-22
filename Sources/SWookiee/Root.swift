import Foundation

public struct Root: Resource {
    
    public static let endpoint: Endpoint = .root
    public let id: UUID = UUID()
    public let films: URL
    public let people: URL
    public let planets: URL
    public let species: URL
    public let starships: URL
    public let vehicles: URL
    
    enum CodingKeys: String, CodingKey {
        case films, people, planets, species, starships, vehicles
    }
    
}

public extension Root {
    
    static func fetch(completion: ((Result<Self, Error>) -> ())? = nil) {
        fetch(url: endpoint.baseURL, completion: completion)
    }
    
}
