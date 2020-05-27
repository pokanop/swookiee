//
//  ResourceExtensions.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import Foundation
import SWookiee

protocol DisplayableResource {
    
    var attributes: [String: String] { get }
    var relationships: [String: Section] { get }
    
    func fetch(for relationship: String, completion: @escaping ([AnyResource]) -> ())
}

extension DisplayableResource {
    
    fileprivate func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
}

extension AnyResource: DisplayableResource {
    
    var displayableResource: DisplayableResource? { unboxed() }
    var attributes: [String: String] { displayableResource?.attributes ?? [:] }
    var relationships: [String: Section] { displayableResource?.relationships ?? [:] }
    
    func fetch(for relationship: String, completion: @escaping ([AnyResource]) -> ()) {
        displayableResource?.fetch(for: relationship, completion: completion)
    }
    
}

extension Film: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": dateString(from: created),
            "Updated": dateString(from: updated),
            "Episode": String(describing: episode),
            "Opening Crawl": openingCrawl,
            "Director": director,
            "Producer": producer,
            "Release Date": dateString(from: releaseDate)
        ]
    }
    
    var relationships: [String: Section] {
        return [
            "Species": .species,
            "Starships": .starships,
            "Vehicles": .vehicles,
            "Characters": .people,
            "Planets": .planets
        ]
    }
    
    func fetch(for relationship: String, completion: @escaping ([AnyResource]) -> ()) {
        switch relationship {
        case "Species": species(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case "Starships": starships(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case "Vehicles": vehicles(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case "Characters": characters(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case "Planets": planets(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        default: completion([])
        }
    }
    
}

extension Person: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": dateString(from: created),
            "Updated": dateString(from: updated),
            "Birth Year": birthYear,
            "Eye Color": eyeColor,
            "Gender": gender,
            "Hair Color": hairColor,
            "Height": height,
            "Mass": mass,
            "Skin Color": skinColor
        ]
    }
    
    var relationships: [String: Section] {
        return [
            "Species": .species,
            "Starships": .starships,
            "Vehicles": .vehicles
        ]
    }
    
    func fetch(for relationship: String, completion: @escaping ([AnyResource]) -> ()) {
        switch relationship {
        case "Species": species(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case "Starships": starships(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case "Vehicles": vehicles(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        default: completion([])
        }
    }
    
}

extension Planet: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": dateString(from: created),
            "Updated": dateString(from: updated),
            "Diameter": diameter,
            "Rotation Period": rotationPeriod,
            "Orbital Period": orbitalPeriod,
            "Gravity": gravity,
            "Population": population,
            "Climate": climate,
            "Terrain": terrain,
            "Surface Water": surfaceWater
        ]
    }
    
    var relationships: [String: Section] {
        return [
            "Residents": .people,
            "Films": .films
        ]
    }
    
    func fetch(for relationship: String, completion: @escaping ([AnyResource]) -> ()) {
        switch relationship {
        case "Residents": characters(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case "Films": films(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        default: completion([])
        }
    }
    
}

extension Species: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": dateString(from: created),
            "Updated": dateString(from: updated),
            "Classification": classification,
            "Designation": designation,
            "Average Height": averageHeight,
            "Average Lifespan": averageLifespan,
            "Eye Colors": eyeColors,
            "Hair Colors": hairColors,
            "Skin Colors": skinColors,
            "Language": language
        ]
    }
    
    var relationships: [String: Section] {
        return [
            "Homeworld": .planets,
            "Characters": .people,
            "Films": .films
        ]
    }
    
    func fetch(for relationship: String, completion: @escaping ([AnyResource]) -> ()) {
        switch relationship {
        case "Characters": characters(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case "Films": films(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        default: completion([])
        }
    }
    
}

extension Starship: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": dateString(from: created),
            "Updated": dateString(from: updated),
            "model": model,
            "Starship Class": starshipClass,
            "Manufacturer": manufacturer,
            "Cost In Credits": costInCredits,
            "Length": length,
            "Crew": crew,
            "Passengers": passengers,
            "Max Atmosphering Speed": maxAtmospheringSpeed,
            "Hyperdrive Rating": hyperdriveRating,
            "MGLT": mglt,
            "Cargo Capacity": cargoCapacity,
            "Consumables": consumables
        ]
    }
    
    var relationships: [String: Section] {
        return [
            "Films": .films,
            "Pilots": .people
        ]
    }
    
    func fetch(for relationship: String, completion: @escaping ([AnyResource]) -> ()) {
        switch relationship {
        case "Films": films(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case "Pilots": characters(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        default: completion([])
        }
    }
    
}

extension Vehicle: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": dateString(from: created),
            "Updated": dateString(from: updated),
            "Model": model,
            "Vehicle Class": vehicleClass,
            "Manufacturer": manufacturer,
            "Length": length,
            "Cost In Credits": costInCredits,
            "Crew": crew,
            "Passengers": passengers,
            "Max Atmosphering Speed": maxAtmospheringSpeed,
            "Cargo Capacity": cargoCapacity,
            "Consumables": consumables
        ]
    }
    
    var relationships: [String: Section] {
        return [
            "Films": .films,
            "Pilots": .people
        ]
    }
    
    func fetch(for relationship: String, completion: @escaping ([AnyResource]) -> ()) {
        switch relationship {
        case "Films": films(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case "Pilots": characters(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        default: completion([])
        }
    }
    
}
