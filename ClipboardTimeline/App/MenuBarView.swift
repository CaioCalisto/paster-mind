import SwiftUI

struct MenuBarView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Features will be added here
            Divider()
            Button("Quit Clipboard Timeline") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
            .padding(8)
        }
        .frame(width: 320)
    }
}
