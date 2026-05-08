/// Intermediate value type representing parsed clipboard data.
/// Add cases here as new content types are supported (image, file, richText).
enum ClipboardContent: Equatable {
    case text(String)
}
