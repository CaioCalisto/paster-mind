// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ClipboardTimeline",
    platforms: [.macOS(.v14)],
    targets: [
        .executableTarget(
            name: "ClipboardTimeline",
            path: "ClipboardTimeline",
            exclude: ["App/Info.plist"],
            // SPM_BUILD disables @Model macro (requires Xcode's SwiftDataMacros plugin).
            // Remove this flag when building with Xcode.
            swiftSettings: [.define("SPM_BUILD")]
        )
    ]
)
