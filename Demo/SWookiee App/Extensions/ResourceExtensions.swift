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

extension AnyResource: DisplayableResource {
    
    var displayableResource: DisplayableResource? { unboxed() }
    var attributes: [String: String] { displayableResource?.attributes ?? [:] }
    var relationships: [Section: [URL]] { displayableResource?.relationships ?? [:] }
    
}
