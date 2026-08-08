//
//  Cache.swift
//  Memento
//
//  Created by Alexander Zyryanov on 19.09.2025.
//

import Foundation

protocol MementoCacheProtocol: Sendable {
    func set(_ data: Data, forKey key: String) async
    func set(_ data: Data, forKey key: URL) async
    func get(forKey key: String) async -> Data?
    func get(forKey key: URL) async -> Data?
}

actor MementoCache: MementoCacheProtocol {
    static let shared = MementoCache()
    private let nsCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    private func setObject(_ data: Data, forKey key: String) {
        nsCache.setObject(NSData(data: data), forKey: key as NSString)
    }
    
    private func getObject(forKey key: String) -> Data? {
        nsCache.object(forKey: key as NSString) as? Data
    }
}

extension MementoCache {
    func set(_ data: Data, forKey key: String) {
        setObject(data, forKey: key)
    }
    
    func set(_ data: Data, forKey key: URL) {
        setObject(data, forKey: key.absoluteString)
    }
    
    func get(forKey key: String) -> Data? {
        getObject(forKey: key)
    }
    
    func get(forKey key: URL) -> Data? {
        getObject(forKey: key.absoluteString)
    }
}
