import Foundation

/// A person resource type from SWAPI.
public struct Person: DecodableResource {
    
    public static let endpoint: Endpoint = .people
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    
    /// The year of birth of this person.
    public let birthYear: String
    
    /// The eye color of this person.
    public let eyeColor: String
    
    /// The gender of this person.
    public let gender: String
    
    /// The hair color of this person
    public let hairColor: String
    
    /// The height of this person.
    public let height: String
    
    /// The mass of this person.
    public let mass: String
    
    /// The skin color of this person.
    public let skinColor: String
    
    public let homeworld: URL?
    public let films: [URL]
    public let species: [URL]
    public let starships: [URL]
    public let vehicles: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, url, created, birthYear, eyeColor, gender, hairColor, height, mass, skinColor, homeworld, films, species, starships, vehicles
        case updated = "edited"
    }
    
}

extension Person: FilmsProvider, SpeciesProvider, StarshipsProvider, VehiclesProvider, HomeworldProvider {}
