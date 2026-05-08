import SwiftUI

struct HistoryWindowView: View {
    @ObservedObject var viewModel: ClipboardHistoryViewModel

    var body: some View {
        VStack(spacing: 0) {
            searchBarPlaceholder
            Divider()
            content
        }
        .frame(width: 560, height: 420)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Subviews

    /// Placeholder until the Search feature is implemented.
    private var searchBarPlaceholder: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
                .font(.system(size: 15))
            Text("Search clipboard…")
                .foregroundStyle(.tertiary)
                .font(.system(size: 15))
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.entries.isEmpty {
            emptyState
        } else {
            entryList
        }
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "clipboard")
                .font(.system(size: 30))
                .foregroundStyle(.secondary)
            Text("No clipboard history yet")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var entryList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 2) {
                    ForEach(viewModel.entries) { entry in
                        ClipboardEntryRow(
                            entry: entry,
                            isSelected: viewModel.selectedEntryID == entry.id
                        )
                        .id(entry.id)
                        .onTapGesture {
                            viewModel.selectedEntryID = entry.id
                            viewModel.copySelected()
                        }
                    }
                }
                .padding(.vertical, 6)
            }
            .onChange(of: viewModel.selectedEntryID) { _, newID in
                guard let id = newID else { return }
                withAnimation(.easeInOut(duration: 0.1)) {
                    proxy.scrollTo(id, anchor: .center)
                }
            }
        }
    }
}

// MARK: - Preview

#if !SPM_BUILD
#Preview {
    struct MockRepository: ClipboardRepositoryProtocol {
        func save(_ content: ClipboardContent) throws {}
        func mostRecent() -> ClipboardEntry? { nil }
        func toggleFavorite(_ entry: ClipboardEntry) throws {}
        func fetchRecent(limit: Int) -> [ClipboardEntry] {
            [
                ClipboardEntry(text: "let greeting = \"Hello, World!\""),
                ClipboardEntry(text: "https://developer.apple.com/documentation/swiftui"),
                ClipboardEntry(text: "The quick brown fox jumps over the lazy dog. This is a longer text that may wrap."),
                ClipboardEntry(text: "cmd + shift + v"),
                ClipboardEntry(text: "SwiftData @Model macro"),
            ]
        }
    }

    let vm = ClipboardHistoryViewModel(repository: MockRepository())
    return HistoryWindowView(viewModel: vm)
}
#endif
