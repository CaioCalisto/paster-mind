import AppKit

/// NSPanel subclass that accepts key events and floats above other windows.
/// AppKit is required here: SwiftUI has no API for NSWindowLevel or custom keyDown handling.
final class FloatingPanel: NSPanel {
    /// Return true to mark the event as handled and suppress default processing.
    var onKeyDown: ((NSEvent) -> Bool)?

    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { false }

    /// Intercepts key events before they are dispatched to the first responder.
    /// This means navigation keys (↑↓, ↵, ESC) work even when a TextField is focused,
    /// without blocking regular character input from reaching the search field.
    override func sendEvent(_ event: NSEvent) {
        if event.type == .keyDown, let onKeyDown, onKeyDown(event) {
            return  // consumed — do not dispatch to responder chain
        }
        super.sendEvent(event)
    }
}
