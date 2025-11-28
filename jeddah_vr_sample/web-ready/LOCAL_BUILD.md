Local build checklist for Godot -> HTML5 (WebXR)

1) Open project in Godot 4.2+.
2) Project -> Export -> Add -> HTML5.
   - Recommended: embed PCK for a single-file deployment OR choose not to embed if you want separate pck.
   - Choose 'Export Path' to a local folder (e.g., build-html5/)
3) Export. Copy the resulting files (index.html, *.js, *.wasm, optional .pck) into this web-ready/ folder.
4) Optional: test local (non-https) using a local server:
   - Python: python3 -m http.server 8000
   - Node: npx http-server -c-1
   Note: WebXR requires HTTPS for headset browsers — local http is only for quick checks.
5) Deploy to Netlify or GitHub Pages using the scripts provided or via drag & drop.

Notes:
- If you need WebXR controller mapping check your XROrigin and XRController3D nodes in scene and test their mappings.
- Ensure textures and .wasm files are compressed if bandwidth is a concern.
