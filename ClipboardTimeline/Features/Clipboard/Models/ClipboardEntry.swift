import Foundation

// NOTE: @Model (SwiftData) requires Xcode's SwiftDataMacros plugin.
// This is a plain struct for SPM / Command Line Tools builds.
// Replace with @Model class when building with Xcode.
struct ClipboardEntry: Identifiable {
    let id: UUID
    var text: String
    var createdAt: Date

    init(text: String, createdAt: Date = .now) {
        self.id = UUID()
        self.text = text
        self.createdAt = createdAt
    }
}
