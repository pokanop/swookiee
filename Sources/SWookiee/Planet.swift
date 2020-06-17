import Foundation

/// A planet resource type from SWAPI.
public struct Planet: DecodableResource {
    
    public static let endpoint: Endpoint = .planets
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    
    /// The diameter of this planet.
    public let diameter: String
    
    /// The rotation period of this planet.
    public let rotationPeriod: String
    
    /// The orbital period of this planet.
    public let orbitalPeriod: String
    
    /// The gravity of this planet.
    public let gravity: String
    
    /// The population of this planet.
    public let population: String
    
    /// The climate of this planet.
    public let climate: String
    
    /// The terrain of this planet.
    public let terrain: String
    
    /// The surface water of this planet.
    public let surfaceWater: String
    
    /// The list of `URL` for residents of this planet.
    public let residents: [URL]
    
    public let films: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, url, created, diameter, rotationPeriod, orbitalPeriod, gravity, population, climate, terrain, surfaceWater, residents, films
        case updated = "edited"
    }
    
}

extension Planet: CharactersProvider, FilmsProvider {
    
    public var characters: [URL] {
        return residents
    }
    
}
