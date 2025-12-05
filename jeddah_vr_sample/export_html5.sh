#!/bin/bash

# Jeddah VR - Godot HTML5 Export & Deploy Script
# This script exports the Godot project to HTML5 and prepares it for WebXR deployment

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WEB_READY_DIR="$PROJECT_DIR/web-ready"
EXPORT_DIR="$WEB_READY_DIR/godot-export"

echo "================================"
echo "Jeddah VR - Godot HTML5 Export"
echo "================================"
echo ""
echo "Project Directory: $PROJECT_DIR"
echo "Export Directory: $EXPORT_DIR"
echo ""

# Create export directory if it doesn't exist
mkdir -p "$EXPORT_DIR"

echo "Step 1: Checking for Godot 4..."
if command -v godot4 &> /dev/null; then
    GODOT_CMD="godot4"
elif command -v godot &> /dev/null; then
    GODOT_CMD="godot"
else
    echo "ERROR: Godot 4 is not installed or not in PATH"
    echo "Please install Godot 4 from https://godotengine.org/download"
    exit 1
fi

echo "Found: $($GODOT_CMD --version)"
echo ""

echo "Step 2: Exporting to HTML5 (Web)..."
$GODOT_CMD --headless --export-release "HTML5 (WebXR)" "$EXPORT_DIR/index.html" --path "$PROJECT_DIR"

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Export successful!"
    echo ""
    echo "Step 3: Export files ready at: $EXPORT_DIR"
    echo ""
    ls -lah "$EXPORT_DIR/"
    echo ""
    echo "================================"
    echo "Next Steps:"
    echo "================================"
    echo ""
    echo "Option A: Deploy to GitHub Pages"
    echo "  1. Copy files from $EXPORT_DIR to gh-pages branch"
    echo "  2. Push to GitHub"
    echo "  3. Access via: https://yourusername.github.io/Vrproject/"
    echo ""
    echo "Option B: Deploy to Netlify"
    echo "  1. Drag & drop $EXPORT_DIR folder to https://app.netlify.com"
    echo "  2. Get a public HTTPS link for VR headset access"
    echo ""
    echo "Option C: Local Testing"
    echo "  1. Start a local HTTP server: python3 -m http.server 8000 -d $EXPORT_DIR"
    echo "  2. Access via: http://localhost:8000"
    echo "  3. Note: WebXR may not work on localhost (requires HTTPS on most headsets)"
    echo ""
else
    echo "ERROR: Export failed!"
    exit 1
fi
