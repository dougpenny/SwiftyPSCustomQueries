// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyPSCustomQueries",
    products: [
        .library(name: "SwiftyPSCustomQueries", targets: ["SwiftyPSCustomQueries"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nrca/SwiftyPSCore.git", from: "1.0.0-beta4"),
    ],
    targets: [
        .target(name: "SwiftyPSCustomQueries", dependencies: ["SwiftyPSCore"]),
        .testTarget(name: "SwiftyPSCustomQueriesTests",
                    dependencies: ["SwiftyPSCustomQueries", "SwiftyPSCore"]),
    ]
)
