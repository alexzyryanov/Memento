// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "Memento",
    platforms: [.iOS(.v17)],
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
    ]
)
