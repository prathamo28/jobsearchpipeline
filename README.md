# Job Pipeline Tracker

A single-page job application tracker. No signup, no server, no framework — open `index.html` and go. Optional Supabase sync for cross-device access.

## Features

- **7-stage pipeline** — Applied → HR → Technical → Manager → Cultural Fit → Offer → Accepted
- **Rejection tracking** — Record rejection type (CV, HR, Technical, Manager, Cultural Fit) and notes at any stage. Reapply after rejection with a fresh attempt.
- **Rich company data** — Salary range, expected CTC, recruiter name, interview date, job description, CV notes per company.
- **Interview alerts** — Sidebar badge and 7-day countdown alert so you never miss an upcoming interview.
- **Watchlist** — Save companies you're watching (role, priority, notes) and promote to pipeline when you apply.
- **Stats bar** — Live counts for total active, in-interview, offers, and accepted.
- **Offline-first** — All data stored in browser localStorage. No account needed.
- **Cloud sync** — Optional Supabase integration syncs data across devices.
- **Backup & restore** — Export full JSON backup (pipeline + watchlist) and restore on any device.
- **CSV export** — Export pipeline data as a spreadsheet-friendly CSV.

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

### How to check if Vercel, GitHub, and Supabase are synced

1. **In the app (Vercel URL)**  
   - Open your deployed app (e.g. `https://your-project.vercel.app`).  
   - Next to the logo you’ll see either **“Synced to Supabase”** or **“This device only”**.  
   - **“Synced to Supabase”** = the app is using your Supabase project; data is saved to the database and will persist after refresh and on other devices.  
   - **“This device only”** = no Supabase config (or it failed); data is only in the browser and will be lost if you clear site data or use another device.

2. **Vercel**  
   - Vercel dashboard → your project → **Settings** → **Environment Variables**: you should see `SUPABASE_URL` and `SUPABASE_ANON`.  
   - **Deployments**: each push to GitHub should create a new deployment. If not, check **Settings** → **Git** and confirm the repo is connected.

3. **Supabase (is data in the database?)**  
   - [Supabase Dashboard](https://supabase.com/dashboard) → your project → **Table Editor**.  
   - Open the **app_data** table.  
   - You should see rows with `key` = `pipeline` and `key` = `watchlist`.  
   - After you add companies in the app and refresh, the `value` column (JSON) should contain your pipeline/watchlist data. If it stays empty, the app is not connected (check Vercel env vars and redeploy).

4. **GitHub**  
   - Your repo should show the latest code. After you push, Vercel will build and deploy from that repo.

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

## License

MIT — see [LICENSE](LICENSE).
