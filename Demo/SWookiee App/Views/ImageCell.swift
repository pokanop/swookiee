//
//  ImageCell.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell, ReuseProvider {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let loaderView: LoaderView = LoaderView(mode: .dark)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.5
        
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 2.0
        contentView.layer.cornerRadius = 10.0
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        LayoutPosition.stretch.constraints(for: imageView, relativeTo: contentView).activate()
        
        contentView.addSubview(loaderView)
        LayoutPosition.center.constraints(for: loaderView, relativeTo: contentView).activate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(url: URL) {
        showLoader()
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else {
                    self.hideLoader()
                    return
            }
            
            DispatchQueue.main.async {
                self.hideLoader()
                self.imageView.image = image
            }
        }
    }
    
    private func showLoader() {
        imageView.alpha(0.0, options: [.duration(0.5)])
        loaderView.show()
    }
    
    private func hideLoader() {
        loaderView.hide()
        imageView.alpha(1.0, options: [.duration(0.5)])
    }
    
}
