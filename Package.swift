// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Combinative",
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
