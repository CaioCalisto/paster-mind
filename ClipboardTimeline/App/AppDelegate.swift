import AppKit

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private var monitor: ClipboardMonitor?
    private var repository: ClipboardRepository?
    private var historyWindowController: HistoryWindowController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        setupRepository()
        startClipboardMonitoring()
        setupHistoryWindow()
    }

    func applicationWillTerminate(_ notification: Notification) {
        monitor?.stop()
    }

    /// Called via NSApp responder chain from MenuBarView.
    @objc func openHistoryWindow() {
        historyWindowController?.show()
    }

    // MARK: - Private

    private func setupRepository() {
        #if !SPM_BUILD
        repository = ClipboardRepository(context: PersistenceController.shared.mainContext)
        #else
        repository = ClipboardRepository()
        #endif
    }

    private func startClipboardMonitoring() {
        guard let repo = repository else { return }

        let monitor = ClipboardMonitor()
        let parser = ClipboardParser()

        monitor.onPasteboardChange = {
            guard let content = parser.parse(.general) else { return }
            try? repo.save(content)
        }

        monitor.start()
        self.monitor = monitor
    }

    private func setupHistoryWindow() {
        guard let repo = repository else { return }
        let viewModel = ClipboardHistoryViewModel(repository: repo)
        historyWindowController = HistoryWindowController(viewModel: viewModel)
    }
}
