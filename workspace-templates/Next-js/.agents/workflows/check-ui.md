---
description: UI Consistency & Responsiveness Check
---

# Workflow: UI Consistency & Responsiveness Check (/check-ui)

**Trigger:** User command `/check-ui` or after significant frontend changes.
**Context:** Uses the built-in Browser Agent to visually verify the interface against `docs/design/design_system.md`.

## Steps

1.  **Preparation:**
    * Ensure the local development server is running (`npm run dev`).
    * Read `docs/design/design_system.md` to load valid colors, fonts, and spacing into context.

2.  **Visual Inspection (Browser Action):**
    * **Desktop View (1920px):** Navigate to the changed pages. Take a screenshot. Verify navigation alignment and primary button styles.
    * **Mobile View (375px):** Switch browser to mobile emulation. Take a screenshot. Verify no horizontal scrolling, readable font sizes, and "hamburger" menu functionality.

3.  **Style Compliance Analysis:**
    * Compare the screenshot findings with the rules in `docs/design/design_system.md`.
    * **Check:** Are we using arbitrary hex codes instead of Tailwind classes (e.g., `#3b82f6` instead of `bg-blue-500`)?

4.  **Reporting:**
    * If issues found: List them as "UI Bugs" in the chat with suggested CSS fixes.
    * If perfect: Mark as "Design Verified".

**Agent Note:** Do not auto-fix complex UI breakages without confirmation. Visual bugs are subjective.