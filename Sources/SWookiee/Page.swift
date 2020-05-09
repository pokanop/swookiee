import Foundation

public struct Page<T: Resource>: Decodable {
    
    var count: Int
    var next: URL?
    var previous: URL?
    var results: [T]
    
}
