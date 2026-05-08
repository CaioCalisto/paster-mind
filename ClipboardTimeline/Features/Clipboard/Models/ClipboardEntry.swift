import Foundation

// MARK: - Xcode / SwiftData build

#if !SPM_BUILD
import SwiftData

@Model
final class ClipboardEntry {
    var id: UUID
    var text: String
    var createdAt: Date
    var isFavorite: Bool
    var sourceApp: String?
    var sourceBundleID: String?

    init(text: String, sourceApp: String? = nil, sourceBundleID: String? = nil) {
        self.id = UUID()
        self.text = text
        self.createdAt = .now
        self.isFavorite = false
        self.sourceApp = sourceApp
        self.sourceBundleID = sourceBundleID
    }
}

// MARK: - SPM build (no SwiftDataMacros plugin available)

#else

struct ClipboardEntry: Identifiable {
    let id: UUID
    var text: String
    var createdAt: Date
    var isFavorite: Bool
    var sourceApp: String?
    var sourceBundleID: String?

    init(text: String, sourceApp: String? = nil, sourceBundleID: String? = nil) {
        self.id = UUID()
        self.text = text
        self.createdAt = .now
        self.isFavorite = false
        self.sourceApp = sourceApp
        self.sourceBundleID = sourceBundleID
    }
}

#endif
