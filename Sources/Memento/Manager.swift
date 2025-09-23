//
//  Manager.swift
//  Memento
//
//  Created by Alexander Zyryanov on 19.09.2025.
//

import Foundation
import UIKit

final class MementoManager: @unchecked Sendable {
    static let shared: MementoManager = MementoManager()
    private let cache: MementoCacheProtocol
    private let loader: MementoLoaderProtocol
    
    private init(_ cache: MementoCacheProtocol = MementoCache.shared,
                 _ loader: MementoLoaderProtocol = MementoLoader.shared) {
        self.cache = cache
        self.loader = loader
    }
    
    func getImage(from url: String) async -> UIImage? {
        await loadImage(from: url)
    }
    
    private func loadImage(from url: String) async -> UIImage? {
        guard let cachedImage = cache.loadObject(for: url) else {
            return await load(from: url)
        }
        
        return cachedImage
    }
    
    private func load(from url: String) async -> UIImage? {
        guard let data = await loader.fetchData(from: url),
              let image = UIImage(data: data) else {
            return nil
        }
        
        cache.saveObject(image, for: url)
        return image
    }
}
