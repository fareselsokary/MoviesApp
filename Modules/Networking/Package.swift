// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]
        )
    ],
    dependencies: [
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                .product(name: "Core", package: "Core")
            ],
            path: "Sources/Networking"
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"],
            path: "Tests/NetworkingTests"
        )
    ]
)
