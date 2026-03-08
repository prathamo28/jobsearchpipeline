# Job Pipeline Tracker

A single-page app to track your job application pipeline and watchlist. All data is stored in your browser and persists when you update details, so you can track your progress anytime.

## Features

- **Pipeline** — Add companies, move them through stages (Applied → HR → Tech 1 → Tech 2 → CEO → Offer → Accepted), record rejections with type and notes, add comments per attempt, reapply after rejection.
- **Watchlist** — Save companies you want to watch (role, priority, notes) and promote them to the pipeline when you apply.
- **Persistence** — Data is saved in your browser (localStorage). Optionally use **Supabase** so data lives in the cloud and syncs across devices.
- **Backup & restore** — Export a full JSON backup (pipeline + watchlist) and restore it later or on another device so you never lose your data.

## How to run

1. Clone or download this repo.
2. Open `index.html` in a modern browser (double-click or drag into the browser).
3. Or serve the folder locally, e.g.:
   - `npx serve .`
   - `python -m http.server 8000`
   - Then open `http://localhost:8000` (or the port shown).

No build step or server is required for basic use.

## Deploy on Vercel (personal use)

1. Push this repo to **GitHub** (if you haven’t already).
2. Go to [vercel.com](https://vercel.com) and sign in with GitHub.
3. Click **Add New… → Project**, import your **Job-Search-Pipeline** repo, then **Deploy** (leave settings as default).
4. After the first deploy, go to your project on Vercel → **Settings** → **Environment Variables**. Add:
   - **Name:** `SUPABASE_URL` → **Value:** `https://YOUR_PROJECT_REF.supabase.co`
   - **Name:** `SUPABASE_ANON` → **Value:** your Supabase publishable or anon key
5. Go to **Deployments**, open the **⋯** on the latest deployment, click **Redeploy**. This rebuilds the app with your env vars so the live site uses your Supabase database.

Your app will be at `https://your-project-name.vercel.app`. Data is stored in Supabase and stays the same on any device.

## Optional: Supabase (cloud database)

To store data in the cloud so it’s the same on any device:

1. Create a free project at [supabase.com](https://supabase.com).
2. In the Supabase dashboard, open **SQL Editor** → **New query**. Paste the contents of `supabase/schema.sql` and click **Run**.
3. Open **Project Settings** → **API**. Copy the **Project URL** and the **anon public** key.
4. **On Vercel:** set `SUPABASE_URL` and `SUPABASE_ANON` as environment variables (see “Deploy on Vercel” above).
   **Local only:** create a file `config.js` in the project root with:
   ```js
   window.SUPABASE_URL = 'https://YOUR_PROJECT_REF.supabase.co';
   window.SUPABASE_ANON = 'your-key';
   ```
5. Reload the app. Data will load and save to Supabase.

Do not commit real API keys. On Vercel, use env vars. If Supabase is not set, the app uses only localStorage.

## Data and backup

- **Where data lives:** With Supabase configured, pipeline and watchlist are stored in Supabase and also mirrored in `localStorage`. Without Supabase, data is only in `localStorage` (keys `jpt3` and `jpt3_watch`).
- **Backup:** Use **↓ BACKUP** in the header to download a `.json` file containing pipeline and watchlist. Store this file somewhere safe (e.g. cloud drive).
- **Restore:** Use **↑ RESTORE** and choose a previously downloaded backup file. This replaces current pipeline and watchlist (and syncs to Supabase if configured).

### Will I lose my data when the app is updated or features change?

**No.** Your progress is stored **separately** from the app code:

- **In the browser:** Data lives in `localStorage` under keys `jpt3` and `jpt3_watch`. Updating `index.html` or any script does **not** clear that. You keep all companies, stages, and notes.
- **With Supabase:** Data lives in your Supabase project. Code changes (e.g. new features, redeploys) do **not** delete or overwrite that. Same data loads every time.

To be extra safe:
1. Use **↓ BACKUP** every so often and keep the `.json` file (e.g. in Google Drive or OneDrive).
2. If you use **Supabase**, your data is in the cloud; even clearing the browser or switching devices won’t lose it (just open the app and it loads from Supabase).
3. Avoid clearing “site data” or “localStorage” for this app in the browser if you’re not using Supabase; that would remove local-only data (you can restore from a backup if you have one).

## Export CSV

Use **↓ CSV** to export pipeline data as a spreadsheet-friendly CSV (one row per attempt). Useful for sharing or analysis outside the app.

## License

MIT — see [LICENSE](LICENSE).
