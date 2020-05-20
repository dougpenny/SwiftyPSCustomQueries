// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyPSCustomQueries",
    products: [
        .library(name: "SwiftyPSCustomQueries", targets: ["SwiftyPSCustomQueries"]),
    ],
    dependencies: [
        .package(name: "SwiftyPSCore", path: "../SwiftyPowerSchool-Core"),
    ],
    targets: [
        .target(name: "SwiftyPSCustomQueries", dependencies: ["SwiftyPSCore"]),
        .testTarget(name: "SwiftyPSCustomQueriesTests",
                    dependencies: ["SwiftyPSCustomQueries", "SwiftyPSCore"]),
    ]
)
