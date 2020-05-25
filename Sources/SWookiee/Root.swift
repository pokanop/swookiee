import Foundation

public struct Root: DecodableResource {
    
    public static let endpoint: Endpoint = .root
    public let id: UUID = UUID()
    public let films: URL
    public let people: URL
    public let planets: URL
    public let species: URL
    public let starships: URL
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
