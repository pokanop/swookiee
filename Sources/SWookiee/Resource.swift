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
            decoder.dateDecodingStrategy = .formatted(.iso8601Full)
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
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
