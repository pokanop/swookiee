import Foundation
@testable import SWookiee

class TestNetwork: NetworkProvider {
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(data, response, error)
        return URLSessionDataTask()
    }
    
}
