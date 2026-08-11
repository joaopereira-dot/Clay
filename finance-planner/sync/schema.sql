-- ============================================================================
-- Ledger — optional end-to-end-encrypted sync vault (Supabase / Postgres)
-- ----------------------------------------------------------------------------
-- Run this once in your own Supabase project (SQL Editor). It creates a single
-- table that stores ONE opaque, client-encrypted blob per "vault_id".
--
-- Security model:
--   * The app encrypts your whole dataset in the browser (AES-GCM, key derived
--     from your passphrase via PBKDF2) BEFORE uploading. The server therefore
--     only ever sees ciphertext — it cannot read your finances even if the
--     database is compromised.
--   * The `anon` API key is safe to embed in the app. Row access is governed by
--     the RLS policies below, and the data itself is useless without your
--     passphrase, which is never uploaded or stored anywhere.
--
-- Threat-model note: this schema lets any holder of the anon key read/write
-- rows (they still can't decrypt them). That is fine for a single-user, secret
-- vault_id. For stronger isolation, enable Supabase Auth and swap the policies
-- for `auth.uid()`-scoped ones, adding a `user_id uuid` column. See README.md.
-- ============================================================================

create table if not exists public.ledger_vault (
  vault_id   text primary key,
  payload    jsonb       not null,      -- { v, salt, iv, ct } — all base64
  updated_at timestamptz not null default now()
);

alter table public.ledger_vault enable row level security;

-- Permissive single-user policies (data is E2E-encrypted; access ≠ readability).
drop policy if exists "vault read"   on public.ledger_vault;
drop policy if exists "vault write"  on public.ledger_vault;
drop policy if exists "vault update" on public.ledger_vault;

create policy "vault read"   on public.ledger_vault for select using (true);
create policy "vault write"  on public.ledger_vault for insert with check (true);
create policy "vault update" on public.ledger_vault for update using (true) with check (true);
