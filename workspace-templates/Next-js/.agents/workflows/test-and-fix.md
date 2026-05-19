---
description: Auto-Test & Fix
---

# Workflow: Auto-Test & Fix (/test-and-fix)

**Trigger:** User command `/test-and-fix` after writing new code.
**Goal:** Detect bugs, attempt fixes, and verify results.

## Process "The Debugging Ladder"

1.  **Static Analysis (The Filter):**
    * Run `npm run lint`.
    * If syntax errors exist -> Fix them immediately.

2.  **Unit/Integration Testing:**
    * Run `npm run test` (if tests exist).
    * If tests fail -> Analyze the error log.

3.  **Browser Verification:**
    * Open the Browser tool to the modified page.
    * Check for console errors or crashes (500 Error).

4.  **Remediation Loop (The Fix):**
    * **Counter:** Track fix attempts. **Limit = 3 iterations.**
    * If a bug is found:
        1.  **Read:** Analyze the file causing the error.
        2.  **Plan:** Propose a fix.
        3.  **Apply:** Edit the code.
        4.  **Retry:** Go back to Step 1.

5.  **The "Stuck" Protocol (Critical):**
    * **IF** the same error persists after 3 iterations OR the linter creates new errors constantly:
    * **STOP IMMEDIATELY.** Do not attempt a 4th fix.
    * **Report to User:**
        * "I am stuck in a fix loop. The error is: [Error Details]."
        * "I have tried: [List attempts]."
        * "Please advise: Should I revert changes, try a different approach, or ignore this for now?"

6.  **Final Report:**
    * Output a summary: "Found X errors. Fixed Y."
    * **Note:** Do NOT commit to Git without user approval.