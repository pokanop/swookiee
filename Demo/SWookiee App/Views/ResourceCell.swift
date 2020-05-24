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
        label.font = UIFont.starWarsTitleFont
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
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
        
        backgroundImageView.addSubview(label)
        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalTo: backgroundImageView.widthAnchor, multiplier: 0.5),
            label.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor)
        ])
        
        contentView.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: AnyHashable) {
        // Override and configure each cell type
    }
    
    func showLoader() {
        backgroundImageView.alpha(0.3, options: [.duration(0.5)])
        loader.alpha(1.0, options: [.duration(0.5)])
    }
    
    func hideLoader() {
        loader.alpha(0, options: [.duration(0.5)])
        backgroundImageView.alpha(1.0, options: [.duration(0.5)])
    }
    
}
