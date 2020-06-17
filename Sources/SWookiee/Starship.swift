import Foundation

/// A starship resource type from SWAPI.
public struct Starship: DecodableResource {
    
    public static let endpoint: Endpoint = .starships
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    
    /// The model of this starship.
    public let model: String
    
    /// The class of this starship.
    public let starshipClass: String
    
    /// The manufacturer of this starship.
    public let manufacturer: String
    
    /// The cost in credits of this starship.
    public let costInCredits: String
    
    /// The length of this starship.
    public let length: String
    
    /// The crew of this starship.
    public let crew: String
    
    /// The passengers of this starship.
    public let passengers: String
    
    /// The max atmosphering speed of this starship.
    public let maxAtmospheringSpeed: String
    
    /// The hyperdrive rating of this starship.
    public let hyperdriveRating: String
    
    /// The MGLT of this starship.
    public let mglt: String
    
    /// The cargo capacity of this starship.
    public let cargoCapacity: String
    
    /// The consumables of this starship.
    public let consumables: String
    
    public let films: [URL]
    
    /// The list of `URL` for pilots of this starship.
    public let pilots: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, url, created, model, starshipClass, manufacturer, costInCredits, length, crew, passengers, maxAtmospheringSpeed, hyperdriveRating, cargoCapacity, consumables, films, pilots
        case updated = "edited"
        case mglt = "MGLT"
    }
    
}

extension Starship: FilmsProvider, CharactersProvider {
    
    public var characters: [URL] {
        return pilots
    }
    
}
