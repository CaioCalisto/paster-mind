import AppKit

/// Polls NSPasteboard.changeCount at a fixed interval.
/// Responsible only for detecting changes — no parsing, no persistence.
@MainActor
final class ClipboardMonitor: ClipboardMonitoring {
    var onPasteboardChange: (() -> Void)?

    private var timer: Timer?
    private var lastChangeCount: Int

    init() {
        lastChangeCount = NSPasteboard.general.changeCount
    }

    func start() {
        guard timer == nil else { return }

        // .common mode ensures the timer fires during UI events (scrolling, modals).
        let timer = Timer(timeInterval: 0.5, repeats: true) { [weak self] _ in
            MainActor.assumeIsolated {
                self?.checkForChanges()
            }
        }
        RunLoop.main.add(timer, forMode: .common)
        self.timer = timer
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    private func checkForChanges() {
        let current = NSPasteboard.general.changeCount
        guard current != lastChangeCount else { return }
        lastChangeCount = current
        onPasteboardChange?()
    }
}
