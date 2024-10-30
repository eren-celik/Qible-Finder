// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Qible-Finder",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Qible-Finder",
            targets: [
                "Sources"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", "5.9.1"..<"6.0.0"),
        .package(url: "https://github.com/hackiftekhar/IQKeyboardManager.git", "7.0.3"..<"8.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", "7.12.0"..<"8.0.0"),
        .package(url: "https://github.com/kasketis/netfox.git", "1.21.0"..<"2.0.0"),
        .package(url: "https://github.com/slackhq/PanModal.git", "1.2.7"..<"2.0.0"),
        .package(url: "https://github.com/sunshinejr/SwiftyUserDefaults.git", "5.3.0"..<"6.0.0"),
    ],
    targets: [
        .target(
            name: "Sources",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "IQKeyboardManagerSwift", package: "IQKeyboardManager"),
                .product(name: "netfox", package: "netfox"),
                .product(name: "PanModal", package: "PanModal"),
                .product(name: "SwiftyUserDefaults", package: "SwiftyUserDefaults")
            ],
            path: "Sources"
        ),
        
    ]
)
