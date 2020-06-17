import Foundation

/// A film resource type from SWAPI.
public struct Film: DecodableResource {
    
    public static let endpoint: Endpoint = .films
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    
    /// The episode number.
    public let episode: Int
    
    /// The opening crawl shown at the beginning of the movie.
    public let openingCrawl: String
    
    /// The director of the movie.
    public let director: String
    
    /// The producer of the movie.
    public let producer: String
    
    /// The release date of the movie.
    public let releaseDate: Date
    
    public let species: [URL]
    public let starships: [URL]
    public let vehicles: [URL]
    public let characters: [URL]
    public let planets: [URL]
    
    enum CodingKeys: String, CodingKey {
        case url, created, openingCrawl, director, producer, releaseDate, species, starships, vehicles, characters, planets
        case name = "title"
        case updated = "edited"
        case episode = "episodeId"  // Really?? 😒 The decoder should be smarter, if converting from snake_case
    }
    
}

extension Film: CharactersProvider, PlanetsProvider, SpeciesProvider, StarshipsProvider, VehiclesProvider {}
