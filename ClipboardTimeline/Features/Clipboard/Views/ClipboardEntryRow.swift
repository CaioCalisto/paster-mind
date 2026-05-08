import SwiftUI

struct ClipboardEntryRow: View {
    let entry: ClipboardEntry
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            typeIcon
            contentStack
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(selectionBackground)
        .contentShape(Rectangle())
        .padding(.horizontal, 6)
    }

    // MARK: - Subviews

    private var typeIcon: some View {
        Image(systemName: contentType.symbolName)
            .font(.system(size: 11, weight: .medium))
            .foregroundStyle(isSelected ? .white.opacity(0.9) : Color.accentColor)
            .frame(width: 26, height: 26)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(isSelected
                          ? Color.white.opacity(0.15)
                          : Color.accentColor.opacity(0.08))
            )
            .padding(.top, 1)
    }

    private var contentStack: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(entry.text)
                .lineLimit(2)
                .font(.system(size: 13))
                .foregroundStyle(isSelected ? .white : .primary)

            metadataRow
        }
    }

    private var metadataRow: some View {
        HStack(spacing: 3) {
            if let app = entry.sourceApp {
                Text(app)
                Text("·")
            }
            Text(entry.createdAt, style: .relative)
        }
        .font(.system(size: 11))
        .foregroundStyle(isSelected ? .white.opacity(0.6) : .secondary)
    }

    private var selectionBackground: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(isSelected ? Color.accentColor : Color.clear)
    }

    // MARK: - Content type detection

    private enum ContentType {
        case url, code, text

        var symbolName: String {
            switch self {
            case .url:  return "link"
            case .code: return "curlybraces"
            case .text: return "doc.text"
            }
        }
    }

    private var contentType: ContentType {
        let trimmed = entry.text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.hasPrefix("http://") || trimmed.hasPrefix("https://") {
            return .url
        }
        if (trimmed.contains("{") && trimmed.contains("}")) || trimmed.hasPrefix("#!") {
            return .code
        }
        return .text
    }
}

// MARK: - Preview

#if !SPM_BUILD
#Preview("Selected — plain text") {
    ClipboardEntryRow(
        entry: .init(text: "The quick brown fox jumps over the lazy dog.",
                     sourceApp: "Notes"),
        isSelected: true
    )
    .frame(width: 560)
    .padding(.vertical, 4)
}

#Preview("Normal — URL") {
    ClipboardEntryRow(
        entry: .init(text: "https://developer.apple.com/documentation/swiftui",
                     sourceApp: "Safari"),
        isSelected: false
    )
    .frame(width: 560)
    .padding(.vertical, 4)
}

#Preview("Normal — code") {
    ClipboardEntryRow(
        entry: .init(text: "func greet(_ name: String) -> String {\n    return \"Hello, \\(name)!\"\n}",
                     sourceApp: "Xcode"),
        isSelected: false
    )
    .frame(width: 560)
    .padding(.vertical, 4)
}

#Preview("Normal — no source app") {
    ClipboardEntryRow(
        entry: .init(text: "cmd + shift + v"),
        isSelected: false
    )
    .frame(width: 560)
    .padding(.vertical, 4)
}
#endif
