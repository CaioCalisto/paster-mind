import SwiftUI

@main
struct ClipboardTimelineApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        MenuBarExtra("Clipboard Timeline", systemImage: "doc.on.clipboard") {
            MenuBarView()
        }
        .menuBarExtraStyle(.window)

        Settings {
            EmptyView()
        }
    }
}
