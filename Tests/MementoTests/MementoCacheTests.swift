//
//  MementoCacheTests.swift
//  Memento
//
//  Created by Alexander Zyryanov on 08.08.2026.
//

import XCTest
@testable import Memento

final class MementoCacheTests: XCTestCase {
    private let mementoLoader: MementoLoaderProtocol = MementoLoader()
    private let mementoCache: MementoCacheProtocol = MementoCache.shared
    
    func testSet() async {
        guard let data = await mementoLoader.fetchData(from: Res.testImageURL) else {
            return XCTFail()
        }
        
        await mementoCache.set(data, forKey: Res.testImageURL)
        let result = await mementoCache.get(forKey: Res.testImageURL)
        XCTAssertNotNil(result)
        
        let url = URL(string: Res.testImageURL)!
        await mementoCache.set(data, forKey: url)
        let result2 = await mementoCache.get(forKey: url)
        XCTAssertNotNil(result2)
    }
}
