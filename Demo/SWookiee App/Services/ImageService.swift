//
//  ImageService.swift
//  SWookiee App
//
//  Copyright © 2020 Pokanop Apps LLC. All rights reserved.
//

import UIKit
import Combine

enum ImageServiceError: Error {
    
    case noData
    
}

class ImageService {
    
    static let shared: ImageService = ImageService()
    
    private var cache: [URL: UIImage] = [:]
    private let apiKey: String = ""   // TODO: Set your pixabay API key here
    
    private init() {}
    
    func get(url: URL) -> UIImage? {
        return cache[url]
    }
    
    func set(image: UIImage, for url: URL) {
        cache[url] = image
    }
    
    func clear() {
        cache.removeAll()
    }
    
    func search(for term: String) -> Future<ImageList, Error> {
        let url = searchURL(for: term)
        return Future { resolver in
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    resolver(Result.failure(error!))
                    return
                }
                
                guard let data = data else {
                    resolver(Result.failure(ImageServiceError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let imageList = try decoder.decode(ImageList.self, from: data)
                    resolver(Result.success(imageList))
                } catch let error {
                    resolver(Result.failure(error))
                }
            }.resume()
        }
    }
    
    private func searchURL(for term: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pixabay.com"
        components.path = "/api/"
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: term)
        ]
        return components.url!
    }
    
}
