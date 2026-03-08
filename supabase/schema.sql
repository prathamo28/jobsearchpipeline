-- Job Pipeline Tracker: one table stores pipeline + watchlist as JSON
-- Run this in Supabase: SQL Editor → New query → paste → Run

create table if not exists app_data (
  key text primary key,
  value jsonb not null default '[]'::jsonb,
  updated_at timestamptz default now()
);

-- Seed rows (empty arrays)
insert into app_data (key, value) values
  ('pipeline', '[]'::jsonb),
  ('watchlist', '[]'::jsonb)
on conflict (key) do nothing;

-- Allow the app (using anon key) to read and write
-- For a single-user personal app this is fine; add Auth later if you need multi-user
alter table app_data enable row level security;

create policy "Allow anon read and write app_data"
  on app_data for all
  to anon
  using (true)
  with check (true);
