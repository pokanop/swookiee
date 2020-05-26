//
//  ResourceCell.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import SWookiee

class ResourceCell: UICollectionViewCell, ReuseProvider {
    
    private let loader: Loader = {
        let view = Loader()
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
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 1.0
        
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(backgroundImageView)
        LayoutPosition.stretch.constraints(for: backgroundImageView, relativeTo: contentView).activate()
        
        backgroundImageView.addSubview(label)
        LayoutPosition.center.constraints(for: label, relativeTo: backgroundImageView).activate()
        LayoutPosition.width.constraints(for: label, relativeTo: backgroundImageView).activate()
        
        contentView.addSubview(loader)
        LayoutPosition.center.constraints(for: loader, relativeTo: contentView).activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: AnyResource) {
        // Override and configure each cell type
        label.text = item.name
    }
    
    func showLoader() {
        backgroundImageView.alpha(0.3, options: [.duration(0.5)])
        loader.startAnimating()
        loader.alpha(1.0, options: [.duration(0.5)])
    }
    
    func hideLoader() {
        loader.alpha(0, options: [.duration(0.5)]) {
            self.loader.stopAnimating()
        }
        backgroundImageView.alpha(1.0, options: [.duration(0.5)])
    }
    
}
