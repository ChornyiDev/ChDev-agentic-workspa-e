---
description: Save current agent conversation, progress, decisions, and state to root SESSION.md for seamless handoff
---

# Workflow: Save Session (/save-session)

**Trigger:** User command `/save-session`, user request to "save session / handoff", before ending work, or before clearing conversation context.
**Goal:** Capture a comprehensive, structured snapshot in `SESSION.md` (project root) so that any subsequent agent or human developer can immediately understand context, resume tasks, and avoid repeating work.

## Steps

1. **Workspace & Git State Scan:**
   - Run `git status` to identify modified, added, unstaged, or untracked files.
   - Note the active Git branch and latest commit message/hash if available.

2. **Context & Progress Synthesis:**
   - **Primary Objective:** Summarize the user's high-level goal and intent for this session.
   - **Work Completed:** List files modified, created, or deleted with a concise summary of changes made. Include any schema updates, package installations, or script runs.
   - **Key Architectural Decisions & Rationale:** Document critical technical choices, trade-offs, and rejected approaches so the next agent does not reverse valid decisions.
   - **Blockers & Pending User Actions:** Check `user_tasks.md` and document any external dependencies, credentials, API keys, or decisions awaiting human input.
   - **Verification Status:** Detail what was tested (automated tests, manual browser verification, build commands) and what remains unverified.
   - **Immediate Next Steps:** Formulate a prioritized, concrete list of actions for the next agent to execute immediately.

3. **Write `SESSION.md`:**
   - Write or update `SESSION.md` in the workspace root following the standardized format below:

```markdown
# 🔄 Active Agent Session Handoff

- **Last Updated:** YYYY-MM-DD HH:mm:ss
- **Technology Profile:** [e.g., nextjs | flutterflow]
- **Active Git Branch & State:** [e.g., main (clean / dirty: 3 files modified)]
- **Active Milestone / Task:** [Link to milestone or SPEC if applicable]

---

## 1. 🎯 Current Objective & User Intent
[Clear, high-level summary of what was requested and what we are building]

## 2. 🛠️ Work Completed in this Session
- `path/to/file`: [Concise description of changes]
- [Installed packages, migrations, or configs created]

## 3. 🧠 Key Architectural Decisions & Context
- [Decision 1: Why this pattern/library was chosen]
- [Rejected alternatives or constraints discovered during implementation]

## 4. ⚠️ Current State, Blockers & Known Issues
- **User Blockers (`user_tasks.md`):** [Items requiring user intervention]
- **Technical Bugs / Incomplete Logic:** [Known issues or WIP sections]
- **Verification Status:** [What is working and verified vs untested]

## 5. ⏭️ Immediate Next Steps (Action Plan for Next Agent)
1. [First immediate task to execute]
2. [Second task]
3. [Third task]
```

4. **Archival (Optional):**
   - If an existing `SESSION.md` was already present from a previous major milestone or date, copy it to `archive/sessions/YYYY-MM-DD_HH-mm_SESSION.md` before updating, to preserve chronological session history.

5. **Confirmation to User:**
   - Report back to the user that `SESSION.md` has been created/updated in the project root.
   - Provide a concise 3-bullet summary: Objective captured, current status, and proposed next step.
