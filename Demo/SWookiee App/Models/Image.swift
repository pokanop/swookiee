//
//  Image.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import Foundation

struct Image: Decodable {
    
    let id: Int
    let pageURL: URL
    let type: String
    let tags: String
    let previewURL: URL
    let previewWidth: Int
    let previewHeight: Int
    let webformatURL: URL
    let webformatWidth: Int
    let webformatHeight: Int
    let largeImageURL: URL
    let imageWidth: Int
    let imageHeight: Int
    let imageSize: Int
    let views: Int
    let downloads: Int
    let favorites: Int
    let likes: Int
    let comments: Int
    let userID: Int
    let user: String
    
    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, favorites, likes, comments, user
        case userID = "user_id"
    }
    
}
