import SwiftUI

struct HistoryWindowView: View {
    @ObservedObject var viewModel: ClipboardHistoryViewModel

    var body: some View {
        VStack(spacing: 0) {
            ClipboardSearchBar(
                text: $viewModel.searchQuery,
                revision: viewModel.searchRevision
            )
            Divider()
            content
        }
        .frame(width: 560, height: 420)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Subviews

    @ViewBuilder
    private var content: some View {
        if viewModel.filteredEntries.isEmpty {
            emptyState
        } else {
            entryList
        }
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: viewModel.searchQuery.isEmpty ? "clipboard" : "magnifyingglass")
                .font(.system(size: 30))
                .foregroundStyle(.secondary)
            Text(emptyMessage)
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var emptyMessage: String {
        if viewModel.searchQuery.isEmpty {
            return "No clipboard history yet"
        }
        let q = viewModel.searchQuery.trimmingCharacters(in: .whitespaces)
        return "No results for \u{201C}\(q)\u{201D}"
    }

    private var entryList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 2) {
                    ForEach(viewModel.filteredEntries) { entry in
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
                ClipboardEntry(text: "let greeting = \"Hello, World!\"", sourceApp: "Xcode"),
                ClipboardEntry(text: "https://developer.apple.com/documentation/swiftui", sourceApp: "Safari"),
                ClipboardEntry(text: "The quick brown fox jumps over the lazy dog.", sourceApp: "Notes"),
                ClipboardEntry(text: "cmd + shift + v"),
                ClipboardEntry(text: "SwiftData @Model macro", sourceApp: "Xcode"),
            ]
        }
    }

    let vm = ClipboardHistoryViewModel(repository: MockRepository())
    return HistoryWindowView(viewModel: vm)
}
#endif
