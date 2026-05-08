# Clipboard Monitoring

## Goal

Detect clipboard changes and persist useful clipboard history.

Clipboard monitoring is the foundation of the application.

---

# Responsibilities

The monitoring system should:
- detect clipboard changes
- extract supported content
- avoid duplicates
- persist valid entries

---

# Supported Types (V1)

Support:
- plain text

Future:
- images
- files
- rich text

Do not implement future types yet.

---

# Monitoring Strategy

Use:
NSPasteboard.general

The monitor should:
- observe changeCount
- avoid aggressive polling
- remain lightweight

---

# Duplicate Handling

Avoid storing:
- consecutive duplicate entries

Duplicates should:
- refresh timestamps if appropriate

---

# Persistence

Clipboard items should:
- persist locally using SwiftData
- survive app restarts

---

# Technical Requirements

Separate responsibilities:
- monitoring
- parsing
- persistence

Suggested services:
- ClipboardMonitor
- ClipboardParser
- ClipboardRepository

---

# Performance

Clipboard monitoring must:
- use minimal CPU
- avoid memory leaks
- avoid excessive allocations

---

# Error Handling

The monitor should:
- fail gracefully
- recover automatically when possible

Never:
- crash the app due to clipboard parsing

---

# Privacy

Clipboard monitoring must respect:
- privacy mode
- blocked applications

Sensitive clipboard content should never be stored.