// Reserved for SwiftData integration.
// ModelContainer setup requires @Model types, which depend on Xcode's
// SwiftDataMacros plugin and are not available in SPM / Command Line Tools builds.
@MainActor
final class PersistenceController {
    static let shared = PersistenceController()
    private init() {}
}
