import Foundation

public struct Page<T: Resource>: Decodable {
    
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [T]
    
}
