//
//  Loader.swift
//  Memento
//
//  Created by Alexander Zyryanov on 19.09.2025.
//

import Foundation

protocol MementoLoaderProtocol {
    func fetchData(from url: String) async -> Data?
}

struct MementoLoader: MementoLoaderProtocol {
    private let session: URLSession
    
    init(_ session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func fetchData(from url: String) async -> Data? {
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
