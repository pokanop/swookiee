import Foundation

public struct Planet: Resource {
    
    public static var endpoint: Endpoint = .planets
    public var id: UUID = UUID()
    public var name: String
    public var url: URL
    public var created: Date
    public var updated: Date
    
    enum CodingKeys: String, CodingKey {
        case name, url, created
        case updated = "edited"
    }
    
}
