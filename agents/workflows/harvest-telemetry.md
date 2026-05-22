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
  - Don’t include the path to the file or directory; just give a descriptive name for the file directory milestone or codebase parts
  - If a file or directory is a placeholder, do not include it in the report

---

# Workflow

## 🛠️ Step 1: Initialize Ledger & Core Context
**Target Directories:**  root `README.md`, `raw/`, `docs/project/`, other relevant files/catalogues.
**Action:**
1. Create a new file if don’t exists `roadmap/Project Autopsy & Artifacts Archive.md`.
2. Extract the Primary Objective, Target Audience, and Original Client Request, Problems Challenges.
3. Write **Section 1 (Source Context & Business Problem)** to the ledger.

## 🛠️ Step 2: Deep Documentation & System Logic Extraction
**Target Directory:** `docs/` (Recursive, including `database/`, `design/`, `features/`, `integrations/`, `tech-stack/`, and any other subdirectories).
**Action:**
1. Scan for all `.md` files across these directories.
2. **CRITICAL:** Do NOT just summarize what the file is about. Open each file and extract the meat of the documentation based on these criteria (where applicable):
   - **Architecture & Approach:** Explain the structural design, database schema, or high-level solutions that have been implemented.
   - **The Core Problem/Decision:** What specific business or technical problem does this document address, and why was this specific integration or approach chosen?
   - **Technical Details:** Specific npm/pub.dev packages used, database tables/views, endpoints, or core functional tokens.
   - **Implementation Logic:** Briefly map the technical or operational flow described in the document.
3. Group the extracted data logically by category (e.g., Database Architecture, Integrations, Design/Features, User Manuals).
4. Write the structured output to **Section 2 (Deep Documentation & System Logic)** in the ledger.

## 🛠️ Step 3: Manuals & Training Documentation Extraction
**Target Directory:** `docs/manual/` (and any other directories containing end-user guides or SOPs)
**Action:**
1. Scan for documentation explicitly aimed at end-users, system operators, or administrators.
2. Synthesize the findings into a clear summary of the deliverables, filling out the following criteria:
   - **Deliverable:** What exactly was produced? (e.g., Comprehensive User & Admin Manual, Onboarding Guide).
   - **Target Audience:** Who is this written for? (e.g., Warehouse floor staff, Shift Managers).
   - **Core Purpose & Value:** Why was this created? (e.g., To provide step-by-step onboarding, prevent data entry errors, or explain scanner procedures without technical jargon).
   - **Key Workflows Covered:** Briefly list the specific operational workflows described in the documents (e.g., Receive IN, Mix OUT, Wastage logging, Scan reversals).
3. Append **Section 3 (Operator Manuals & Training Documentation)** to the ledger.

## 🛠️ Step 4: Milestone Extraction & Autopsy Logs
**Target Directory:** `roadmap/`
**Action:**
1. Find all files matching the pattern `Milestone*.md`.
2. For EACH milestone file, extract:
   - Status and Expected ROI.
   - Objective.
   - Tech Stack & Schema Changes.
3. **CRITICAL:** Extract the exact contents of the "5. 🧠 Autopsy: Challenges & Solutions" section verbatim.
4. Append all milestone data under **Section 4 (Milestone Execution & Autopsy Log)** in the ledger.

## 🛠️ Step 5: Infrastructure & System Assets Deep Extraction
**Target Directories:** `graphify-out/`, `scripts/`, `prototypes/`, `assets/`
**Action:**
1. **Analyze Codebase Architecture (via Graphify Out):** Do NOT just list files. Deep-read the data to extract the functional modules, core dependencies, and how data moves between FlutterFlow and Supabase.
2. **Decode Scripts & Automations (`scripts/`):** Do NOT output a list of filenames. Open the scripts, understand their internal logic, and extract:
   - **The Tool's Purpose & Value:** What operational problem does this script solve? (e.g., Database seeding, schema migration, backup automation).
   - **Operational Value:** How it accelerated development or secured the system.
3. **Analyze Design Prototypes & System Logic (`prototypes/`):** Stop listing `.html` and `.css` files. Read the prototypes and `dsign-system-showcase-specs.md` to extract:
   - **Functional Mockups Created:** What screens were prototyped and *why* (e.g., "High-fidelity recipe builder interactive layout to validate the BOM matrix UI before production").
   - **Design Foundations & Tokens:** Extract exact hex colors, type tokens, and interactive/haptic feedback tokens, detailing *why* they were chosen for a fast-paced warehouse environment.
4. **Audit Visual & Audio Media (`assets/`):** Instead of a file list, extract what brand identity assets and production media (like custom scan sound effects) are available, specifying their functional purpose in the app.
5. Append **Section 5 (Technical Blueprint & Value-Driven Assets)** to the ledger.

## 🛠️ Step 6: AI Constraints Filtration
**Target:** All `agent.md` files located anywhere in the workspace.
**Action:**
1. Perform a recursive search for `agent.md`.
2. Apply the extraction rules below to filter the content of each found file:
     - IGNORE simple file directories, temporary scratchpads, or task statuses.
     - EXTRACT strict immutable rules, API constraints, library limitations, and custom architectural workarounds.
3. Group the filtered rules by their file path.
4. Append **Section 6 (Technical Constraints & AI Directives)** to the ledger.

## 🛠️ Step 7: Uncategorized & Miscellaneous Discovery
**Target:** Any remaining directories or root files NOT processed in Steps 1-5 (e.g., `archive/`, custom stack-specific folders).
**Action:**
1. Scan the workspace for unmapped directories and standalone root files.
2. Apply the extraction rules below:
     - STRICTLY IGNORE standard environment directories and config files (`node_modules/`, `.git/`, `.next/`, `build/`, `dist/`, etc.).
     - EXTRACT legacy artifacts in `archive/`, or unrecognized domain-specific folders.
3. Identify assets that hold technical or historical value.
4. Append **Section 7 (Miscellaneous & Uncategorized Assets)** to the ledger.

---