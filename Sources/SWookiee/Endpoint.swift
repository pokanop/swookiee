import Foundation

public enum Endpoint: String, CaseIterable {
    
    case root, films, people, planets, species, starships, vehicles
    
    var baseURL: URL {
        switch self {
        case .root: return URL(string: "https://swapi.dev/api/")!
        case .films: return URL(string: "https://swapi.dev/api/films/")!
        case .people: return URL(string: "https://swapi.dev/api/people/")!
        case .planets: return URL(string: "https://swapi.dev/api/planets/")!
        case .species: return URL(string: "https://swapi.dev/api/species/")!
        case .starships: return URL(string: "https://swapi.dev/api/starships/")!
        case .vehicles: return URL(string: "https://swapi.dev/api/vehicles/")!
        }
    }
    
    func itemURL(id: Int) -> URL {
        return baseURL.appendingPathComponent("\(id)/")
    }
    
}

extension URL {
    
    var isEndpoint: Bool {
        return Endpoint.allCases.filter { $0.baseURL == self }.count > 0
    }
    
    var isRootEndpoint: Bool {
        return self == Endpoint.root.baseURL
    }
    
}
