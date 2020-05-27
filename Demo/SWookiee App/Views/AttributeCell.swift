//
//  AttributeCell.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

class AttributeCell: UICollectionViewCell, ReuseProvider {
    
    var key: String? {
        didSet { keyLabel.text = key }
    }
    
    var value: String? {
        didSet { valueLabel.text = value }
    }
    
    private let keyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.starWarsBodyFont
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.starWarsBodyFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(keyLabel)
        contentView.addSubview(valueLabel)
        
        [
            keyLabel.widthAnchor.constraint(equalTo: valueLabel.widthAnchor, multiplier: 0.5),
            keyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            keyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            keyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            keyLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -16.0),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ].activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
