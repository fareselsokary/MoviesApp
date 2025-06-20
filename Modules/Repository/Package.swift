// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Repository",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Repository",
            targets: ["Repository"]
        )
    ],
    dependencies: [
        .package(path: "../API"),
        .package(path: "../Networking"),
        .package(path: "../Persistence"),
        .package(path: "../Core"),
        .package(path: "../Domain"),
        .package(path: "../Mapper")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Repository",
            dependencies: [
                .product(name: "API", package: "API"),
                .product(name: "Networking", package: "Networking"),
                .product(name: "Persistence", package: "Persistence"),
                .product(name: "Core", package: "Core"),
                .product(name: "Domain", package: "Domain"),
                .product(name: "Mapper", package: "Mapper")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "RepositoryTests",
            dependencies: ["Repository"],
            path: "Tests/RepositoryTests"
        )
    ]
)
