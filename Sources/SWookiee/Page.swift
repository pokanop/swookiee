import Foundation

public struct Page<T: DecodableResource>: Decodable {
    
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [T]
    
}
