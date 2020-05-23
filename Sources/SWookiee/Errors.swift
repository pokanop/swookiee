import Foundation

/// Error types returned by the SWookiee library
///
/// The following types exist and can be used to determine issues:
///
/// - `network`: a network issue occurred when using `URLSession`
/// - `data`: no data was returned from the network call
/// - `decoder`: a parser or `JSONDecoder` error was encountered
///
public enum SWookieeError: LocalizedError {
    
    case network(underlyingError: Error)
    case data
    case decoder(underlyingError: Error)
    
    public var errorDescription: String? {
        switch self {
        case .network(let error): return error.localizedDescription
        case .data: return "response data is nil"
        case .decoder(let error): return error.localizedDescription
        }
    }
    
}
