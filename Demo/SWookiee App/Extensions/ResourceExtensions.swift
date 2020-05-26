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
    var relationships: [Section: [URL]] { get }
    
}

extension AnyResource: DisplayableResource {
    
    var displayableResource: DisplayableResource? { unboxed() }
    var attributes: [String: String] { displayableResource?.attributes ?? [:] }
    var relationships: [Section: [URL]] { displayableResource?.relationships ?? [:] }
    
}

extension Film: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": DateFormatter().string(from: created),
            "Updated": DateFormatter().string(from: updated),
            "Episode": String(describing: episode),
            "Opening Crawl": openingCrawl,
            "Director": director,
            "Producer": producer,
            "Release Date": DateFormatter().string(from: releaseDate)
        ]
    }
    
    var relationships: [Section : [URL]] {
        return [
            .species: species,
            .starships: starships,
            .vehicles: vehicles,
            .people: characters,
            .planets: planets
        ]
    }
    
}

extension Person: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": DateFormatter().string(from: created),
            "Updated": DateFormatter().string(from: updated),
            "Birth Year": birthYear,
            "Eye Color": eyeColor,
            "Gender": gender,
            "Hair Color": hairColor,
            "Height": height,
            "Mass": mass,
            "Skin Color": skinColor
        ]
    }
    
    var relationships: [Section : [URL]] {
        return [
//            .planets: [homeworld],
            .species: species,
            .starships: starships,
            .vehicles: vehicles
        ]
    }
    
}

extension Planet: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": DateFormatter().string(from: created),
            "Updated": DateFormatter().string(from: updated),
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
    
    var relationships: [Section : [URL]] {
        return [
            .people: residents,
            .films: films
        ]
    }
    
}

extension Species: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": DateFormatter().string(from: created),
            "Updated": DateFormatter().string(from: updated),
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
    
    var relationships: [Section : [URL]] {
        return [
            .planets: homeworld != nil ? [homeworld!] : [],
            .people: characters,
            .films: films
        ]
    }
    
}

extension Starship: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": DateFormatter().string(from: created),
            "Updated": DateFormatter().string(from: updated),
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
    
    var relationships: [Section : [URL]] {
        return [
            .films: films,
            .people: pilots
        ]
    }
    
}

extension Vehicle: DisplayableResource {
    
    var attributes: [String : String] {
        return [
            "Name": name,
            "URL": url.absoluteString,
            "Created": DateFormatter().string(from: created),
            "Updated": DateFormatter().string(from: updated),
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
    
    var relationships: [Section : [URL]] {
        return [
            .films: films,
            .people: pilots
        ]
    }
    
}
