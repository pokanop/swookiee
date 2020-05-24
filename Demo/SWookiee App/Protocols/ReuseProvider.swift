//
//  ReuseProvider.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import Foundation

protocol ReuseProvider: class {
    
    static var reuseIdentifier: String { get }
    
}

extension ReuseProvider {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
    
}
