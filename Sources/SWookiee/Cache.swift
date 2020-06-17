import Foundation

/// A shared cache for storing resources as they are requested.
///
/// Stores all resources as `AnyResource` concrete types and provides
/// facilities to extract specific types through generic methods.
///
/// Cache is unlimited currently with unbounded memory use. To free memory,
/// use the `reset` method to clear the cache.
public class Cache {
    
    /// A shared instance of the `Cache`.
    static let shared: Cache = Cache()
    
    private var cache: [URL: AnyResource] = [:]
    private var urls: [URL: [URL]] = [:]
    
    /// Set a resource for a given `URL`
    ///
    /// - Parameters:
    ///   - item: The resource to store in the cache.
    ///   - url: The `URL` to use as a key in the cache.
    public func set<T: Resource>(_ item: T, for url: URL) {
        cache[url] = AnyResource(item)
    }
    
    /// Get a resource for a given `URL`.
    ///
    /// - Parameter url: The `URL` to lookup in the cache.
    /// - Returns: The resource as `T` if it exists.
    public func get<T: Resource>(_ url: URL) -> T? {
        return cache[url]?._box._base as? T
    }
    
    /// Set resources for a given `URL`.
    ///
    /// - Parameters:
    ///   - items: The resources to store in the cache.
    ///   - url: The `URL` to use as a key in the cache.
    public func set<T: Resource>(_ items: [T], for url: URL) {
        urls[url] = items.map { $0.url }
        items.forEach { set($0, for: $0.url) }
    }
    
    /// Get resources for a given `URL`.
    ///
    /// - Parameter url: The `URL` to lookup in the cache.
    /// - Returns: The resources as `[T]` if it exists.
    public func get<T: Resource>(_ url: URL) -> [T]? {
        guard let urls = urls[url] else { return nil }
        return urls.compactMap { cache[$0]?._box._base as? T }
    }
    
    /// Reset the cache.
    public func reset() {
        cache.removeAll()
        urls.removeAll()
    }
    
}
