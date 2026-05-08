import AppKit

@MainActor
protocol ClipboardParsing {
    func parse(_ pasteboard: NSPasteboard) -> ClipboardContent?
}
