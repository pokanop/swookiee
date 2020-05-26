//
//  Section.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import SWookiee

enum Section: Int, CaseIterable, Comparable {
    
    case films, people, planets, species, starships, vehicles
    
    static func < (lhs: Section, rhs: Section) -> Bool {
        return lhs.title < rhs.title
    }
    
    var title: String {
        switch self {
        case .films: return "films"
        case .people: return "people"
        case .planets: return "planets"
        case .species: return "species"
        case .starships: return "starships"
        case .vehicles: return "vehicles"
        }
    }
    
    
    var reuseIdentifier: String {
        return SectionCell.reuseIdentifier
    }
    
    var image: UIImage {
        switch self {
        case .films: return UIImage(named: "films")!
        case .people: return UIImage(named: "people")!
        case .planets: return UIImage(named: "planets")!
        case .species: return UIImage(named: "species")!
        case .starships: return UIImage(named: "starships")!
        case .vehicles: return UIImage(named: "vehicles")!
        }
    }
    
    static func from(title: String) -> Section? {
        switch title.lowercased() {
        case "films": return .films
        case "people", "characters", "pilots", "residents": return .people
        case "planets", "homeworld": return .planets
        case "species": return .species
        case "starships": return .starships
        case "vehicles": return .vehicles
        default: return nil
        }
    }
    
    func registerCell(in collectionView: UICollectionView) {
        collectionView.register(SectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueCell(from collectionView: UICollectionView, for indexPath: IndexPath, with item: AnyResource) -> ResourceCell? {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ResourceCell else { return nil }
        cell.configure(item: item)
        return cell
    }
    
    func fetch(completion: @escaping ([AnyResource]) -> ()) {
        switch self {
        case .films: Film.fetch(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case .people: Person.fetch(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case .planets: Planet.fetch(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case .species: Species.fetch(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case .starships: Starship.fetch(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        case .vehicles: Vehicle.fetch(completion: { completion(((try? $0.get()) ?? []).map { AnyResource($0) }) })
        }
    }
    
}
