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

        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.red,
            .font: UIFont.starWarsTitleFont
        ]
    }
    
}
