// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Memento",
    platforms: [
        .iOS(.v18),
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "Memento",
            targets: ["Memento"]
        ),
    ],
    targets: [
        .target(
            name: "Memento"
        ),
        .testTarget(
            name: "MementoTests",
            dependencies: ["Memento"]
        )
    ]
)
