//
//  SectionCell.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

class SectionCell: ResourceCell {
    
    var section: Section?
    
    override func configure(item: AnyHashable) {
        guard let item = item as? Section else { return }
        section = item
        label.text = item.title
        backgroundImageView.image = item.image
    }
    
}
