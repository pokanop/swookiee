import Foundation

public struct Film: Resource {
    
    public static var endpoint: Endpoint = .films
    public var id: UUID = UUID()
    public var name: String
    public var url: URL
    public var created: Date
    public var updated: Date
    
    enum CodingKeys: String, CodingKey {
        case url, created
        case name = "title"
        case updated = "edited"
    }
}
