// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Combinative",
    platforms: [
      .iOS(.v13)
    ],
    products: [
        .library(
            name: "Combinative",
            targets: ["Combinative"]),
    ],
    targets: [
        .target(
            name: "Combinative",
            dependencies: []),
        .testTarget(
            name: "CombinativeTests",
            dependencies: ["Combinative"]),
    ]
)
