import Foundation

public protocol Resource: Decodable, Hashable {
    
    static var endpoint: Endpoint { get }
    static var baseURL: URL { get }
    var id: UUID { get }
    var name: String { get }
    var url: URL { get }
    var created: Date { get }
    var updated: Date { get }
    
}

public extension Resource {
    
    static var baseURL: URL { endpoint.baseURL }
    var name: String { Self.endpoint.rawValue }
    var url: URL { Self.endpoint.baseURL }
    var created: Date { Date.distantPast }
    var updated: Date { Date.distantPast }
    
    static func load(url: URL = baseURL, completion: (([Self]?, Error?) -> ())? = nil) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                assertionFailure(error!.localizedDescription)
                return
            }
            
            guard let data = data else {
                assertionFailure("response data is nil")
                return
            }
            
            var resources: [Self] = []
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .formatted(.iso8601Full)
            do {
                if url.isEndpoint && !url.isRootEndpoint {
                    let page = try decoder.decode(Page<Self>.self, from: data)
                    resources.append(contentsOf: page.results)
                } else {
                    let resource = try decoder.decode(Self.self, from: data)
                    resources.append(resource)
                }
                completion?(resources, nil)
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
