import AppKit

/// Stateless service that extracts typed content from a pasteboard.
/// Captures the frontmost application at the moment of parsing so the
/// source app can be stored alongside the clipboard entry.
/// Returns nil for unsupported types or empty strings.
struct ClipboardParser: ClipboardParsing {
    func parse(_ pasteboard: NSPasteboard) -> ClipboardContent? {
        guard
            let text = pasteboard.string(forType: .string),
            !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            return nil
        }

        let frontmost = NSWorkspace.shared.frontmostApplication
        return .text(
            text,
            sourceApp: frontmost?.localizedName,
            sourceBundleID: frontmost?.bundleIdentifier
        )
    }
}
