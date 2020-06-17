import Foundation

/// A species resource type from SWAPI.
public struct Species: DecodableResource {
    
    public static let endpoint: Endpoint = .species
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    
    /// The classification of this species.
    public let classification: String
    
    /// The desigation of this species.
    public let designation: String
    
    /// The average height of this species.
    public let averageHeight: String
    
    /// The average lifespan of this species.
    public let averageLifespan: String
    
    /// The eye colors of this species.
    public let eyeColors: String
    
    /// The hair colors of this species.
    public let hairColors: String
    
    /// The skin colors of this species.
    public let skinColors: String
    
    /// The language of this species.
    public let language: String
    
    public let homeworld: URL?
    
    /// The list of `URL` for people of this species.
    public let people: [URL]
    
    public let films: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, url, created, classification, designation, averageHeight, averageLifespan, eyeColors, hairColors, skinColors, language, homeworld, people, films
        case updated = "edited"
    }
    
}

extension Species: CharactersProvider, FilmsProvider, HomeworldProvider {
    
    public var characters: [URL] {
        return people
    }
    
}
