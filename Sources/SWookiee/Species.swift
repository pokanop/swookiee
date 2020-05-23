import Foundation

public struct Species: Resource {
    
    public static let endpoint: Endpoint = .species
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    public let classification: String
    public let designation: String
    public let averageHeight: String
    public let averageLifespan: String
    public let eyeColors: String
    public let hairColors: String
    public let skinColors: String
    public let language: String
    public let homeworld: URL?
    public let people: [URL]
    public let films: [URL]
    
    enum CodingKeys: String, CodingKey {
        case name, url, created, classification, designation, averageHeight, averageLifespan, eyeColors, hairColors, skinColors, language, homeworld, people, films
        case updated = "edited"
    }
    
}

extension Species: CharactersProvider, FilmsProvider {
    
    public var characters: [URL] {
        return people
    }
    
    public func homeworld(completion: ((Result<Planet, Error>) -> ())? = nil) {
        guard let homeworld = homeworld else {
            completion?(.failure(SWookieeError.data))
            return
        }
        Planet.fetch(url: homeworld, completion: completion)
    }
    
}
