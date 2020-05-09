import Foundation

public struct Person: Resource {
    
    public static var endpoint: Endpoint = .people
    public var id: UUID = UUID()
    public var name: String
    public var url: URL
    public var created: Date
    public var updated: Date
    
    public var birthYear: String
    public var eyeColor: String
    public var gender: String
    public var hairColor: String
    public var height: String
    public var mass: String
    public var skinColor: String
    public var homeworld: String
    public var films: [URL]
    public var species: [URL]
    public var starships: [URL]
    public var vehicles: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, url, created, birthYear, eyeColor, gender, hairColor, height, mass, skinColor, homeworld, films, species, starships, vehicles
        case updated = "edited"
    }
    
}
