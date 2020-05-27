//
//  ResourceViewController.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import SWookiee

class ResourceViewController: UIViewController {
    
    private enum SectionLayoutKind: Int {
        case attributes
        case relationships
    }
    
    var resource: AnyResource!
    var attributes: [String: String] { resource.attributes }
    var attributeNames: [String] { attributes.keys.sorted() }
    var relationshipNames: [String] { resource.relationships.keys.sorted() }
    
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
        }
    }
    
    private lazy var layout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(8.0), top: .fixed(8.0), trailing: .fixed(8.0), bottom: .fixed(8.0))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16.0
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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

        title = resource.name.capitalized
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        LayoutPosition.stretch.constraints(for: collectionView, relativeTo: view).activate()
        
        collectionView.register(AttributeCell.self, forCellWithReuseIdentifier: AttributeCell.reuseIdentifier)
        collectionView.register(RelationshipCell.self, forCellWithReuseIdentifier: RelationshipCell.reuseIdentifier)
        
        var snapshot = Snapshot()
        snapshot.appendSections([.attributes, .relationships])
        snapshot.appendItems(attributeNames, toSection: .attributes)
        snapshot.appendItems(relationshipNames, toSection: .relationships)
        datasource.apply(snapshot, animatingDifferences: false)
    }

}

extension ResourceViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = SectionLayoutKind(rawValue: indexPath.section)!
        guard section == .relationships else { return }
        
        let relationship = relationshipNames[indexPath.row]
        resource.fetch(for: relationship) { resources in
            let vc = ResourcesViewController()
            vc.section = Section.from(title: relationship)!
            vc.resources = resources
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
