// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "Kizuna",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .watchOS(.v26),
        .tvOS(.v26),
        .visionOS(.v26)
    ],
    products: [
        .library(
            name: "KizunaCore",
            targets: ["KizunaCore"]
        ),
        .executable(
            name: "kizuna",
            targets: ["KizunaCLI"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            from: "1.6.0"
        )
    ],
    targets: [
        .target(
            name: "KizunaCore",
            path: "Sources/Libraries/KizunaCore"
        ),
        .executableTarget(
            name: "KizunaCLI",
            dependencies: [
                "KizunaCore",
                .product(
                    name: "ArgumentParser",
                    package: "swift-argument-parser"
                )
            ],
            path: "Sources/Apps/CLI"
        ),
        .testTarget(
            name: "KizunaCoreTests",
            dependencies: ["KizunaCore"]
        )
    ],
    swiftLanguageModes: [.v6]
)
