import Foundation

public struct Vehicle: Resource {
    
    public static let endpoint: Endpoint = .vehicles
    public let id: UUID = UUID()
    public let name: String
    public let url: URL
    public let created: Date
    public let updated: Date
    
    enum CodingKeys: String, CodingKey {
        case name, url, created
        case updated = "edited"
    }
    
}
