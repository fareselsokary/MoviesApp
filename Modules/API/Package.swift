// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "API",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "API",
            targets: ["API"]
        )
    ],
    dependencies: [
        .package(path: "../Networking"),
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "API",
            dependencies: [
                .product(name: "Networking", package: "Networking"),
                .product(name: "Core", package: "Core")
            ],
            path: "Sources/API"
        ),
        .testTarget(
            name: "APITests",
            dependencies: ["API"],
            path: "Tests/APITests"
        )
    ]
)
