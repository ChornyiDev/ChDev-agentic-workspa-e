---
description: Stack-specific rules for Next.js 16, React 19, Tailwind v4, Neon PostgreSQL, and Stack Auth. Enable after choosing this stack; delete stack-flutterflow.md and unused folders.
---

# Next.js & Neon Stack Instructions

Apply these rules **in addition to** [meta-rules.md](./meta-rules.md). Remove this file if the project does not use this stack.

---

## Tech Stack

* **Frontend:** Next.js 16 (Canary App Router), React 19 (`use()` hook, enhanced metadata, refs)
* **Styling:** Tailwind CSS v4 — semantic tokens in `web/app/globals.css`
* **Database & Auth:** Neon Serverless PostgreSQL (mandatory RLS), Stack Auth
* **Hosting:** Vercel / Cloudflare Pages

---

## Design System Protocol (Next.js 16 + Tailwind v4)

**Mandatory compliance. No deviations without explicit approval.**

* **SSOT:** `web/app/globals.css` defines all semantic tokens (primary, background, border, etc.).
* **Components:** ALWAYS check `web/components/ui/` before creating any UI element.
* **Reusability:** Prefer composing existing UI primitives over raw HTML/Tailwind.
* **Icons:** Use `lucide-react` exclusively.
* **Class Merging:** Always use `cn()` from `@/lib/utils` for conditional classes.
* **Componentization:** Reused UI patterns → `web/components/ui/` (primitives) or `web/components/shared/` (blocks).
* **No Inline Styles:** Tailwind only; `style={...}` only for dynamic values (e.g. progress width).
* **Semantic Tokens Only:** Use `bg-background`, `text-foreground`, `border-border` — no hardcoded hex or arbitrary values.

---

## Backend & Database

* **Neon PostgreSQL:** Serverless driver with connection pooling.
* **RLS:** Mandatory for ALL tables.
* **Stack Auth:** Integrated with Neon for identity.

### Database Schema Protocol (SSOT)

* **`docs/database/001_schema_simple.sql`:** AI-optimized reference (tables, PKs, essential refs).
* **`docs/database/001_schema_full.sql`:** Master script (constraints, RLS, triggers, RPC).
* **Sync:** Update both files immediately after any schema change.
* **Deploy:** `001_schema_full.sql` must recreate the full database standalone.

---

## Development Overrides

* Business logic in service layers, hooks, or **Server Actions**.
* **`any` is STRICTLY FORBIDDEN** — use precise types, `unknown`, or generics; refactor existing `any` when touching a file.

---

## Safety (Stack-Specific)

* For **database deletion**, user must type **"CONFIRM DELETE"** in addition to normal confirmation.

---

## Root `agent.md` — Fill Section 2 With

```markdown
* **Frontend:** Next.js 16 (App Router), React 19
* **Styling:** Tailwind CSS v4
* **Database & Auth:** Neon PostgreSQL (RLS), Stack Auth
* **Hosting:** Vercel / Cloudflare Pages
```

* **State:** React Server Actions & Server Components by default.
* **Security:** RLS on all Neon tables; Stack Auth middleware checks.

---

## After Setup — Delete If Not Using This Stack

* `cloud_functions/`, `custom_code/`, `docs/flutterflow/`
* `.agents/rules/stack-flutterflow.md`
