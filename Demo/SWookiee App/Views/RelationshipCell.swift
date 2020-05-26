//
//  RelationshipCell.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

class RelationshipCell: UICollectionViewCell, ReuseProvider {
    
    var relationship: Section? {
        didSet { relationshipLabel.text = relationship?.title.capitalized }
    }
    
    private let relationshipLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.starWarsBodyFont
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(relationshipLabel)
        LayoutPosition.stretch.constraints(for: relationshipLabel, relativeTo: contentView).activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
