//
//  CoreStorage.swift
//  CoreStorage
//
//  Created by Yo'ldoshev Asadbek on 13/08/2025.
//

import Foundation

public protocol KeyValueStore {
    func data(forKey key: String) -> Data?
    func set(_ data: Data?, forKey key: String)
    func removeValue(forKey key: String)
    func contains(_ key: String) -> Bool
}

public struct UserDefaultsStore: KeyValueStore {
    private let defaults: UserDefaults

    public init(suiteName: String? = nil) {
        if let suiteName {
            guard let store = UserDefaults(suiteName: suiteName) else {
                fatalError("Не удалось создать UserDefaults с suiteName: \(suiteName)")
            }
            self.defaults = store
        } else {
            self.defaults = .standard
        }
    }

    public func data(forKey key: String) -> Data? {
        defaults.data(forKey: key)
    }

    public func set(_ data: Data?, forKey key: String) {
        defaults.set(data, forKey: key)
    }

    public func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }

    public func contains(_ key: String) -> Bool {
        defaults.object(forKey: key) != nil
    }
}

public struct NamespacedStore: KeyValueStore {
    private let base: KeyValueStore
    private let prefix: String

    public init(base: KeyValueStore, prefix: String) {
        self.base = base
        self.prefix = prefix
    }

    private func k(_ key: String) -> String { "\(prefix).\(key)" }

    public func data(forKey key: String) -> Data? { base.data(forKey: k(key)) }
    public func set(_ data: Data?, forKey key: String) { base.set(data, forKey: k(key)) }
    public func removeValue(forKey key: String) { base.removeValue(forKey: k(key)) }
    public func contains(_ key: String) -> Bool { base.contains(k(key)) }
}

public protocol DataTransformerProtocol {
    associatedtype Value
    static func encode(_ value: Value) throws -> Data
    static func decode(_ data: Data) throws -> Value
}

public struct CodableTransformer<T: Codable>: DataTransformerProtocol {
    public static func encode(_ value: T) throws -> Data {
        let enc = JSONEncoder()
        enc.dateEncodingStrategy = .iso8601
        return try enc.encode(value)
    }
    public static func decode(_ data: Data) throws -> T {
        let dec = JSONDecoder()
        dec.dateDecodingStrategy = .iso8601
        return try dec.decode(T.self, from: data)
    }
}

public struct AnyTransformer<Value> {
    private let _encode: (Value) throws -> Data
    private let _decode: (Data) throws -> Value

    public init(encode: @escaping (Value) throws -> Data,
                decode: @escaping (Data) throws -> Value) {
        self._encode = encode
        self._decode = decode
    }

    public func encodeValue(_ value: Value) throws -> Data { try _encode(value) }
    public func decodeValue(_ data: Data) throws -> Value { try _decode(data) }
}

public struct Storage {
    private let store: KeyValueStore

    public init(store: KeyValueStore) {
        self.store = store
    }

    public func save<T: Codable>(_ value: T, forKey key: String) throws {
        let data = try CodableTransformer<T>.encode(value)
        store.set(data, forKey: key)
    }

    public func load<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = store.data(forKey: key) else { return nil }
        return try? CodableTransformer<T>.decode(data)
    }

    public func save<Value>(_ value: Value, forKey key: String, using transformer: AnyTransformer<Value>) throws {
        let data = try transformer.encodeValue(value)
        store.set(data, forKey: key)
    }

    public func load<Value>(_ type: Value.Type, forKey key: String, using transformer: AnyTransformer<Value>) -> Value? {
        guard let data = store.data(forKey: key) else { return nil }
        return try? transformer.decodeValue(data)
    }

    public func remove(_ key: String) {
        store.removeValue(forKey: key)
    }

    public func contains(_ key: String) -> Bool {
        store.contains(key)
    }
}

public enum CoreStore {
    public static let `default` = Storage(store: UserDefaultsStore())
}

@propertyWrapper
public struct StoredCodable<Value: Codable> {
    private let key: String
    private let storage: Storage
    private let defaultValue: Value

    public init(key: String,
                default defaultValue: Value,
                storage: Storage = CoreStore.default) {
        self.key = key
        self.storage = storage
        self.defaultValue = defaultValue
    }

    public var wrappedValue: Value {
        get { storage.load(Value.self, forKey: key) ?? defaultValue }
        set { try? storage.save(newValue, forKey: key) }
    }
}

@propertyWrapper
public struct StoredData<Value> {
    private let key: String
    private let storage: Storage
    private let transformer: AnyTransformer<Value>
    private let defaultValue: Value

    public init(key: String,
                default defaultValue: Value,
                storage: Storage = CoreStore.default,
                transformer: AnyTransformer<Value>) {
        self.key = key
        self.storage = storage
        self.transformer = transformer
        self.defaultValue = defaultValue
    }

    public var wrappedValue: Value {
        get { storage.load(Value.self, forKey: key, using: transformer) ?? defaultValue }
        set { try? storage.save(newValue, forKey: key, using: transformer) }
    }
}

public struct DataTransformer {
    public init() {}
    public var any: AnyTransformer<Data> {
        AnyTransformer<Data>(
            encode: { $0 },
            decode: { $0 }
        )
    }
}
