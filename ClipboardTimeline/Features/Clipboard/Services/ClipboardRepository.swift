// MARK: - Xcode / SwiftData build

#if !SPM_BUILD
import SwiftData

@MainActor
final class ClipboardRepository: ClipboardRepositoryProtocol {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(_ content: ClipboardContent) throws {
        switch content {
        case .text(let text, let sourceApp, let sourceBundleID):
            if let recent = mostRecent(), recent.text == text {
                recent.createdAt = .now
            } else {
                context.insert(ClipboardEntry(text: text, sourceApp: sourceApp, sourceBundleID: sourceBundleID))
            }
        }
        try context.save()
    }

    func mostRecent() -> ClipboardEntry? {
        var descriptor = FetchDescriptor<ClipboardEntry>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }

    func fetchRecent(limit: Int) -> [ClipboardEntry] {
        var descriptor = FetchDescriptor<ClipboardEntry>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        descriptor.fetchLimit = limit
        return (try? context.fetch(descriptor)) ?? []
    }

    func toggleFavorite(_ entry: ClipboardEntry) throws {
        entry.isFavorite.toggle()
        try context.save()
    }
}

// MARK: - SPM build (in-memory, no SwiftData)

#else

@MainActor
final class ClipboardRepository: ClipboardRepositoryProtocol {
    private var entries: [ClipboardEntry] = []

    func save(_ content: ClipboardContent) throws {
        switch content {
        case .text(let text, let sourceApp, let sourceBundleID):
            if entries.last?.text == text {
                entries[entries.endIndex - 1].createdAt = .now
            } else {
                entries.append(ClipboardEntry(text: text, sourceApp: sourceApp, sourceBundleID: sourceBundleID))
            }
        }
    }

    func mostRecent() -> ClipboardEntry? {
        entries.sorted { $0.createdAt > $1.createdAt }.first
    }

    func fetchRecent(limit: Int) -> [ClipboardEntry] {
        Array(entries.sorted { $0.createdAt > $1.createdAt }.prefix(limit))
    }

    func toggleFavorite(_ entry: ClipboardEntry) throws {
        guard let index = entries.firstIndex(where: { $0.id == entry.id }) else { return }
        entries[index].isFavorite.toggle()
    }
}

#endif
