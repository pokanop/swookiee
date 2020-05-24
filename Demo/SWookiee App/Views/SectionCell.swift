//
//  SectionCell.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

class SectionCell: ResourceCell {
    
    override func configure(item: AnyHashable) {
        guard let item = item as? Section else { return }
        label.text = item.title
        backgroundImageView.image = item.image
    }
    
}
