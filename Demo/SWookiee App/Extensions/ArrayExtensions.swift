//
//  ArrayExtensions.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit

extension Array where Element == NSLayoutConstraint {
    
    func activate() {
        NSLayoutConstraint.activate(self)
    }
    
    func deactivate() {
        NSLayoutConstraint.deactivate(self)
    }
    
}
