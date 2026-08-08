//
//  LoaderTests.swift
//  Memento
//
//  Created by Alexander Zyryanov on 08.08.2026.
//

import XCTest
@testable import Memento

final class LoaderTests: XCTestCase {
    private let testImageURL: String = "https://avatars.mds.yandex.net/i?id=8094c025534ddffe04aa59d4133541ade607f8ca-5243188-images-thumbs&n=13"
    private let mementoLoader: MementoLoaderProtocol = MementoLoader()

    func testFetchDataTest() async {
        let data = await mementoLoader.fetchData(from: testImageURL)
        XCTAssertNotNil(data)
    }
}
