//
//  NavigationController.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let normalAppearance = appearance(forCompact: false)
        navigationBar.standardAppearance = normalAppearance
        navigationBar.scrollEdgeAppearance = normalAppearance
        navigationBar.compactAppearance = appearance(forCompact: true)
    }
    
    private func appearance(forCompact compact: Bool) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.red,
            .font: compact ? UIFont.starWarsBodyFont : UIFont.starWarsBarFont
        ]
        return appearance
    }
    
}
