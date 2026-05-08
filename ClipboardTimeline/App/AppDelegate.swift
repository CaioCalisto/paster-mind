import AppKit

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    // Retained for app lifetime.
    // Ownership will move to ClipboardViewModel when UI is implemented.
    private var monitor: ClipboardMonitor?

    func applicationDidFinishLaunching(_ notification: Notification) {
        startClipboardMonitoring()
    }

    func applicationWillTerminate(_ notification: Notification) {
        monitor?.stop()
    }

    private func startClipboardMonitoring() {
        let monitor = ClipboardMonitor()
        let parser = ClipboardParser()
        let repository = ClipboardRepository()

        monitor.onPasteboardChange = {
            guard let content = parser.parse(.general) else { return }
            try? repository.save(content)
        }

        monitor.start()
        self.monitor = monitor
    }
}
