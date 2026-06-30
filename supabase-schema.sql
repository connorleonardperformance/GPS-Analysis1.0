-- Run this in your Supabase project: SQL Editor → New query → paste → Run

create table players (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  name text not null,
  num integer,
  pos text,
  mas numeric,
  mss numeric,
  mref numeric,
  notes text,
  created_at timestamptz default now()
);

create table sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  player_id uuid references players(id) on delete cascade not null,
  date date not null,
  type text,
  td numeric,
  hsr numeric,
  spr numeric,
  hmld numeric,
  acc numeric,
  dec numeric,
  spd numeric,
  pl numeric,
  rpe numeric,
  dur numeric,
  created_at timestamptz default now()
);

-- Row Level Security: each coach only sees their own data
alter table players enable row level security;
alter table sessions enable row level security;

create policy "players: own data only" on players
  for all using (auth.uid() = user_id);

create policy "sessions: own data only" on sessions
  for all using (auth.uid() = user_id);
