import SwiftUI

struct MenuBarView: View {
    var body: some View {
        VStack(spacing: 0) {
            Button {
                NSApp.sendAction(#selector(AppDelegate.openHistoryWindow), to: nil, from: nil)
            } label: {
                HStack {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Clipboard History")
                    Spacer()
                    Text("⌘⇧V")
                        .font(.system(size: 11))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)

            Divider()

            Button("Quit Clipboard Timeline") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
            .padding(8)
        }
        .frame(width: 240)
    }
}
