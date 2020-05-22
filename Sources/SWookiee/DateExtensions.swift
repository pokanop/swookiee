import Foundation

extension DateFormatter {
    
    static let dateDecoder: (Decoder) throws -> Date = { decoder in
        // Unfortunately Swift date formatting doesn't handle all variants of ISO8601
        // easily and we need to provide a custom date decoding strategy.
        // See this for details: https://forums.swift.org/t/iso8601dateformatter-fails-to-parse-a-valid-iso-8601-date/22999/8
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)
        
        if #available(OSX 10.13, *), #available(iOS 11.0, *) {
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFractionalSeconds]
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Date string does not match expected format.")
    }
    
}
