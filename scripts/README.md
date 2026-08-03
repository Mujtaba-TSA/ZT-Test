# Fetch WooCommerce SKUs + URLs

`fetch-skus.mjs` pulls every product (and, by default, every variation) from a
WooCommerce store via the REST API and writes:

- **`skus.csv`** — columns `SKU, URL, Name, Type, Status`
- **`skus.md`** — a Markdown table (`SKU | URL | Name`)

It has **no dependencies** — just Node 18+ (uses built-in `fetch`).

> **Why run it yourself?** The automated session that created this script runs
> in a sandbox whose network policy blocks outbound calls to `zerotech.com.au`,
> so it can't hit the store API directly. Run this from your own machine (or any
> host that can reach the store) and it works in one shot.

## 1. Get read-only API keys

In WooCommerce admin:

1. **WooCommerce → Settings → Advanced → REST API → Add key**
2. Description: `sku-url-export` · User: an admin · **Permissions: Read**
3. **Generate API key**, then copy the **Consumer key** (`ck_…`) and
   **Consumer secret** (`cs_…`). You only see the secret once.

## 2. Run it

```bash
STORE_URL=https://zerotech.com.au \
WC_KEY=ck_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \
WC_SECRET=cs_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx \
node scripts/fetch-skus.mjs
```

You'll get `skus.csv` and `skus.md` in the current directory.

## Options

Set as environment variables:

| Variable | Default | Meaning |
| --- | --- | --- |
| `INCLUDE_VARIATIONS` | `true` | Also fetch each variable product's per-variation SKUs. Set `false` for parent products only. |
| `STATUS` | `publish` | Product status filter (`publish`, `any`, `draft`, `private`, …). |
| `PER_PAGE` | `100` | API page size (max 100). |
| `OUT_DIR` | `.` | Where to write `skus.csv` / `skus.md`. |

## Notes

- Uses HTTP Basic auth over HTTPS (the standard WooCommerce REST scheme).
- Paginates automatically via the `X-WP-TotalPages` header — handles any catalog size.
- De-duplicates on SKU and sorts alphabetically.
- Variation rows use the variation's own `permalink` (which encodes the selected
  attributes) and name them `Parent – Option / Option`.
- **Keep your keys secret** — pass them via env vars as shown; don't commit them.
