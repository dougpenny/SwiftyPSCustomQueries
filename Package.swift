// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SwiftyPSCustomQueries",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "SwiftyPSCustomQueries",
            targets: ["SwiftyPSCustomQueries"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/dougonecent/SwiftyPSCore.git",
            from: "1.0.0-beta6"
        )
    ],
    targets: [
        .target(
            name: "SwiftyPSCustomQueries",
            dependencies: ["SwiftyPSCore"]
        ),
        .testTarget(
            name: "SwiftyPSCustomQueriesTests",
            dependencies: ["SwiftyPSCustomQueries", "SwiftyPSCore"],
            resources: [.process("Resources")]
        )
    ]
)
