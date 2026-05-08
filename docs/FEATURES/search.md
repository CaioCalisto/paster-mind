# Search Feature

## Goal

Allow users to quickly find clipboard history items.

Search should feel instant.

---

# User Experience

Users can:
- type immediately after opening the window
- filter results in real time
- navigate results with keyboard

Search should:
- tolerate partial matches
- prioritize recent items

---

# V1 Scope

Initial implementation:
- local text matching only

No:
- semantic search
- embeddings
- AI ranking

---

# Matching Rules

Search should:
- be case insensitive
- ignore leading/trailing spaces

Search against:
- clipboard content
- source application name

---

# UI Requirements

Search bar should:
- autofocus on open
- clear easily
- feel native

Filtering should:
- happen in real time
- avoid visible lag

---

# Performance

Search should remain responsive with:
- thousands of clipboard items

Avoid:
- unnecessary recomputation
- blocking the main thread

---

# Future Considerations

Possible future features:
- semantic search
- OCR indexing
- tag search
- fuzzy search
- ranking algorithms

Do not implement yet.