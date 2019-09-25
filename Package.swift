// swift-tools-version: 5.0
import PackageDescription

let package = Package(
    name: "RxOptional",
    products: [
        .library(name: "RxOptional", targets: ["RxOptional"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "RxOptional",
            dependencies: ["RxSwift", "RxCocoa"],
            path: "Sources"
        )
    ],
    swiftLanguageVersions: [.v5]
)
