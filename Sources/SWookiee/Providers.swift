import Foundation

public protocol CharactersProvider {
    
    var characters: [URL] { get }
    
    func characters(completion: ((Result<[Person], Error>) -> ())?)
    
}

public extension CharactersProvider {
    
    func characters(completion: ((Result<[Person], Error>) -> ())? = nil) {
        Person.fetch(urls: characters, completion: completion)
    }
    
}

public protocol FilmsProvider {
    
    var films: [URL] { get }
    
    func films(completion: ((Result<[Film], Error>) -> ())?)
    
}

public extension FilmsProvider {
    
    func films(completion: ((Result<[Film], Error>) -> ())? = nil) {
        Film.fetch(urls: films, completion: completion)
    }
    
}

public protocol PlanetsProvider {
    
    var planets: [URL] { get }
    
    func planets(completion: ((Result<[Planet], Error>) -> ())?)
    
}

public extension PlanetsProvider {
    
    func planets(completion: ((Result<[Planet], Error>) -> ())? = nil) {
        Planet.fetch(urls: planets, completion: completion)
    }
    
}

public protocol SpeciesProvider {
    
    var species: [URL] { get }
    
    func species(completion: ((Result<[Species], Error>) -> ())?)
    
}

public extension SpeciesProvider {
    
    func species(completion: ((Result<[Species], Error>) -> ())? = nil) {
        Species.fetch(urls: species, completion: completion)
    }
    
}

public protocol StarshipsProvider {
    
    var starships: [URL] { get }
    
    func starships(completion: ((Result<[Starship], Error>) -> ())?)
    
}

public extension StarshipsProvider {
    
    func starships(completion: ((Result<[Starship], Error>) -> ())? = nil) {
        Starship.fetch(urls: starships, completion: completion)
    }
    
}

public protocol VehiclesProvider {
    
    var vehicles: [URL] { get }
    
    func vehicles(completion: ((Result<[Vehicle], Error>) -> ())?)
    
}

public extension VehiclesProvider {
    
    func vehicles(completion: ((Result<[Vehicle], Error>) -> ())? = nil) {
        Vehicle.fetch(urls: vehicles, completion: completion)
    }
    
}

public protocol HomeworldProvider {
    
    var homeworld: URL? { get }
    
    func homeworld(completion: ((Result<Planet, Error>) -> ())?)
    
}

public extension HomeworldProvider {
    
    func homeworld(completion: ((Result<Planet, Error>) -> ())? = nil) {
        guard let homeworld = homeworld else {
            completion?(.failure(SWookieeError.data))
            return
        }
        Planet.fetch(url: homeworld, completion: completion)
    }
    
}
