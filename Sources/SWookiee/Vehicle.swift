import Foundation

public struct Vehicle: Resource {
    
    public static let endpoint: Endpoint = .vehicles
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    public let model: String
    public let vehicleClass: String
    public let manufacturer: String
    public let length: String
    public let costInCredits: String
    public let crew: String
    public let passengers: String
    public let maxAtmospheringSpeed: String
    public let cargoCapacity: String
    public let consumables: String
    public let films: [URL]
    public let pilots: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, url, created, model, vehicleClass, manufacturer, length, costInCredits, crew, passengers, maxAtmospheringSpeed, cargoCapacity, consumables, films, pilots
        case updated = "edited"
    }
    
}
