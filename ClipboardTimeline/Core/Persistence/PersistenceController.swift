import SwiftData

@MainActor
final class PersistenceController {
    static let shared = PersistenceController()

    private(set) var container: ModelContainer?

    private init() {}

    // Call once models are defined, e.g. in ClipboardTimelineApp:
    //   try PersistenceController.shared.setup(for: [ClipboardEntry.self])
    func setup(for types: [any PersistentModel.Type]) throws {
        let schema = Schema(types)
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        container = try ModelContainer(for: schema, configurations: [config])
    }
}
