//
//  ResourcesViewController.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import SWookiee

class ResourcesViewController: UIViewController {
    
    var section: Section!
    var resources: [AnyResource] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = section.title
        view.backgroundColor = .white
    }

}
