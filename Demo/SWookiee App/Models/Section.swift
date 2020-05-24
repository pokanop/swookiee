//
//  Section.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

enum Section: Int, CaseIterable {
    case films, people, planets, species, starships, vehicles
    
    var title: String {
        switch self {
        case .films: return "Films"
        case .people: return "People"
        case .planets: return "Planets"
        case .species: return "Species"
        case .starships: return "Starships"
        case .vehicles: return "Vehicles"
        }
    }
    
    var cellType: ResourceCell.Type {
        switch self {
        case .films: return FilmCell.self
        case .people: return PersonCell.self
        case .planets: return PlanetCell.self
        case .species: return SpeciesCell.self
        case .starships: return StarshipCell.self
        case .vehicles: return VehicleCell.self
        }
    }
    
    var reuseIdentifier: String {
        return cellType.reuseIdentifier
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
    
    func registerCell(in collectionView: UICollectionView) {
        collectionView.register(cellType, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueCell(from collectionView: UICollectionView, for indexPath: IndexPath, with item: AnyHashable) -> ResourceCell? {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ResourceCell else { return nil }
        cell.configure(item: item)
        return cell
    }
}
