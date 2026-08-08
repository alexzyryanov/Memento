//
//  Manager.swift
//  Memento
//
//  Created by Alexander Zyryanov on 19.09.2025.
//

import Foundation

struct MementoManager {
    private let cache: MementoCacheProtocol
    private let loader: MementoLoaderProtocol
    
    init(_ cache: MementoCacheProtocol = MementoCache.shared,
         _ loader: MementoLoaderProtocol = MementoLoader()) {
        self.cache = cache
        self.loader = loader
    }
    
    func getImageData(from url: String) async -> Data? {
        await loadImage(from: url)
    }
    
    private func loadImage(from url: String) async -> Data? {
        guard let cachedImage = await cache.get(forKey: url) else {
            return await load(from: url)
        }
        
        return cachedImage
    }
    
    private func load(from url: String) async -> Data? {
        guard let data = await loader.fetchData(from: url) else {
            return nil
        }
        
        await cache.set(data, forKey: url)
        return data
    }
}
