//
//  ImageList.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import Foundation

struct ImageList: Decodable {
    
    let total: Int
    let totalHits: Int
    let hits: [Image]
    
}
