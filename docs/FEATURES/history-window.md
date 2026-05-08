# History Window

## Goal

Provide a fast and minimal interface to browse clipboard history.

The interaction should feel similar to:
- Spotlight
- Raycast
- Alfred

---

# Window Behavior

The window:
- floats above other windows
- opens centered
- closes with ESC
- supports keyboard-only navigation

Global shortcut:
CMD + SHIFT + V

---

# UX Requirements

The user should be able to:
- open instantly
- search immediately
- navigate with arrow keys
- press ENTER to copy an item again

Search input should:
- autofocus on open
- support instant filtering

---

# Layout

Structure:
- search bar
- clipboard history list
- optional preview area

Each item should display:
- content preview
- source application
- timestamp
- favorite state

---

# Design Rules

Style:
- clean
- lightweight
- native macOS feeling

Avoid:
- cluttered layouts
- too many borders
- enterprise-style UI

Animations:
- subtle fade/scale transitions
- smooth scrolling

---

# Technical Requirements

Prefer SwiftUI.

Use AppKit only if required for:
- floating window behavior
- keyboard shortcuts
- focus management

Window should:
- reopen quickly
- preserve state when appropriate

---

# Accessibility

Support:
- keyboard navigation
- VoiceOver basics
- high contrast mode
- dark mode

---

# Performance

The window should feel instantaneous.

Avoid:
- blocking operations
- expensive filtering
- excessive re-rendering