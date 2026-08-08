//
//  Cache.swift
//  Memento
//
//  Created by Alexander Zyryanov on 19.09.2025.
//

import Foundation

public protocol MementoCacheProtocol: Sendable {
    func set(_ data: Data, forKey key: String) async
    func set(_ data: Data, forKey key: URL) async
    func get(forKey key: String) async -> Data?
    func get(forKey key: URL) async -> Data?
}

public actor MementoCache {
    public static let shared = MementoCache()
    private let nsCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    private func setObject(_ data: Data, forKey key: String) {
        nsCache.setObject(NSData(data: data), forKey: key as NSString)
    }
    
    private func getObject(forKey key: String) -> Data? {
        nsCache.object(forKey: key as NSString) as? Data
    }
}

extension MementoCache: MementoCacheProtocol {
    public func set(_ data: Data, forKey key: String) {
        setObject(data, forKey: key)
    }
    
    public func set(_ data: Data, forKey key: URL) {
        setObject(data, forKey: key.absoluteString)
    }
    
    public func get(forKey key: String) -> Data? {
        getObject(forKey: key)
    }
    
    public func get(forKey key: URL) -> Data? {
        getObject(forKey: key.absoluteString)
    }
}
