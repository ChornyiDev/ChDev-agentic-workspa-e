---
description: Read root SESSION.md to restore context, inspect current workspace state, and resume work seamlessly
---

# Workflow: Resume Session (/resume-session)

**Trigger:** User command `/resume-session`, `/read-session`, or upon starting a fresh agent session in a workspace containing `SESSION.md`.
**Goal:** Absorb the previous agent's context, verify current codebase status, and immediately propose a concrete action plan to resume work.

## Steps

1. **Check for `SESSION.md`:**
   - Check if `SESSION.md` exists in the workspace root.
   - *If missing:* Notify the user: "No `SESSION.md` found in workspace root. Ready for new instructions or consult `roadmap/`." Stop workflow.

2. **Ingest Context:**
   - Read the entire `SESSION.md`.
   - Parse and load into context:
     - The active objective and user intent.
     - Files changed and key architectural decisions (including constraints and rejected solutions).
     - Known issues and blockers.
     - Immediate Next Steps.

3. **Codebase Reality Check:**
   - Run `git status` or inspect recent file modifications to ensure the workspace reflects the state described in `SESSION.md`.
   - Check `user_tasks.md` to see if the user resolved any blockers since the last session was saved.
   - Check if any critical dependencies or environment files mentioned in `SESSION.md` are in place.

4. **Formulate Briefing & Action Plan:**
   - Present a concise briefing to the user in chat:
     - 📌 **Resumed Objective:** [Short statement of current goal]
     - 🔍 **Last Known State:** [Summary of completed work and blockers]
     - 🚀 **Next Immediate Step:** [First item from Immediate Next Steps in `SESSION.md`]
   - Prompt the user: *"Shall I proceed with [Next Immediate Step], or do you have updated priorities?"*
