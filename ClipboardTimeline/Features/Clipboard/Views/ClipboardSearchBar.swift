import SwiftUI

/// Focused search field shown at the top of the clipboard history window.
/// Receives a `revision` counter from the ViewModel and re-focuses whenever
/// it changes — this is needed because the NSHostingView is persistent and
/// onAppear only fires once at creation time.
struct ClipboardSearchBar: View {
    @Binding var text: String
    let revision: Int

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
                .font(.system(size: 15, weight: .medium))

            TextField("Search clipboard…", text: $text)
                .textFieldStyle(.plain)
                .font(.system(size: 15))
                .focused($isFocused)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 14))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .onChange(of: revision) { _, _ in
            isFocused = true
        }
    }
}

// MARK: - Preview

#if !SPM_BUILD
#Preview {
    ClipboardSearchBar(text: .constant("swift"), revision: 0)
        .frame(width: 560)
        .background(.regularMaterial)
}
#endif
