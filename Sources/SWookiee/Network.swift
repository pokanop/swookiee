import Foundation

protocol NetworkProvider {
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
}

extension URLSession: NetworkProvider {}

final class Network: NetworkProvider {
    
    static let shared: Network = Network()
    
    var provider: NetworkProvider
    
    private init() {
        let configuration = URLSessionConfiguration.ephemeral
        provider = URLSession(configuration: configuration)
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        provider.dataTask(with: url, completionHandler: completionHandler)
    }
    
}
