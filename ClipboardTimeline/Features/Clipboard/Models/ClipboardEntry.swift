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

    init(text: String) {
        self.id = UUID()
        self.text = text
        self.createdAt = .now
        self.isFavorite = false
    }
}

// MARK: - SPM build (no SwiftDataMacros plugin available)

#else

struct ClipboardEntry: Identifiable {
    let id: UUID
    var text: String
    var createdAt: Date
    var isFavorite: Bool

    init(text: String) {
        self.id = UUID()
        self.text = text
        self.createdAt = .now
        self.isFavorite = false
    }
}

#endif
