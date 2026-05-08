@MainActor
protocol ClipboardRepositoryProtocol {
    func save(_ content: ClipboardContent) throws
    func mostRecent() -> ClipboardEntry?
}
