//
//  Cache.swift
//  Memento
//
//  Created by Alexander Zyryanov on 19.09.2025.
//

import UIKit

protocol MementoCacheProtocol: Sendable {
    func set(_ image: UIImage, forKey key: String) async
    func set(_ image: UIImage, forKey key: URL) async
    func get(forKey key: String) async -> UIImage?
    func get(forKey key: URL) async -> UIImage?
}

actor MementoCache: MementoCacheProtocol {
    static let shared = MementoCache()
    private let nsCache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    private func setObject(_ image: UIImage, forKey key: NSString) {
        nsCache.setObject(image, forKey: key)
    }
    
    private func getObject(forKey key: NSString) -> UIImage? {
        nsCache.object(forKey: key)
    }
}

extension MementoCache {
    func set(_ image: UIImage, forKey key: String) {
        setObject(image, forKey: key as NSString)
    }
    
    func set(_ image: UIImage, forKey key: URL) {
        setObject(image, forKey: key.absoluteString as NSString)
    }
    
    func get(forKey key: String) -> UIImage? {
        getObject(forKey: key as NSString)
    }
    
    func get(forKey key: URL) -> UIImage? {
        getObject(forKey: key.absoluteString as NSString)
    }
}
