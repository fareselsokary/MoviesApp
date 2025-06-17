// swift-tools-version: 6.1
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
        .package(path: "../Networking") // Path relative to this package's directory
    ],
    targets: [
        .target(
            name: "API",
            dependencies: [
                "Networking" // Depend on the 'Networking' library from the 'Networking' package
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
