import Foundation

public struct Planet: Resource {
    
    public static let endpoint: Endpoint = .planets
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    public let diameter: String
    public let rotationPeriod: String
    public let orbitalPeriod: String
    public let gravity: String
    public let population: String
    public let climate: String
    public let terrain: String
    public let surfaceWater: String
    public let residents: [URL]
    public let films: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, url, created, diameter, rotationPeriod, orbitalPeriod, gravity, population, climate, terrain, surfaceWater, residents, films
        case updated = "edited"
    }
    
}
