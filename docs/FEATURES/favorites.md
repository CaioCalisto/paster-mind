# Favorites Feature

## Goal

Allow users to pin important clipboard items for long-term access.

Favorites should feel lightweight and fast.

This is not a document management system.

---

# User Experience

Users can:
- favorite clipboard items
- remove favorites
- filter favorites
- quickly re-copy favorite items

Favorited items should:
- persist permanently
- never be auto-deleted
- appear visually distinct

---

# UI Requirements

Favorite actions:
- keyboard shortcut
- context menu
- inline button

Use:
- subtle star icon
- native macOS interactions

Avoid:
- excessive confirmations
- modal dialogs

---

# Technical Requirements

Favorites are stored locally using SwiftData.

A clipboard item contains:
- isFavorite: Bool

Favorites must:
- survive app restarts
- remain searchable
- support keyboard navigation

---

# Performance

Favoriting/unfavoriting should feel instant.

Avoid unnecessary persistence reloads.

---

# Future Considerations

Possible future features:
- favorite folders
- tags
- smart collections

Do not implement these yet.