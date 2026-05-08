// NOTE: Uses in-memory storage for SPM / Command Line Tools builds.
// Replace with SwiftData ModelContext when building with Xcode.
@MainActor
final class ClipboardRepository: ClipboardRepositoryProtocol {
    private var entries: [ClipboardEntry] = []

    func save(_ content: ClipboardContent) throws {
        switch content {
        case .text(let text):
            if entries.last?.text == text {
                entries[entries.endIndex - 1].createdAt = .now
            } else {
                entries.append(ClipboardEntry(text: text))
            }
        }
    }

    func mostRecent() -> ClipboardEntry? {
        entries.last
    }
}
