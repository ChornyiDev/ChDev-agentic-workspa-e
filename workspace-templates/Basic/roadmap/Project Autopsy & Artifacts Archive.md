# [Project Name] | Consolidated Workspace Data Archive

## 1. Source Context & Business Problem
*Source: `raw/`, `docs/project/`, `README.md`*

- **Primary Objective:** [State the core goal of the project]
- **Target Audience:** [Define who the end-users or stakeholders are]
- **Original Client Request / The "Big Problem":** [Describe the initial pain points, broken processes, or the core requirement that initiated this project]

---

## 2. Documentation Registry
*Source: `docs/` directory scan*
*(Agent Instruction: List all discovered specifications and summarize their primary purpose in one sentence).*

- **Database & Architecture (`docs/database/`, `docs/project/`):** 
  - `[filename.md]`: [Brief description of its purpose]
- **Design & Features (`docs/design/`, `docs/features/`):** 
  - `[filename.md]`: [Brief description]
- **Integrations & Tech Stack (`docs/integrations/`, `docs/tech-stack/`):** 
  - `[filename.md]`: [Brief description]
- **All other documentation cataloged  (in `docs/`):**  [`[catalogue]`]: [Brief description]

---

## 3. Milestone Execution & Autopsy Log
*Source: `roadmap/` directory (Parsing all `Milestone [XX].md` files)*
*(Agent Instruction: Iterate through all milestone files. Extract and append the following structure for EACH milestone found).*

### Milestone [XX]: [Milestone Name]
- **Status & Value:** [Status] | Expected ROI: [ROI/Impact metric]
- **Objective:** [What specific feature/system was built during this phase]
- **Tech Stack & Schema Changes:** [Key technologies utilized and any database modifications made]
- **The "Autopsy" (Challenges & Solutions):** 
  *(Agent Instruction: Extract verbatim from the "5. 🧠 Autopsy: Challenges & Solutions" section of the milestone file)*
  - *Challenge:* [Description of the technical or logical roadblock]
    - *Solution:* [How it was resolved, workarounds applied, or structural changes made]
  - *(List all challenges logged for this milestone)*
- **Deliverables & Outcome:** [Final result, links to PRs, or updated components]

---

## 4. Technical Blueprint & Assets
*Source: `graphify-out/`, `scripts/`, `assets/`, `prototypes/`*

- **Codebase Architecture (Graphify Out):** 
  - [Outline the main modules, service dependencies, and key components parsed from Graphify]
- **Scripts, Automations & Migrations (`scripts/`):** 
  - `[script_name]`: [Purpose of the CLI utility, migration, or automation script]
- **Prototypes & Design Logic (`prototypes/`):** 
  - [List HTML/CSS mockups and extract core rules from `dsign-system-showcase-specs.md`]
- **Visual & Brand Assets (`assets/`):** 
  - [List key available media: logos, SVGs, brand icons to be used in the final showcase]

---

## 5. Technical Constraints & AI Directives (Filtered)
*Source: Semantic extraction from all `agent.md` files across the workspace*
*(Agent Instruction: ONLY extract immutable system rules, API constraints, library limitations, and custom architectural solutions. STRICTLY IGNORE generic folder descriptions, temporary scratchpads, and simple file lists).*

- **Global System Directives (`/agent.md`):**
  - [Extract the core, unchangeable rules and workflows governing the entire project]
- **Local Module Logic & Specific Solutions:**
  - *Path: `[Path/to/directory]/agent.md`:* 
    - [Extract specific rules, e.g., "Use custom parser for this library because X," or "API tokens must be routed through Y component"]
  - *Path: `[Path/to/directory]/agent.md`:* 
    - [Extract specific rules...]

---

## 6. Miscellaneous & Uncategorized Assets
*Source: Root directory and any unmapped subdirectories (e.g., `archive/`, custom framework folders)*
*(Agent Instruction: Log any significant files or directories that bypassed the previous categories but hold structural, historical, or technical value).*

- **Unmapped Directories:** 
  - `[Directory Name]/`: [Brief inference of its contents and purpose]
- **Standalone Artifacts:** 
  - `[filename.ext]`: [Purpose of standalone config files, isolated scripts, or legacy components]