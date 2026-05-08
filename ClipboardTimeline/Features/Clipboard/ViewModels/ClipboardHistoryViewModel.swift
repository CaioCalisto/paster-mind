import AppKit

@MainActor
final class ClipboardHistoryViewModel: ObservableObject {
    private let repository: any ClipboardRepositoryProtocol

    @Published var entries: [ClipboardEntry] = []
    @Published var selectedEntryID: ClipboardEntry.ID?

    /// Called after a successful copy so the window controller can close the panel.
    var onItemCopied: (() -> Void)?

    init(repository: any ClipboardRepositoryProtocol) {
        self.repository = repository
    }

    func loadEntries() {
        entries = repository.fetchRecent(limit: 50)
        selectedEntryID = entries.first?.id
    }

    func selectNext() {
        move(by: +1)
    }

    func selectPrevious() {
        move(by: -1)
    }

    /// Writes the selected entry back to the pasteboard, then fires `onItemCopied`.
    /// The re-copy is loop-safe: the monitor will detect the pasteboard change and
    /// call `repo.save()`, which promotes the existing entry rather than inserting
    /// a duplicate (dedup checks all history, not just the most recent entry).
    @discardableResult
    func copySelected() -> Bool {
        guard
            let id = selectedEntryID,
            let entry = entries.first(where: { $0.id == id })
        else { return false }

        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(entry.text, forType: .string)
        onItemCopied?()
        return true
    }

    // MARK: - Private

    private func move(by offset: Int) {
        guard !entries.isEmpty else { return }

        let currentIndex = selectedEntryID
            .flatMap { id in entries.firstIndex(where: { $0.id == id }) }
            ?? -1

        let newIndex = min(max(currentIndex + offset, 0), entries.count - 1)
        selectedEntryID = entries[newIndex].id
    }
}
