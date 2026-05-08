#!/bin/bash
set -e

APP_NAME="ClipboardTimeline"
BUILD_OUTPUT=".build/debug/$APP_NAME"
APP_BUNDLE="$APP_NAME.app"

echo "Building $APP_NAME..."
swift build

echo "Assembling $APP_BUNDLE..."
rm -rf "$APP_BUNDLE"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

cp "$BUILD_OUTPUT" "$APP_BUNDLE/Contents/MacOS/$APP_NAME"
cp "ClipboardTimeline/App/Info.plist" "$APP_BUNDLE/Contents/Info.plist"

echo ""
echo "Done. Run with:"
echo "  open $APP_BUNDLE"
