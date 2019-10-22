// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RxOptional",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v3)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(name: "RxOptional", targets: ["RxOptional"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
        // Development
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "2.1.0")), // dev
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.2")), // dev
        .package(url: "https://github.com/shibapm/Rocket", .upToNextMajor(from: "0.4.0")) // dev
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "RxOptional", dependencies: ["RxSwift", "RxCocoa"]),
        .testTarget(name: "RxOptionalTests", dependencies: ["RxOptional", "Quick", "Nimble"]) // dev
    ],
    swiftLanguageVersions: [.v4_2, .v5]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfiguration([
        "rocket": [
            "before": [
                "swift build",
                "swift test",
                "scripts/bootstrap-if-needed.sh",
                
            ],
            "after": [
                "pod lib lint --allow-warnings",
                "pod trunk push --skip-tests --allow-warnings"
            ]
        ]
    ]).write()
#endif
