import Foundation

public class Cache {
    
    static let shared: Cache = Cache()
    
    private final class Key<T: Hashable>: NSObject {
        
        let key: T
        
        init(_ key: T) { self.key = key }
        
        override var hash: Int { key.hashValue }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let key = object as? T else { return false }
            return self.key == key
        }
        
    }
    
    private final class Value: NSObject {
        
        let value: Any
        
        init(_ value: Any) { self.value = value }
        
    }
    
    private let wrapped = NSCache<Key<URL>, Value>()
    
    func set<T: Decodable>(_ item: T, for url: URL) {
        wrapped.setObject(Value(item), forKey: Key(url))
    }
    
    func get<T: Decodable>(_ url: URL) -> T? {
        return wrapped.object(forKey: Key(url))?.value as? T
    }
    
}
