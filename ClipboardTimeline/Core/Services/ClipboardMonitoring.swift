import Foundation

@MainActor
protocol ClipboardMonitoring: AnyObject {
    var onPasteboardChange: (() -> Void)? { get set }
    func start()
    func stop()
}
