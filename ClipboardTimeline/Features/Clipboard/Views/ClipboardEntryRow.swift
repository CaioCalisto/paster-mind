import SwiftUI

struct ClipboardEntryRow: View {
    let entry: ClipboardEntry
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 3) {
                Text(entry.text)
                    .lineLimit(2)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(isSelected ? .white : .primary)

                Text(entry.createdAt, style: .relative)
                    .font(.system(size: 11))
                    .foregroundStyle(isSelected ? .white.opacity(0.65) : .secondary)
            }

            Spacer()

            if entry.isFavorite {
                Image(systemName: "star.fill")
                    .font(.system(size: 11))
                    .foregroundStyle(isSelected ? .white.opacity(0.8) : .yellow)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(isSelected ? Color.accentColor : .clear)
        )
        .contentShape(Rectangle())
        .padding(.horizontal, 8)
    }
}

// MARK: - Preview

#if !SPM_BUILD
#Preview("Selected") {
    ClipboardEntryRow(
        entry: .init(text: "let greeting = \"Hello, World!\""),
        isSelected: true
    )
    .frame(width: 560)
    .padding(.vertical, 4)
}

#Preview("Normal") {
    ClipboardEntryRow(
        entry: .init(text: "This is a longer piece of text that was copied from a document. It may wrap to a second line."),
        isSelected: false
    )
    .frame(width: 560)
    .padding(.vertical, 4)
}
#endif
