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
        return UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let kind = SectionLayoutKind(rawValue: sectionIndex) else { return nil }
            let heightDimension: NSCollectionLayoutDimension = kind == .attributes ? .estimated(100.0) : .absolute(44.0)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: heightDimension)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: heightDimension)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
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
