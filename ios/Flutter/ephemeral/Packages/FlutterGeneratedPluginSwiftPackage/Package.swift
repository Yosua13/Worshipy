// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
//
//  Generated file. Do not edit.
//

import PackageDescription

let package = Package(
    name: "FlutterGeneratedPluginSwiftPackage",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "FlutterGeneratedPluginSwiftPackage", type: .static, targets: ["FlutterGeneratedPluginSwiftPackage"])
    ],
    dependencies: [
        .package(name: "audio_session", path: "/Users/tabeldata/.pub-cache/hosted/pub.dev/audio_session-0.2.1/ios/audio_session"),
        .package(name: "just_audio", path: "/Users/tabeldata/.pub-cache/hosted/pub.dev/just_audio-0.10.2/darwin/just_audio"),
        .package(name: "path_provider_foundation", path: "/Users/tabeldata/.pub-cache/hosted/pub.dev/path_provider_foundation-2.4.1/darwin/path_provider_foundation")
    ],
    targets: [
        .target(
            name: "FlutterGeneratedPluginSwiftPackage",
            dependencies: [
                .product(name: "audio-session", package: "audio_session"),
                .product(name: "just-audio", package: "just_audio"),
                .product(name: "path-provider-foundation", package: "path_provider_foundation")
            ]
        )
    ]
)
