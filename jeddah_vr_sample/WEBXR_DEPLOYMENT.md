# WebXR Deployment Guide - Jeddah VR

## Quick Start: Deploy & Test on VR Headset

### Option 1: GitHub Pages (Easiest - Automatic)
GitHub Actions automatically publishes the web-ready folder to GitHub Pages on every push.

1. **Commit your changes:**
   ```bash
   cd /workspaces/Vrproject
   git add .
   git commit -m "Add UI wiring and ready for WebXR testing"
   git push origin improve-graphics-main
   ```

2. **Access on VR Headset:**
   - Once pushed, GitHub Actions workflow runs automatically
   - Your project will be live at: `https://reemalialramadan-lgtm.github.io/Vrproject/`
   - Open this URL in your Meta Quest, Meta 2, or any WebXR-capable headset browser
   - Click "Enter VR" or press the VR button on your headset

3. **Note:** The A-Frame demo in `web-ready/index.html` is the current WebXR entry point.

---

### Option 2: Godot HTML5 Export (Full Feature Export)
Export the complete Godot project to HTML5 for full interactivity.

#### Prerequisites:
- Godot 4 installed on your local machine
- HTML5 export templates installed in Godot

#### Steps:

1. **Download Godot 4:**
   - Visit https://godotengine.org/download/windows
   - Download Godot 4.x (standard or mono version)

2. **Install HTML5 Export Templates:**
   - Open Godot Editor
   - Go to `Project → Export`
   - Click "Install missing export templates"
   - Select HTML5 and install

3. **Export the Project:**
   ```bash
   # Option A: Use the provided export script (Linux/Mac)
   cd /workspaces/Vrproject/jeddah_vr_sample
   bash export_html5.sh

   # Option B: Manual export via Godot Editor
   # - Open Godot → File → Export Project
   # - Select "HTML5 (WebXR)" preset
   # - Choose output folder: jeddah_vr_sample/web-ready/godot-export/
   # - Click "Export Project"
   ```

4. **Deploy Exported Files:**
   ```bash
   # Copy to Netlify or GitHub Pages
   cp -r jeddah_vr_sample/web-ready/godot-export/* jeddah_vr_sample/web-ready/
   git add -A
   git commit -m "Export Godot project to HTML5"
   git push
   ```

5. **Access on VR Headset:**
   - Wait for GitHub Actions to publish (check Actions tab)
   - Open `https://reemalialramadan-lgtm.github.io/Vrproject/` on your headset
   - Click "Enter VR" button

---

### Option 3: Netlify Drag & Drop (No GitHub Required)
Fast deployment without git involvement.

1. **Export Godot project locally** (see Option 2, step 3)

2. **Deploy to Netlify:**
   - Visit https://app.netlify.com/drop
   - Drag & drop the `jeddah_vr_sample/web-ready/godot-export/` folder
   - Netlify generates a public HTTPS URL instantly

3. **Access on VR Headset:**
   - Copy the Netlify URL (e.g., `https://xyz123.netlify.app`)
   - Open in your headset browser
   - Click "Enter VR"

---

### Option 4: Local Testing (Development)
For local testing before deployment.

```bash
# Start a local HTTP server
cd /workspaces/Vrproject/jeddah_vr_sample/web-ready
python3 -m http.server 8000

# Access locally
# http://localhost:8000
```

⚠️ **Note:** WebXR may not work on localhost (requires HTTPS on most headsets). Use Options 1-3 for actual VR testing.

---

## Current Setup

### What's Ready to Deploy:
- ✅ **Godot Project** (Plaza.tscn with UI, environment, vegetation)
- ✅ **UI Wiring** (All buttons functional: Explore, Enter Tower, Exit, Back)
- ✅ **A-Frame WebXR Demo** (`web-ready/index.html`)
- ✅ **Export Presets** (HTML5 preset configured)
- ✅ **GitHub Actions CI/CD** (Auto-publishes web-ready to gh-pages)
- ✅ **Deployment Scripts** (export_html5.sh, netlify-deploy.sh, gh-pages-publish.sh)

### Next Steps After Deployment:
1. Test on VR headset (check button interactions, player movement)
2. Verify lighting, colors, and UI visibility in VR
3. If needed, adjust:
   - Camera FOV (for comfort)
   - UI scale (for readability)
   - Player movement speed
   - Lighting/sky color

---

## Troubleshooting

### "WebXR not available" error
- **Cause:** Localhost or HTTP (non-HTTPS) access
- **Solution:** Use GitHub Pages or Netlify (HTTPS required)

### "Export failed" error
- **Cause:** Godot 4 not installed or HTML5 templates missing
- **Solution:** Install Godot 4 and export templates (see Option 2)

### "Scene not found" error
- **Cause:** Scene path incorrect in export
- **Solution:** Verify `project.godot` has `run/main_scene="res://scenes/Plaza.tscn"`

### Project looks dark or colors off
- **Cause:** WebGL2 rendering differences
- **Solution:** Check StandardMaterial3D settings; adjust metallic/roughness values

---

## VR Headset Access

### Meta Quest 3 / Quest Pro
- Open Meta Browser
- Paste URL in address bar
- Tap "Enter VR" or press VR button

### Meta 2 (Passthrough)
- Open built-in browser
- Paste URL
- Enable "Immersive Mode" or VR view

### Other WebXR Headsets (Valve Index, HTC Vive, etc.)
- Use SteamVR or native browser
- Open HTTPS URL
- Enter immersive mode via headset button

---

## Publishing Commands (Quick Reference)

```bash
# GitHub Pages (automatic on push)
git push origin improve-graphics-main

# Netlify (manual, no git)
drag-and-drop /web-ready/godot-export/ to app.netlify.com

# Local testing
python3 -m http.server 8000 -d /web-ready/godot-export/
```

---

## File Locations

| File | Purpose |
|------|---------|
| `jeddah_vr_sample/project.godot` | Godot project configuration |
| `jeddah_vr_sample/scenes/Plaza.tscn` | Main VR scene (exported as web app) |
| `jeddah_vr_sample/export_presets.cfg` | Export configurations (HTML5 + Android) |
| `jeddah_vr_sample/web-ready/` | Web deployment assets |
| `jeddah_vr_sample/web-ready/index.html` | A-Frame WebXR demo (current entry point) |
| `.github/workflows/publish-web-ready.yml` | GitHub Actions auto-publish workflow |

---

**Status:** Ready for WebXR deployment! 🚀
