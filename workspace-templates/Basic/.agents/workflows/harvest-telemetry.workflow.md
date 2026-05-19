---
description: Execute a multi-step data extraction pipeline across the local workspace. Gather raw context, milestone logs, and technical constraints, then compile them into a single Consolidated File.
---

# Rules 
  - Complete just one step per run and record the result in the `roadmap/Project Autopsy & Artifacts Archive.md` template immediately after the run.
  - Ask the user to confirm the step and, once confirmed, proceed to the next step.
  - In unclear situations, ask the user.
  - DO NOT invent, hallucinate, or synthesize data. 
  - ACT strictly as a data parser. Extract and format.
  - IF a directory or file is missing, write "No data available" for that section.
  - EXECUTE steps sequentially. Do not skip phases.

---

# Workflow

## 🛠️ Step 1: Initialize Ledger & Core Context
**Target Directories:** `raw/`, `docs/project/`, root `README.md`
**Action:**
1. Create a new file named `Workspace_Telemetry_Ledger.md`.
2. Extract the Primary Objective, Target Audience, and Original Client Request.
3. Write **Section 1 (Source Context & Business Problem)** to the ledger.

## 🛠️ Step 2: Documentation Registry
**Target Directory:** `docs/` (including all subdirectories: `database/`, `design/`, `features/`, `integrations/`, `tech-stack/`)
**Action:**
1. Scan for all `.md` files.
2. For each file, generate a one-sentence summary of its purpose based on its content.
3. Group them by category and append **Section 2 (Documentation Registry)** to the ledger.

## 🛠️ Step 3: Milestone Extraction & Autopsy Logs
**Target Directory:** `roadmap/`
**Action:**
1. Find all files matching the pattern `Milestone*.md`.
2. For EACH milestone file, extract:
   - Status and Expected ROI.
   - Objective.
   - Tech Stack & Schema Changes.
3. **CRITICAL:** Extract the exact contents of the "5. 🧠 Autopsy: Challenges & Solutions" section verbatim. 
4. Append all milestone data under **Section 3 (Milestone Execution & Autopsy Log)** in the ledger.

## 🛠️ Step 4: Architecture & Assets Mapping
**Target Directories:** `graphify-out/`, `scripts/`, `prototypes/`, `assets/`
**Action:**
1. Read `graphify-out/` to outline the main code modules and architecture.
2. Scan `scripts/` and list the filenames with a brief inferred purpose.
3. Scan `prototypes/` for HTML/CSS files and core rules from `dsign-system-showcase-specs.md`.
4. Scan `assets/` to list available visual media.
5. Append **Section 4 (Technical Blueprint & Assets)** to the ledger.

## 🛠️ Step 5: AI Constraints Filtration
**Target:** All `agent.md` files located anywhere in the workspace.
**Action:**
1. Perform a recursive search for `agent.md`.
2. Apply the extraction rules below to filter the content of each found file:
   <extraction_rules>
     - IGNORE simple file directories, temporary scratchpads, or task statuses.
     - EXTRACT strict immutable rules, API constraints, library limitations, and custom architectural workarounds.
   </extraction_rules>
3. Group the filtered rules by their file path.
4. Append **Section 5 (Technical Constraints & AI Directives)** to the ledger.

## 🛠️ Step 6: Uncategorized & Miscellaneous Discovery
**Target:** Any remaining directories or root files NOT processed in Steps 1-5 (e.g., `archive/`, custom stack-specific folders).
**Action:**
1. Scan the workspace for unmapped directories and standalone root files.
2. Apply the extraction rules below:
   <extraction_rules>
     - STRICTLY IGNORE standard environment directories (`node_modules/`, `.git/`, `.next/`, `build/`, `dist/`, etc.).
     - EXTRACT isolated configuration files, legacy artifacts in `archive/`, or unrecognized domain-specific folders.
   </extraction_rules>
3. Identify assets that hold technical or historical value.
4. Append **Section 6 (Miscellaneous & Uncategorized Assets)** to the ledger.

---
