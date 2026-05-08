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
            // SPM_BUILD disables @Model and #Preview macros (require Xcode plugins).
            swiftSettings: [.define("SPM_BUILD")]
        )
    ]
)
