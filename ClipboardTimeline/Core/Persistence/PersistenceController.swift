// MARK: - Xcode / SwiftData build

#if !SPM_BUILD
import SwiftData

/// Owns the app's ModelContainer.
/// Used only at bootstrap — services receive ModelContext via constructor injection.
@MainActor
final class PersistenceController {
    static let shared = PersistenceController()

    let container: ModelContainer

    var mainContext: ModelContext {
        container.mainContext
    }

    private init() {
        do {
            container = try ModelContainer(for: ClipboardEntry.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}

// MARK: - SPM build stub

#else

@MainActor
final class PersistenceController {
    static let shared = PersistenceController()
    private init() {}
}

#endif
