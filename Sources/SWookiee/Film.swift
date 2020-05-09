import Foundation

public struct Film: Resource {
    
    public static var endpoint: Endpoint = .films
    public var id: UUID = UUID()
    public var name: String
    public var url: URL
    public var created: Date
    public var updated: Date
    public var episode: Int
    public var openingCrawl: String
    public var director: String
    public var producer: String
    public var releaseDate: Date
    public var species: [URL]
    public var starships: [URL]
    public var vehicles: [URL]
    public var characters: [URL]
    public var planets: [URL]
    
    enum CodingKeys: String, CodingKey {
        case url, created, openingCrawl, director, producer, releaseDate, species, starships, vehicles, characters, planets
        case name = "title"
        case updated = "edited"
        case episode = "episodeId"  // Really?? 😒 The decoder should be smarter, if converting from snake_case
    }
}
