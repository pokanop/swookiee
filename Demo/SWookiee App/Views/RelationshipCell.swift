//
//  RelationshipCell.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

class RelationshipCell: UICollectionViewCell, ReuseProvider {
    
    private let loader: Loader = {
        let view = Loader()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    var relationship: Section? {
        didSet { relationshipLabel.text = relationship?.title.capitalized }
    }
    
    private let relationshipLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.starWarsBodyFont
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 10.0
        
        contentView.addSubview(relationshipLabel)
        LayoutPosition.stretch.constraints(for: relationshipLabel, relativeTo: contentView).activate()
        
        contentView.addSubview(loader)
        LayoutPosition.center.constraints(for: loader, relativeTo: contentView).activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLoader() {
        relationshipLabel.alpha(0.0, options: [.duration(0.5)])
        loader.startAnimating()
        loader.alpha(1.0, options: [.duration(0.5)])
    }
    
    func hideLoader() {
        loader.alpha(0, options: [.duration(0.5)]) {
            self.loader.stopAnimating()
        }
        relationshipLabel.alpha(1.0, options: [.duration(0.5)])
    }
    
}
