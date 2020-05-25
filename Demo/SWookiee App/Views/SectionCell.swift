//
//  SectionCell.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import SWookiee

class SectionCell: ResourceCell {
    
    var section: Section? {
        didSet {
            guard let section = section else { return }
            label.text = section.title
            backgroundImageView.image = section.image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = UIFont.starWarsTitleFont
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
