import Foundation

public protocol CharactersProvider {
    
    /// The list of `URL` for characters related to this resource.
    var characters: [URL] { get }
    
    /// Fetches related characters for this resource.
    ///
    /// - Parameter completion: A completion handler with a result from the request.
    func characters(completion: ((Result<[Person], Error>) -> ())?)
    
}

public extension CharactersProvider {
    
    func characters(completion: ((Result<[Person], Error>) -> ())? = nil) {
        Person.fetch(urls: characters, completion: completion)
    }
    
}

public protocol FilmsProvider {
    
    /// The list of `URL` for films related to this resource.
    var films: [URL] { get }
    
    /// Fetches related films for this resource.
    ///
    /// - Parameter completion: A completion handler with a result from the request.
    func films(completion: ((Result<[Film], Error>) -> ())?)
    
}

public extension FilmsProvider {
    
    func films(completion: ((Result<[Film], Error>) -> ())? = nil) {
        Film.fetch(urls: films, completion: completion)
    }
    
}

public protocol PlanetsProvider {
    
    /// The list of `URL` for planets related to this resource.
    var planets: [URL] { get }
    
    /// Fetches related planets for this resource.
    ///
    /// - Parameter completion: A completion handler with a result from the request.
    func planets(completion: ((Result<[Planet], Error>) -> ())?)
    
}

public extension PlanetsProvider {
    
    func planets(completion: ((Result<[Planet], Error>) -> ())? = nil) {
        Planet.fetch(urls: planets, completion: completion)
    }
    
}

public protocol SpeciesProvider {
    
    /// The list of `URL` for species related to this resource.
    var species: [URL] { get }
    
    /// Fetches related species for this resource.
    ///
    /// - Parameter completion: A completion handler with a result from the request.
    func species(completion: ((Result<[Species], Error>) -> ())?)
    
}

public extension SpeciesProvider {
    
    func species(completion: ((Result<[Species], Error>) -> ())? = nil) {
        Species.fetch(urls: species, completion: completion)
    }
    
}

public protocol StarshipsProvider {
    
    /// The list of `URL` for starships related to this resource.
    var starships: [URL] { get }
    
    /// Fetches related starships for this resource.
    ///
    /// - Parameter completion: A completion handler with a result from the request.
    func starships(completion: ((Result<[Starship], Error>) -> ())?)
    
}

public extension StarshipsProvider {
    
    func starships(completion: ((Result<[Starship], Error>) -> ())? = nil) {
        Starship.fetch(urls: starships, completion: completion)
    }
    
}

public protocol VehiclesProvider {
    
    /// The list of `URL` for vehicles related to this resource.
    var vehicles: [URL] { get }
    
    /// Fetches related vehicles for this resource.
    ///
    /// - Parameter completion: A completion handler with a result from the request.
    func vehicles(completion: ((Result<[Vehicle], Error>) -> ())?)
    
}

public extension VehiclesProvider {
    
    func vehicles(completion: ((Result<[Vehicle], Error>) -> ())? = nil) {
        Vehicle.fetch(urls: vehicles, completion: completion)
    }
    
}

public protocol HomeworldProvider {
    
    /// The related homeworld for this resource.
    var homeworld: URL? { get }
    
    /// Fetches related homeworld for this resource.
    ///
    /// - Parameter completion: A completion handler with a result from the request.
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
