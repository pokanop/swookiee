import Foundation

@usableFromInline
protocol _AnyResourceBox {
    
    var _base: Any { get }
    
    static var _endpoint: Endpoint { get }
    var _id: UUID { get }
    var _name: String { get }
    var _url: URL { get }
    var _created: Date { get }
    var _updated: Date { get }
    
    func _isEqual(to box: _AnyResourceBox) -> Bool?
    func _hash(into hasher: inout Hasher)
    func _unbox<T: Resource>() -> T?
    
}

struct _ConcreteResourceBox<Base: Resource>: _AnyResourceBox {
    
    var _baseResource: Base
    
    var _base: Any {
      return _baseResource
    }
    
    static var _endpoint: Endpoint { Base.endpoint }
    var _id: UUID { _baseResource.id }
    var _name: String { _baseResource.name }
    var _url: URL { _baseResource.url }
    var _created: Date { _baseResource.created }
    var _updated: Date { _baseResource.updated }
    
    init(_ base: Base) {
        self._baseResource = base
    }
    
    func _isEqual(to box: _AnyResourceBox) -> Bool? {
        guard let box: Base = box._unbox() else {
            return nil
        }
        return _baseResource == box
    }
    
    func _hash(into hasher: inout Hasher) {
        _baseResource.hash(into: &hasher)
    }
    
    func _unbox<T>() -> T? where T : Resource {
        return (self as _AnyResourceBox as? _ConcreteResourceBox<T>)?._baseResource
    }
    
}

/// A type-erased resource value.
///
/// The `AnyResource` type forwards properties and methods to
/// an underlying `Resource` type that is boxed by this type. It allows
/// using this type as a concrete container for a generic type.
///
/// Use the generic `unboxed` method to access the underlying type
/// for use.
@frozen public struct AnyResource {
    
    var _box: _AnyResourceBox
    
    init(_box box: _AnyResourceBox) {
        self._box = box
    }
    
    /// Creates a type-erased resource value that wraps the given instance.
    ///
    /// - Parameter base: A resource value to wrap.
    public init<R: Resource>(_ base: R) {
        self.init(_box: _ConcreteResourceBox(base))
    }
    
}

extension AnyResource: Resource {
    
    public static var endpoint: Endpoint { .root }
    public var id: UUID { _box._id }
    public var name: String { _box._name }
    public var url: URL { _box._url }
    public var created: Date { _box._created }
    public var updated: Date { _box._updated }
    
    public static func == (lhs: AnyResource, rhs: AnyResource) -> Bool {
        return lhs._box._isEqual(to: rhs._box) ?? false
    }
    
    public func hash(into hasher: inout Hasher) {
        _box._hash(into: &hasher)
    }
    
    /// Returns the unboxed type as `T` if possible.
    ///
    /// - Returns: The wrapped value as `T`.
    public func unboxed<T>() -> T? {
        return _box._base as? T
    }
    
}
