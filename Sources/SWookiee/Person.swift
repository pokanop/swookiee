import Foundation

public struct Person: DecodableResource {
    
    public static let endpoint: Endpoint = .people
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    public let birthYear: String
    public let eyeColor: String
    public let gender: String
    public let hairColor: String
    public let height: String
    public let mass: String
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
