import Foundation

/// A vehicle resource type from SWAPI.
public struct Vehicle: DecodableResource {
    
    public static let endpoint: Endpoint = .vehicles
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    
    /// The model of this vehicle.
    public let model: String
    
    /// The class of this vehicle.
    public let vehicleClass: String
    
    /// The manufacturer of this vehicle.
    public let manufacturer: String
    
    /// The length of this vehicle.
    public let length: String
    
    /// The cost in credits of this vehicle.
    public let costInCredits: String
    
    /// The crew of this vehicle.
    public let crew: String
    
    /// The passengers of this vehicle.
    public let passengers: String
    
    /// The max atmosphering speed of this vehicle.
    public let maxAtmospheringSpeed: String
    
    /// The cargo capacity of this vehicle.
    public let cargoCapacity: String
    
    /// The consumables of this vehicle.
    public let consumables: String
    
    public let films: [URL]
    
    /// The list of `URL` for pilots of this vehicle.
    public let pilots: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, url, created, model, vehicleClass, manufacturer, length, costInCredits, crew, passengers, maxAtmospheringSpeed, cargoCapacity, consumables, films, pilots
        case updated = "edited"
    }
    
}

extension Vehicle: FilmsProvider, CharactersProvider {
    
    public var characters: [URL] {
        return pilots
    }
    
}
