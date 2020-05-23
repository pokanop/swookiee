import Foundation

protocol NetworkProvider {
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
}

extension URLSession: NetworkProvider {}

class Network {
    
    static let shared: Network = Network()
    
    var provider: NetworkProvider
    
    private init() {
        provider = URLSession.shared
    }
    
}
