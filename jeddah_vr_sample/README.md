Jeddah Tower VR — Prototype (Godot 4)

This is a minimal sample project scaffold for a VR architectural visualization prototype focused on the Jeddah Tower. It contains placeholder scenes, scripts, Arabic localization stubs, and a small README to get started.

How to open:
- Download or clone the folder into your local machine.
- Open in Godot 4.2+ (export templates required to export builds).

Structure:
- scenes/
  - Plaza.tscn (main scene — exterior plaza with a tower placeholder)
  - TowerExterior.tscn
  - TowerInterior.tscn
- scripts/
  - player.gd (simple VR-friendly locomotion controls)
  - enter_tower.gd (scene change helper)
  - locale.gd (locale loader + sample calls)
- translations/ (placeholder .po files for en & ar)
- assets/fonts/ (sample Arabic font provided)
- assets/audio/ar/ (placeholder narration files)

Next steps:
- Replace placeholders with your 3D models (glTF), textures, and localized audio.
- Configure OpenXR and export for your headset.

Quick web / WebXR steps
- Export HTML5 from Godot locally (Project → Export → HTML5) — copy the export files into `web-ready/`.
- Deploy `web-ready/` to Netlify (drag & drop) or GitHub Pages (via `gh-pages` branch or `docs/` directory) — both provide HTTPS for WebXR.
- Controller mapping guidance and verification steps are available at `web-ready/controller_mapping.md`.

Where files are
- scenes/
  - Plaza.tscn (main scene — exterior plaza with a tower placeholder)
  - TowerExterior.tscn
  - TowerInterior.tscn
- scripts/
  - player.gd (simple VR-friendly locomotion controls)
  - enter_tower.gd (scene change helper)
  - locale.gd (locale loader + sample calls)
- translations/ (placeholder .po files for en & ar)
- assets/fonts/ (sample Arabic font provided)
- assets/audio/ar/ (placeholder narration files)
- web-ready/ (example index + deploy scripts for Netlify/GitHub Pages)

Netlify quick deploy
- Copy export files into web-ready/ and drag/drop that folder at https://app.netlify.com/drop

GitHub Pages CI / Automations
- A workflow `/.github/workflows/publish-web-ready.yml` is included — it deploys `jeddah_vr_sample/web-ready` to the `gh-pages` branch anytime `main` is pushed. Ensure the `web-ready` folder contains the final exported HTML5 files (index.html, *.js, *.wasm, *.pck) before pushing to `main`.

Notes
- WebXR requires HTTPS. Netlify / GitHub Pages provide HTTPS by default. Open the provided URL in your headset browser.
- For best performance target lower resolutions and compress `.wasm`/`.js` using gzip/brotli on deploy.

XR input helper (added)
- File: `scripts/xr_input_helper.gd` — attach this script to your XR origin node (XROrigin3D) or a central manager node.
- Configure `left_controller_node_path` and `right_controller_node_path` to match your scene's controller node names (e.g., `XROrigin/LeftController`).
- Use the `DebugOverlay` (already included) to inspect actual axis and button indices observed by your headset/browser. Tune `thumbstick_x_axis_index`, `thumbstick_y_axis_index`, `trigger_axis_index`, and button indices in `xr_input_helper.gd` to match those values.

Tip: In WebXR different browsers/headsets expose controller indices slightly differently — using `DebugOverlay` to see the current values makes mapping fast and reliable.
