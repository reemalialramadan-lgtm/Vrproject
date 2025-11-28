Quick Deploy — نشر سريع

What I prepared for you:

- A script `publish-gh-pages.sh` at the repository root that automates publishing
  the contents of `jeddah_vr_sample/web-ready/` to the `gh-pages` branch on `origin`.

- Instructions (English + Arabic) below so you can run it locally or in Codespaces.

How to run (recommended from a Codespace or your local machine with git access):

1. Make sure you are in the repository root where `.git` exists.
2. Give the script execute permission: `chmod +x publish-gh-pages.sh`
3. Run: `./publish-gh-pages.sh` and confirm when prompted.

If the script completes successfully, the likely URL is:

  https://reemalialramadan-lgtm.github.io/Vrproject/

شرح بالعربية (موجز):

1. هذا السكربت سيأخذ الملفات الموجودة في `jeddah_vr_sample/web-ready/` ويضعها
   في فرع `gh-pages` على الريموت `origin`.
2. شغّل السكربت من مجلد المشروع: `chmod +x publish-gh-pages.sh && ./publish-gh-pages.sh`.
3. بعد نجاح العملية، سيكون الموقع متاحاً عادةً على:

  https://reemalialramadan-lgtm.github.io/Vrproject/

Notes / Troubleshooting:
- If you see "not a git repository" error, run the script from the repo root or
  ensure `.git` is present and your environment has network access and push rights.
- If you prefer, I can try to run the publish step here if you give me permission
  to push (or confirm this environment has valid git credentials). Otherwise run
  the script on your machine.

```bash
cd /workspaces/Vrproject
ls -la .git
git remote -v
```
