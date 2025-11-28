Deploy to GitHub Pages (quick)

1) Build HTML5 in Godot locally.
2) Create a repository in GitHub and push your web export files into the repository's `gh-pages` branch or use the `docs/` folder in `main` branch.
   - Option A (gh-pages branch): push build files to the gh-pages branch and configure GitHub Pages to serve from that branch.
   - Option B (docs folder): create a `docs/` directory and push build files into it, then enable Pages to serve `docs/`.

3) GitHub Pages provides HTTPS. The URL will look like `https://yourusername.github.io/yourrepo/`.

4) Open this URL on your headset browser and accept the WebXR permission.

Notes:
- You can use a GitHub Actions workflow to automatically build and deploy if you have a CI runner that supports Godot/Emscripten. This is more advanced and requires Emscripten on the CI environment.
- Ensure `.wasm` is served with `Content-Type: application/wasm`. GitHub Pages normally handles this correctly.
