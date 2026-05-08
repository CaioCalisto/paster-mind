# Privacy Mode

## Goal

Prevent sensitive clipboard content from being stored.

Privacy is a core product value.

The app should feel trustworthy.

---

# Behavior

When a sensitive application is active:
- clipboard monitoring pauses
- clipboard items are ignored

Examples:
- password managers
- banking apps
- authentication tools

---

# Detection

Use:
NSWorkspace.shared.frontmostApplication

Blocked applications are identified using:
- bundle identifiers

Example:
- com.1password.1password
- com.bitwarden.desktop

---

# User Controls

Users can:
- enable/disable privacy mode
- add blocked apps
- remove blocked apps

Provide:
- simple settings UI
- clear explanations

Avoid:
- complicated configuration

---

# UX Requirements

The app should:
- clearly indicate when monitoring is paused
- avoid alarming language

Examples:
- "Privacy mode active"
- "Clipboard monitoring paused"

---

# Technical Requirements

Privacy checks must:
- be lightweight
- avoid excessive polling

Privacy logic should:
- remain isolated from UI code

Use:
- PrivacyService
- SensitiveAppDetector

---

# Security Principles

Never:
- log sensitive clipboard content
- upload clipboard content
- store blocked app activity

Clipboard data remains local-only.

---

# Future Considerations

Possible future features:
- temporary pause mode
- incognito sessions
- automatic sensitive content detection

Do not implement yet.