//
//  Loader.swift
//  Memento
//
//  Created by Alexander Zyryanov on 19.09.2025.
//

import Foundation

public protocol MementoLoaderProtocol {
    func fetchData(from url: String) async -> Data?
}

public struct MementoLoader: MementoLoaderProtocol {
    private let session: URLSession
    
    public init(_ session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    public func fetchData(from url: String) async -> Data? {
        guard let url = URL(string: url) else {
            return nil
        }
        
        do {
            let (data, _) = try await session.data(from: url)
            return data
            
        } catch {
            return nil
        }
    }
}
