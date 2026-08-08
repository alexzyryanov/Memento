//
//  LoaderTests.swift
//  Memento
//
//  Created by Alexander Zyryanov on 08.08.2026.
//

import XCTest
@testable import Memento

enum Res {
    static let testImageURL: String = "https://avatars.mds.yandex.net/i?id=8094c025534ddffe04aa59d4133541ade607f8ca-5243188-images-thumbs&n=13"
}


final class LoaderTests: XCTestCase {
    private let mementoLoader: MementoLoaderProtocol = MementoLoader()

    func testFetchDataTest() async {
        let data = await mementoLoader.fetchData(from: Res.testImageURL)
        XCTAssertNotNil(data)
    }
}
