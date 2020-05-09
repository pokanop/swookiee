import Foundation

public protocol Resource: Decodable, Hashable {
    
    static var endpoint: Endpoint { get }
    var id: UUID { get }
    var name: String { get }
    var url: URL { get }
    var created: Date { get }
    var updated: Date { get }
    
}

public extension Resource {
    
    var name: String { Self.endpoint.rawValue }
    var url: URL { Self.endpoint.baseURL }
    var created: Date { Date.distantPast }
    var updated: Date { Date.distantPast }
    
    static func fetch(id: Int, completion: ((Self?, Error?) -> ())? = nil) {
        fetch(url: endpoint.itemURL(id: id), completion: completion)
    }
    
    static func fetch(completion: (([Self]?, Error?) -> ())? = nil) {
        fetch(url: endpoint.baseURL, completion: completion)
    }
    
    static func fetch<T: Decodable>(url: URL, completion: ((T?, Error?) -> ())? = nil) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                assertionFailure(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                assertionFailure("response data is nil")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .custom(DateFormatter.dateDecoder)
            do {
                if url.isEndpoint && !url.isRootEndpoint {
                    let page = try decoder.decode(Page<Self>.self, from: data)
                    completion?(page.results as? T, nil)
                } else {
                    let resource = try decoder.decode(Self.self, from: data)
                    completion?(resource as? T, nil)
                }
            } catch let error {
                assertionFailure(error.localizedDescription)
                completion?(nil, error)
            }
        }.resume()
    }
    
}

extension DateFormatter {
    
    static let dateDecoder: (Decoder) throws -> Date = { decoder in
        // Unfortunately Swift date formatting doesn't handle all variants of ISO8601
        // and we need to provide a custom date decoding strategy.
        // See this for details: https://forums.swift.org/t/iso8601dateformatter-fails-to-parse-a-valid-iso-8601-date/22999/8
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        // Attempt with and without fractional seconds
        if #available(OSX 10.13, *) {
            let formatter = ISO8601DateFormatter()
            if let date = formatter.date(from: dateString) {
                return date
            }
            
            formatter.formatOptions = [.withFractionalSeconds]
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Date string does not match expected format.")
    }
    
}
