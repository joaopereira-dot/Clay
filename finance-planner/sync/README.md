# Optional cloud sync (end-to-end encrypted)

Ledger is **local-first**: by default your data lives only in your browser and
never touches a network. This folder documents an **optional** way to sync your
vault across devices (phone + laptop, say) **without** trusting the server with
your financial data.

## How it protects your data

When sync is enabled, the app:

1. Serializes your entire dataset to JSON **in the browser**.
2. Derives an AES-256 key from a passphrase you choose (PBKDF2, 200k
   iterations, SHA-256, random salt).
3. Encrypts the JSON with **AES-GCM** and uploads only the resulting
   ciphertext (`{ salt, iv, ct }`, all base64) to a single row keyed by a
   *vault ID* you pick.

The server stores an opaque blob. Your **passphrase is never uploaded or
stored** — so the provider (and anyone who breaches it) sees ciphertext they
cannot read. The trade-off: **if you lose the passphrase, the data is
unrecoverable.** Keep a copy somewhere safe, and keep using the Data-tab JSON
export as a plain backup.

## Setup (Supabase — free tier is plenty)

1. Create a project at [supabase.com](https://supabase.com).
2. Open **SQL Editor** and run [`schema.sql`](./schema.sql). It creates the
   `ledger_vault` table with row-level security enabled.
3. In **Project Settings → API**, copy your **Project URL** and the **anon
   public** key.
4. In Ledger, go to **Data → Cloud sync** and fill in:
   - **Supabase project URL** — the Project URL from step 3.
   - **Anon public API key** — safe to store here; it only permits access to
     rows that are already end-to-end encrypted.
   - **Table name** — `ledger_vault` (default).
   - **Vault ID** — any private string only you know (acts like a username).
   - **Encryption passphrase** — a strong secret. Never leaves your browser.
5. Click **Save settings**, then **Push to cloud**. On your other device, enter
   the same URL, key, table, Vault ID and passphrase, and click **Pull from
   cloud**.

`Push` uploads (and overwrites the remote copy with) this device's data;
`Pull` replaces this device's data with the cloud copy. It's a deliberate,
manual last-write-wins model — sync when you finish a session on one device
before switching to the other, so you never clobber newer edits.

## Hardening to true multi-user auth (optional)

The default policies allow any holder of the anon key to read/write rows (still
encrypted, still unreadable without your passphrase). To scope rows to an
authenticated user instead:

1. Enable an auth provider in Supabase (email magic-link is simplest).
2. Add a `user_id uuid default auth.uid()` column to `ledger_vault`.
3. Replace the `using (true)` / `with check (true)` policies with
   `using (auth.uid() = user_id)` equivalents.
4. Add a sign-in step to the app that attaches the user's JWT to requests.

This is beyond the built-in adapter, which is intentionally minimal and
provider-agnostic (plain Supabase REST). Any key-value HTTPS store works if you
adapt the `Sync` module in `../index.html`.

## Other providers / self-hosting

The adapter only needs an HTTPS endpoint that can store and return one JSON blob
per key. Supabase is the documented path because its REST API and free tier make
it painless, but the same encryption scheme works against a Cloudflare
Worker + KV, a tiny Deno/Node service, or any Postgres with PostgREST.
