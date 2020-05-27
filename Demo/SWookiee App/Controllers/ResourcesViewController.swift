//
//  ResourcesViewController.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import SWookiee

class ResourcesViewController: UIViewController {
    
    private enum SectionLayoutKind {
        case main
    }
    
    var section: Section!
    var resources: [AnyResource] = []
    
    private typealias DataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, AnyResource>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, AnyResource>
    
    private lazy var datasource: DataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.section.reuseIdentifier, for: indexPath) as? ResourceCell else { return nil }
        cell.configure(item: self.resources[indexPath.row])
        return cell
    }
    
    private lazy var layout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 16.0, leading: 8.0, bottom: 0, trailing: 8.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8.0, bottom: 0, trailing: 8.0)
        let section = NSCollectionLayoutSection(group: group)
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

        title = section.title.capitalized
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        LayoutPosition.stretch.constraints(for: collectionView, relativeTo: view).activate()
        
        collectionView.register(SectionCell.self, forCellWithReuseIdentifier: SectionCell.reuseIdentifier)
        
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(resources)
        datasource.apply(snapshot, animatingDifferences: false)
    }

}

extension ResourcesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ResourceViewController()
        vc.resource = resources[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
