import AppKit

/// Stateless service that extracts typed content from a pasteboard.
/// Returns nil for unsupported types or empty strings.
struct ClipboardParser: ClipboardParsing {
    func parse(_ pasteboard: NSPasteboard) -> ClipboardContent? {
        guard
            let text = pasteboard.string(forType: .string),
            !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            return nil
        }
        return .text(text)
    }
}
