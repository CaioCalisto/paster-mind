import AppKit
import SwiftUI

/// Manages the floating clipboard history panel.
/// Owns the panel lifecycle: show, close, keyboard routing.
@MainActor
final class HistoryWindowController: NSWindowController, NSWindowDelegate {
    private let viewModel: ClipboardHistoryViewModel

    init(viewModel: ClipboardHistoryViewModel) {
        self.viewModel = viewModel

        let panel = FloatingPanel(
            contentRect: NSRect(x: 0, y: 0, width: 560, height: 420),
            styleMask: [.titled, .fullSizeContentView],
            backing: .buffered,
            defer: false
        )
        panel.titlebarAppearsTransparent = true
        panel.titleVisibility = .hidden
        panel.isMovableByWindowBackground = true
        panel.level = .floating
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        panel.isOpaque = false
        panel.backgroundColor = .clear
        panel.hidesOnDeactivate = false

        super.init(window: panel)

        panel.delegate = self
        panel.contentView = NSHostingView(
            rootView: HistoryWindowView(viewModel: viewModel)
        )

        panel.onKeyDown = { [weak self] event in
            guard let self else { return false }
            switch event.keyCode {
            case 53:  close(); return true                              // ESC
            case 125: viewModel.selectNext(); return true               // ↓
            case 126: viewModel.selectPrevious(); return true           // ↑
            case 36:  viewModel.copySelected(); close(); return true    // ↵ copy + close
            case 9 where event.modifierFlags.intersection(.deviceIndependentFlagsMask) == [.command, .shift]:
                      close(); return true                              // ⌘⇧V toggle close
            default:  return false
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not supported")
    }

    // MARK: - Public

    func show() {
        viewModel.loadEntries()
        window?.center()
        showWindow(nil)
        window?.makeKeyAndOrderFront(nil)
    }

    func toggle() {
        guard let window else { return }
        window.isVisible ? close() : show()
    }

    // MARK: - NSWindowDelegate

    func windowDidResignKey(_ notification: Notification) {
        close()
    }
}
