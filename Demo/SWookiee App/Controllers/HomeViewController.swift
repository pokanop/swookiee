//
//  HomeViewController.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import SWookiee

class HomeViewController: UIViewController {
    
    private enum SectionLayoutKind {
        case main
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<SectionLayoutKind, Section>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<SectionLayoutKind, Section>
    
    private lazy var datasource: DataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCell.reuseIdentifier, for: indexPath) as? SectionCell else { return nil }
        cell.configure(item: Section.allCases[indexPath.row])
        return cell
    }
    
    private lazy var layout: UICollectionViewCompositionalLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 12.0, leading: 16.0, bottom: 12.0, trailing: 16.0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        collectionView.register(SectionCell.self, forCellWithReuseIdentifier: SectionCell.reuseIdentifier)
        
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(Section.allCases)
        datasource.apply(snapshot, animatingDifferences: false)
    }

}
