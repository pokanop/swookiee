//
//  KindProvider.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import Foundation

protocol KindProvider: class {
    
    static var kind: String { get }
    
}

extension KindProvider {
    
    static var kind: String {
        return String(describing: Self.self)
    }
    
}
