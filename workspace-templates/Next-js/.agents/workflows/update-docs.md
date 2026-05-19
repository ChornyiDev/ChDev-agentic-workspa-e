---
description: 
---

# Workflow: Documentation Synchronization (/update-docs)

**Trigger:** User command `/update-docs`.
**Goal:** Keep the `docs/` folder as the Living Single Source of Truth.

## Decision Logic (Router)

1.  **Analyze Recent Changes:**
    * Look at the file modification history or recent chat context.
    * *Question:* What layer of the application was touched?

2.  **Targeted Updates (Map):**

    * **IF Database changed (schema.prisma/sql):**
        * -> Update `docs/database/02_schema.md`.
        * *Task:* Describe new tables and relationships in business terms.

    * **IF New Library installed (package.json):**
        * -> Update `docs/tech-stack/libraries.md`.
        * *Task:* Add the library name and *reason* for adoption.

    * **IF New Feature completed:**
        * -> Update `docs/project-info/features_list.md`.
        * *Task:* Mark feature as "Completed" and add a brief description.

    * **IF API/Architecture changed:**
        * -> Update `docs/tech-stack/project_structure.md`.

3.  **Execution:**
    * Edit the Markdown files directly.
    * **Constraint:** Do not delete existing legacy info unless it is strictly obsolete. Append new info.

4.  **Final Output:**
    * List updated files for user review.