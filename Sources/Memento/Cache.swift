//
//  Cache.swift
//  Memento
//
//  Created by Alexander Zyryanov on 19.09.2025.
//

import Foundation
import UIKit

protocol MementoCacheProtocol {
    func saveObject(_ image: UIImage, for key: String)
    func loadObject(for key: String) -> UIImage?
}

final class MementoCache: @unchecked Sendable, MementoCacheProtocol {
    static let shared: MementoCache = MementoCache()
    private let nsCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func saveObject(_ image: UIImage, for key: String) {
        nsCache.setObject(image, forKey: key as NSString)
    }
    
    func loadObject(for key: String) -> UIImage? {
        nsCache.object(forKey: key as NSString)
    }
}
