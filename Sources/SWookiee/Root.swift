import Foundation

/// A root resource type from SWAPI.
public struct Root: DecodableResource {
    
    public static let endpoint: Endpoint = .root
    public let id: UUID = UUID()
    
    /// The `URL` for films resources.
    public let films: URL
    
    /// The `URL` for people resources.
    public let people: URL
    
    /// The `URL` for planets resources.
    public let planets: URL
    
    /// The `URL` for species resources.
    public let species: URL
    
    /// The `URL` for starships resources.
    public let starships: URL
    
    /// The `URL` for vehicles resources.
    public let vehicles: URL
    
    enum CodingKeys: String, CodingKey {
        case films, people, planets, species, starships, vehicles
    }
    
}

public extension Root {
    
    static func fetch(completion: ((Result<Self, Error>) -> ())? = nil) {
        fetch(url: endpoint.baseURL, completion: completion)
    }
    
    func films(completion: ((Result<[Film], Error>) -> ())? = nil) {
        Film.fetch(url: films, completion: completion)
    }
    
    func people(completion: ((Result<[Person], Error>) -> ())? = nil) {
        Person.fetch(url: people, completion: completion)
    }
    
    func planets(completion: ((Result<[Planet], Error>) -> ())? = nil) {
        Planet.fetch(url: planets, completion: completion)
    }
    
    func species(completion: ((Result<[Species], Error>) -> ())? = nil) {
        Species.fetch(url: species, completion: completion)
    }
    
    func starships(completion: ((Result<[Starship], Error>) -> ())? = nil) {
        Starship.fetch(url: starships, completion: completion)
    }
    
    func vehicles(completion: ((Result<[Vehicle], Error>) -> ())? = nil) {
        Vehicle.fetch(url: vehicles, completion: completion)
    }
    
}
