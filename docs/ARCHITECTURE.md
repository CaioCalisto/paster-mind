# Architecture

## Folder Structure

Features/
Clipboard/
Search/
Favorites/
Settings/

Shared/
Components/
Extensions/
DesignSystem/

Core/
Persistence/
Services/
Utilities/

## Pattern

MVVM

## Dependency Injection

Use protocols for services.

Example:
- ClipboardMonitoring
- ClipboardRepository
- SearchEngine

## Persistence

Use SwiftData.

## UI

SwiftUI-first.

Use AppKit only when macOS APIs require it.

## State Management

Prefer:
- @StateObject
- @Observable
- @Environment

Avoid:
- global singletons