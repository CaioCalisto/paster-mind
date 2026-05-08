import SwiftUI

@main
struct ClipboardTimelineApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        MenuBarExtra("Clipboard Timeline", systemImage: "doc.on.clipboard") {
            #if !SPM_BUILD
            MenuBarView()
                .modelContainer(PersistenceController.shared.container)
            #else
            MenuBarView()
            #endif
        }
        .menuBarExtraStyle(.window)

        Settings {
            EmptyView()
        }
    }
}
