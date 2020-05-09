import Foundation

public struct Root: Resource {
    
    public static var endpoint: Endpoint = .root
    public var id: UUID = UUID()
    
    public var films: URL
    public var people: URL
    public var planets: URL
    public var species: URL
    public var starships: URL
    public var vehicles: URL
    
    enum CodingKeys: String, CodingKey {
        case films, people, planets, species, starships, vehicles
    }
    
}
