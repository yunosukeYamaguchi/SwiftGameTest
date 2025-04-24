// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "SwiftGameTest",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .executable(name: "SwiftGameTest", targets: ["SwiftGameTest"])
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-cocoa.git", from: "20.0.2")
    ],
    targets: [
        .executableTarget(
            name: "SwiftGameTest",
            dependencies: [
                .product(name: "Realm", package: "realm-cocoa", type: .dynamic),
                .product(name: "RealmSwift", package: "realm-cocoa", type: .dynamic)
            ]
        )
    ]
)
