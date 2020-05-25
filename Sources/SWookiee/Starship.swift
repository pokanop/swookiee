import Foundation

public struct Starship: DecodableResource {
    
    public static let endpoint: Endpoint = .starships
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    public let model: String
    public let starshipClass: String
    public let manufacturer: String
    public let costInCredits: String
    public let length: String
    public let crew: String
    public let passengers: String
    public let maxAtmospheringSpeed: String
    public let hyperdriveRating: String
    public let mglt: String
    public let cargoCapacity: String
    public let consumables: String
    public let films: [URL]
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
