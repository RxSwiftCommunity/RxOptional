// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "RxOptional",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v3)
    ],
    products: [
        .library(name: "RxOptional", targets: ["RxOptional"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "2.1.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.2"))
    ],
    targets: [
        .target(
            name: "RxOptional",
            dependencies: ["RxSwift", "RxCocoa"],
            path: "Source"
        ),
        .testTarget(
            name: "RxOptionalTests",
            dependencies: ["RxOptional", "Quick", "Nimble"],
            path: "Test"
        )
    ],
    swiftLanguageVersions: [.v5]
)