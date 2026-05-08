import AppKit
import Carbon.HIToolbox

/// Registers a system-wide CMD+SHIFT+V hotkey via Carbon's RegisterEventHotKey.
/// Does NOT require Input Monitoring or Accessibility permissions.
@MainActor
final class GlobalShortcutMonitor {
    // Read from a C callback (non-isolated). nonisolated(unsafe) is the Swift 6
    // escape hatch — we only write on MainActor and read inside a @MainActor Task.
    private nonisolated(unsafe) static var _onTriggered: (() -> Void)?

    private var hotKeyRef: EventHotKeyRef?
    private var eventHandler: EventHandlerRef?
    var onTriggered: (() -> Void)?

    func start() {
        GlobalShortcutMonitor._onTriggered = { [weak self] in self?.onTriggered?() }

        var hotKeyID = EventHotKeyID()
        hotKeyID.signature = 0x434C_484B  // 'CLHK'
        hotKeyID.id = 1

        RegisterEventHotKey(
            UInt32(kVK_ANSI_V),
            UInt32(cmdKey | shiftKey),
            hotKeyID,
            GetApplicationEventTarget(),
            0,
            &hotKeyRef
        )

        var eventSpec = EventTypeSpec(
            eventClass: OSType(kEventClassKeyboard),
            eventKind: UInt32(kEventHotKeyPressed)
        )

        InstallEventHandler(
            GetApplicationEventTarget(),
            { _, _, _ in
                Task { @MainActor in GlobalShortcutMonitor._onTriggered?() }
                return noErr
            },
            1,
            &eventSpec,
            nil,
            &eventHandler
        )
    }

    func stop() {
        if let ref = hotKeyRef { UnregisterEventHotKey(ref); hotKeyRef = nil }
        if let handler = eventHandler { RemoveEventHandler(handler); eventHandler = nil }
        GlobalShortcutMonitor._onTriggered = nil
    }
}
