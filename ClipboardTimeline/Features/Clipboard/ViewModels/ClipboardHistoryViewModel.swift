import AppKit

@MainActor
final class ClipboardHistoryViewModel: ObservableObject {
    private let repository: any ClipboardRepositoryProtocol

    /// The visible, filtered list. Views bind to this — never to `entries` directly.
    @Published private(set) var filteredEntries: [ClipboardEntry] = []
    @Published var selectedEntryID: ClipboardEntry.ID?

    /// Drives instant filtering. Setting this re-runs `applyFilter()` via `didSet`.
    @Published var searchQuery: String = "" {
        didSet { applyFilter() }
    }

    /// Incremented each time the window opens so the search bar can re-focus.
    @Published private(set) var searchRevision: Int = 0

    /// Called after a successful copy so the window controller can close the panel.
    var onItemCopied: (() -> Void)?

    // Raw unfiltered list — private because views should always read filteredEntries.
    private var entries: [ClipboardEntry] = []

    init(repository: any ClipboardRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Public

    func loadEntries() {
        entries = repository.fetchRecent(limit: 50)
        searchQuery = ""        // clears query and triggers applyFilter via didSet
        searchRevision += 1     // signals ClipboardSearchBar to re-focus
    }

    func selectNext() {
        move(by: +1)
    }

    func selectPrevious() {
        move(by: -1)
    }

    /// Copies the selected entry to the pasteboard, then fires `onItemCopied`.
    @discardableResult
    func copySelected() -> Bool {
        guard
            let id = selectedEntryID,
            let entry = filteredEntries.first(where: { $0.id == id })
        else { return false }

        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(entry.text, forType: .string)
        onItemCopied?()
        return true
    }

    // MARK: - Private

    /// Filters `entries` by `searchQuery` and updates `selectedEntryID`.
    /// Matching is case-insensitive and covers both content text and source app name.
    private func applyFilter() {
        let trimmed = searchQuery.trimmingCharacters(in: .whitespaces)

        filteredEntries = trimmed.isEmpty
            ? entries
            : entries.filter { entry in
                entry.text.localizedCaseInsensitiveContains(trimmed)
                    || (entry.sourceApp?.localizedCaseInsensitiveContains(trimmed) ?? false)
            }

        // Preserve the current selection if it is still visible; otherwise jump to
        // the first result. When the list is empty, selection becomes nil.
        if filteredEntries.first(where: { $0.id == selectedEntryID }) == nil {
            selectedEntryID = filteredEntries.first?.id
        }
    }

    private func move(by offset: Int) {
        guard !filteredEntries.isEmpty else { return }

        let currentIndex = selectedEntryID
            .flatMap { id in filteredEntries.firstIndex(where: { $0.id == id }) }
            ?? -1

        let newIndex = min(max(currentIndex + offset, 0), filteredEntries.count - 1)
        selectedEntryID = filteredEntries[newIndex].id
    }
}
