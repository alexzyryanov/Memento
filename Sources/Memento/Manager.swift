//
//  Manager.swift
//  Memento
//
//  Created by Alexander Zyryanov on 19.09.2025.
//

import UIKit

struct MementoManager {
    private let cache: MementoCacheProtocol
    private let loader: MementoLoaderProtocol
    
    init(_ cache: MementoCacheProtocol = MementoCache.shared,
         _ loader: MementoLoaderProtocol = MementoLoader()) {
        self.cache = cache
        self.loader = loader
    }
    
    func getImage(from url: String) async -> UIImage? {
        await loadImage(from: url)
    }
    
    private func loadImage(from url: String) async -> UIImage? {
        guard let cachedImage = await cache.get(forKey: url) else {
            return await load(from: url)
        }
        
        return cachedImage
    }
    
    private func load(from url: String) async -> UIImage? {
        guard let data = await loader.fetchData(from: url),
              let image = UIImage(data: data) else {
            return nil
        }
        
        await cache.set(image, forKey: url)
        return image
    }
}
