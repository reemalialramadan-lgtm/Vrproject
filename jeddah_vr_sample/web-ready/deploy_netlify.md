Deploying a Godot HTML5 build to Netlify (quick)

1) Build HTML5 in Godot (locally)
   - In Godot Editor: Project -> Export -> Add -> HTML5.
   - Export the project to a folder on your PC. You will get `index.html`, `yourproject.wasm`, `yourproject.js` and maybe `yourproject.pck`.

2) Upload build to Netlify
   - Quick (drag + drop): go to https://app.netlify.com/drop and drop your build folder. Netlify will deploy to a secure HTTPS URL.
   - CLI: install netlify CLI (`npm i -g netlify-cli`), then:
     ```bash
     netlify deploy --prod --dir=path/to/export/folder
     ```

3) Ensure correct MIME type for .wasm (Netlify does this automatically). For best performance add gzip/brotli compression.

4) Open the URL in your headset browser -> allow Immersive VR prompt.

Troubleshooting:
- If WebXR errors appear, make sure your headset browser supports WebXR and the site is loaded over HTTPS.
- If `.wasm` fails to load, check the network tab to confirm content-type is application/wasm.
