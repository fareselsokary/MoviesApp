// swift-tools-version: 6.1
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
        // Declare local package dependencies
        .package(path: "../Core") // Path relative to this package's directory
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: [
                "Core" // Depend on the 'Core' library from the 'Core' package
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
