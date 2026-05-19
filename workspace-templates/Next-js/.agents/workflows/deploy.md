---
description: Production Deployment
---

# Workflow: Production Deployment (/deploy)

**Trigger:** User command `/deploy`.
**Goal:** Safely ship code to production (Vercel/Cloud) after rigorous verification.

## Phase 1: Pre-Flight Safety Checks (Mandatory)
1.  **Code Quality:** Run `npm run lint` to catch syntax errors.
2.  **Type Safety:** Run `tsc --noEmit` (TypeScript check) to prevent runtime crashes.
3.  **Build Simulation:** Run `npm run build` locally.
    * *If Build Fails:* STOP immediately. Report errors to user.
    * *If Build Passes:* Proceed to Phase 2.

## Phase 2: Deployment Strategy
*Select the strategy based on the project configuration:*

### Option A: Vercel (Default for Next.js)
1.  Execute: `vercel --prod` (requires Vercel CLI login).
2.  Wait for the specific deployment URL.

### Option B: VPS / Docker (Template Reference)
* *Action:* SSH into server and pull changes.
* *Command:* `docker compose up -d --build`.

## Phase 3: Post-Deployment Verification
1.  Visit the **Production URL** via the Browser tool.
2.  Verify critical paths (e.g., Homepage loads, Login page is accessible).
3.  Report status: "🚀 Deployment Successful: [URL]" or "❌ Deployment Failed".