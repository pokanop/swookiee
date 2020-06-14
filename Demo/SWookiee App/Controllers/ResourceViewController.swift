//
//  ResourceViewController.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import Combine
import SWookiee

class ResourceViewController: UIViewController {
    
    private enum SectionLayoutKind: Int {
        case attributes
        case relationships
        case images
        
        var heightDimension: NSCollectionLayoutDimension {
            switch self {
            case .attributes: return .estimated(100.0)
            case .relationships: return .absolute(44.0)
            case .images: return .absolute(120.0)
            }
        }
        
        var widthDimension: NSCollectionLayoutDimension {
            switch self {
            case .attributes, .relationships: return .fractionalWidth(1.0)
            case .images: return .fractionalWidth(0.3)
            }
        }
    }
    
    var resource: AnyResource!
    private var attributes: [String: String] { resource.attributes }
    private var attributeNames: [String] { attributes.keys.sorted() }
    private var relationshipNames: [String] { resource.relationships.keys.sorted() }
    private var images: [String: Image] = [:]
    private var imageNames: [String] { images.keys.sorted() }
    private var sub: AnyCancellable?
    
    private typealias DataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, String>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, String>
    
    private lazy var datasource: DataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
        let section = SectionLayoutKind(rawValue: indexPath.section)!
        switch section {
        case .attributes:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttributeCell.reuseIdentifier, for: indexPath) as? AttributeCell else { return nil }
            let key = self.attributeNames[indexPath.row]
            cell.key = key
            cell.value = self.attributes[key]
            return cell
        case .relationships:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelationshipCell.reuseIdentifier, for: indexPath) as? RelationshipCell else { return nil }
            cell.relationship = Section.from(title: self.relationshipNames[indexPath.row])!
            return cell
        case .images:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else { return nil }
            let key = self.imageNames[indexPath.row]
            guard let image = self.images[key] else { return cell }
            cell.loadImage(url: image.previewURL)
            return cell
        }
    }
    
    private lazy var layout: UICollectionViewCompositionalLayout = {
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let kind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
            let widthDimension: NSCollectionLayoutDimension = kind.widthDimension
            let heightDimension: NSCollectionLayoutDimension = kind.heightDimension
            let itemSize = NSCollectionLayoutSize(widthDimension: widthDimension, heightDimension: heightDimension)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            if kind == .images {
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8.0, bottom: 0, trailing: 8.0)
            }
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: kind == .images ? 3 : 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
            section.interGroupSpacing = 16.0
            return section
        }
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = resource.name.lowercased()
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        LayoutPosition.stretch.constraints(for: collectionView, relativeTo: view).activate()
        
        collectionView.register(AttributeCell.self, forCellWithReuseIdentifier: AttributeCell.reuseIdentifier)
        collectionView.register(RelationshipCell.self, forCellWithReuseIdentifier: RelationshipCell.reuseIdentifier)
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        
        updateDataSource(animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadImages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sub?.cancel()
    }
    
    private func loadImages() {
        sub = ImageService.shared.search(for: resource.name)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in }) { [weak self] imageList in
                    guard let self = self else { return }
                    imageList.hits.forEach { self.images[$0.pageURL.absoluteString] = $0 }
                    self.updateDataSource()
                }
    }
    
    private func updateDataSource(animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.attributes, .relationships, .images])
        snapshot.appendItems(attributeNames, toSection: .attributes)
        snapshot.appendItems(relationshipNames, toSection: .relationships)
        snapshot.appendItems(imageNames, toSection: .images)
        datasource.apply(snapshot, animatingDifferences: animated)
    }

}

extension ResourceViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = SectionLayoutKind(rawValue: indexPath.section)!
        
        if section == .relationships {
            guard let cell = collectionView.cellForItem(at: indexPath) as? RelationshipCell else { return }
            
            cell.showLoader()
            
            let relationship = relationshipNames[indexPath.row]
            resource.fetch(for: relationship) { resources in
                cell.hideLoader()
                
                let vc = ResourcesViewController()
                vc.section = Section.from(title: relationship)!
                vc.resources = resources
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if section == .images {
            let key = imageNames[indexPath.row]
            guard let image = images[key] else { return }
            
            let vc = ImageViewController()
            vc.loadImage(url: image.largeImageURL)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RelationshipCell else { return }
        cell.contentView.alpha = 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? RelationshipCell else { return }
        cell.contentView.alpha = 1.0
    }
    
}
