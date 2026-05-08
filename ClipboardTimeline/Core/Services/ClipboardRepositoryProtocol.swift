@MainActor
protocol ClipboardRepositoryProtocol {
    /// Persists new content. Refreshes timestamp on consecutive duplicates.
    func save(_ content: ClipboardContent) throws

    /// Returns the single most recent entry without fetching the full history.
    func mostRecent() -> ClipboardEntry?

    /// Returns the most recent entries up to `limit`, sorted newest first.
    func fetchRecent(limit: Int) -> [ClipboardEntry]

    /// Toggles the favorite flag on an existing entry.
    func toggleFavorite(_ entry: ClipboardEntry) throws
}
