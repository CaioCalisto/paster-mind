import AppKit

/// NSPanel subclass that accepts key events and floats above other windows.
/// AppKit is required here: SwiftUI has no API for NSWindowLevel or custom keyDown handling.
final class FloatingPanel: NSPanel {
    /// Return true to mark the event as handled and suppress default processing.
    var onKeyDown: ((NSEvent) -> Bool)?

    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { false }

    override func keyDown(with event: NSEvent) {
        guard onKeyDown?(event) != true else { return }
        super.keyDown(with: event)
    }
}
