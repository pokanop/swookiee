import Foundation

public class Cache {
    
    static let shared: Cache = Cache()
    
    private var cache: [URL: AnyResource] = [:]
    private var urls: [URL: [URL]] = [:]
    
    public func set<T: Resource>(_ item: T, for url: URL) {
        cache[url] = AnyResource(item)
    }
    
    public func get<T: Resource>(_ url: URL) -> T? {
        return cache[url]?._box._base as? T
    }
    
    public func set<T: Resource>(_ items: [T], for url: URL) {
        urls[url] = items.map { $0.url }
        items.forEach { set($0, for: $0.url) }
    }
    
    public func get<T: Resource>(_ url: URL) -> [T]? {
        guard let urls = urls[url] else { return nil }
        return urls.compactMap { cache[$0]?._box._base as? T }
    }
    
    public func reset() {
        cache.removeAll()
        urls.removeAll()
    }
    
}
