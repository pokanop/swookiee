//
//  ImageViewController.swift
//  SWookiee App
//
//  Created by Sahel Jalal on 6/14/20.
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let loaderView: LoaderView = LoaderView(mode: .dark)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "image"
        view.backgroundColor = .white

        view.addSubview(imageView)
        LayoutPosition.stretch.constraints(for: imageView, relativeTo: view).activate()
        
        view.addSubview(loaderView)
        LayoutPosition.center.constraints(for: loaderView, relativeTo: view).activate()
    }
    
    func loadImage(url: URL) {
        if let image = ImageService.shared.get(url: url) {
            imageView.image = image
            return
        }
        
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
