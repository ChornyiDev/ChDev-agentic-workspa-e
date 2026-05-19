---
description: Update "Get Started" Guide
---

# Workflow: Update "Get Started" Guide (/get-started)

**Trigger:** User command `/get-started` or when preparing for project handover/publication.
**Goal:** Ensure `docs/get-started/` allows a stranger to set up this project from zero.

## Steps

1.  **Environment Scan:**
    * Read `package.json` to identify scripts (`dev`, `build`, `start`).
    * Read `.env.example` (NEVER `.env`) to identify required secrets.
    * Check database configuration (Prisma/Drizzle).

2.  **Documentation Update Loop:**

    * **Target:** `docs/get-started/00_setup.md`
        * *Action:* Verify Node.js version requirements and global dependencies (e.g., Docker, Vercel CLI).

    * **Target:** `docs/get-started/01_environment.md`
        * *Action:* Update the table of Environment Variables. Add descriptions for what each key does (e.g., "STRIPE_KEY: Used for payment processing").

    * **Target:** `docs/get-started/02_installation.md`
        * *Action:* Write a foolproof step-by-step:
            1. Clone repo.
            2. `npm install`.
            3. Database Setup (`npm run db:push`).
            4. Run Server.

3.  **Validation:**
    * Simulate a "fresh user" reading these docs. Are any steps missing?
    * Update the files and confirm: "Onboarding documentation is now in sync with the code."