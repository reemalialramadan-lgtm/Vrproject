Web-ready folder for Godot HTML5 (WASM) export

How to use this folder
1. From Godot Editor (local PC), export your project as HTML5. The export will create files like index.html, yourproject.wasm, yourproject.js and optionally yourproject.pck.
2. Copy all exported files into this folder (replace the placeholder files if present).
3. Use any static host (Netlify, GitHub Pages, Vercel) to deploy the contents of this folder. Ensure the server serves `.wasm` with content-type application/wasm.

Quick tips:
- For WebXR in headset browsers make sure the URL is HTTPS.
- Use gzip or brotli compressions on the host for `*.js` and `*.wasm` to reduce bandwidth.
- Keep `index.html` at root of the deployed folder.
