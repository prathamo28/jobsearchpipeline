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

## Optional: Supabase (cloud database)

To store data in the cloud so it’s the same on any device:

1. Create a free project at [supabase.com](https://supabase.com).
2. In the Supabase dashboard, open **SQL Editor** → **New query**. Paste the contents of `supabase/schema.sql` and click **Run**.
3. Open **Project Settings** → **API**. Copy the **Project URL** and the **anon public** key.
4. In `index.html`, find the two lines near the top of the script and set them:
   - `SUPABASE_URL = 'https://YOUR_PROJECT_REF.supabase.co';`
   - `SUPABASE_ANON = 'your-publishable-or-anon-key';`
5. Reload the app. Data will load and save to Supabase.

**Important:** Do **not** commit your real API keys to GitHub. After cloning the repo, add your keys only in your local copy (or use environment variables when you deploy). The repo is left with empty placeholders on purpose.
If either value is left empty, the app uses only localStorage (no Supabase).

## Data and backup

- **Where data lives:** With Supabase configured, pipeline and watchlist are stored in Supabase and also mirrored in `localStorage`. Without Supabase, data is only in `localStorage` (keys `jpt3` and `jpt3_watch`).
- **Backup:** Use **↓ BACKUP** in the header to download a `.json` file containing pipeline and watchlist. Store this file somewhere safe (e.g. cloud drive).
- **Restore:** Use **↑ RESTORE** and choose a previously downloaded backup file. This replaces current pipeline and watchlist (and syncs to Supabase if configured).

## Export CSV

Use **↓ CSV** to export pipeline data as a spreadsheet-friendly CSV (one row per attempt). Useful for sharing or analysis outside the app.

## License

MIT — see [LICENSE](LICENSE).
