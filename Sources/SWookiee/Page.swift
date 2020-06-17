import Foundation

/// A page resource type for representing SWAPI paged results.
public struct Page<T: DecodableResource>: Decodable {
    
    /// The count of pages for the resource.
    public let count: Int
    
    /// The next page as a `URL` for the resource.
    public let next: URL?
    
    /// The previous page as a `URL` for the resource
    public let previous: URL?
    
    /// The result resources for a page.
    public let results: [T]
    
}
