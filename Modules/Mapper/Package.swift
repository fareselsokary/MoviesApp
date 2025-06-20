// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mapper",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Mapper",
            targets: ["Mapper"]
        )
    ],
    dependencies: [
        .package(path: "../API"),
        .package(path: "../Persistence"),
        .package(path: "../Domain")
    ],
    targets: [
        .target(
            name: "Mapper",
            dependencies: [
                .product(name: "API", package: "API"),
                .product(name: "Persistence", package: "Persistence"),
                .product(name: "Domain", package: "Domain")
            ],
            path: "Sources/Mapper"
        ),
        .testTarget(
            name: "MapperTests",
            dependencies: ["Mapper"]
        )
    ]
)
