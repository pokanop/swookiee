//
//  ResourceCell.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import SWookiee

class ResourceCell: UICollectionViewCell, ReuseProvider {
    
    private let starfieldView: StarfieldView = StarfieldView()
    
    private let loaderView: LoaderView = {
        let view = LoaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.starWarsBodyFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .yellow
        return label
    }()
    
    let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowRadius = 7.0
        layer.shadowOpacity = 0.7
        
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(backgroundImageView)
        LayoutPosition.stretch.constraints(for: backgroundImageView, relativeTo: contentView).activate()
        
        backgroundImageView.addSubview(starfieldView)
        LayoutPosition.stretch.constraints(for: starfieldView, relativeTo: backgroundImageView).activate()
        
        backgroundImageView.addSubview(label)
        LayoutPosition.center.constraints(for: label, relativeTo: backgroundImageView).activate()
        LayoutPosition.width.constraints(for: label, relativeTo: backgroundImageView, padding: 8.0).activate()
        
        contentView.addSubview(loaderView)
        LayoutPosition.center.constraints(for: loaderView, relativeTo: contentView).activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: AnyResource) {
        // Override and configure each cell type
        label.text = item.name.lowercased()
    }
    
    func showLoader() {
        backgroundImageView.alpha(0.3, options: [.duration(0.5)])
        loaderView.show()
    }
    
    func hideLoader() {
        loaderView.hide()
        backgroundImageView.alpha(1.0, options: [.duration(0.5)])
    }
    
}
