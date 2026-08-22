# Adopt the Workspace Template into an Existing Project

Use this document as an execution prompt for an AI coding agent. It is the safe
installer for an existing, non-empty workspace.

## Goal

Adopt compatible parts of the Basic workspace template without blindly copying
the template, deleting project files, or overwriting local rules, documentation,
skills, workflows, secrets, or source code.

The source repository contains:

- `workspace-templates/Basic/` — the workspace scaffold.
- `agent-library/` — the canonical skills and workflows library.
- `agent-library/bundles/basic.yaml` — the Basic asset selection.

If these paths are not available from the current session, ask the user for the
absolute path or Git repository containing the template source.

## Non-Negotiable Safety Rules

1. Do not run `installers/init-new-workspace.sh` against this workspace.
2. Begin with a read-only audit. Do not mutate files during discovery.
3. Preserve all unrelated user changes and inspect `git status` before planning.
4. Never replace an existing `AGENTS.md`, `.gitignore`, README, skill, workflow, or documentation tree wholesale.
5. Never delete, rename, archive, or overwrite a material file without identifying the exact target and receiving explicit user approval.
6. Never copy secret values or secret-bearing MCP configuration from the template source.
7. Do not assume the technology profile. Infer it from evidence and ask the user if evidence conflicts or is incomplete.
8. Do not install an asset over a locally modified asset without showing the difference and asking the user how to proceed.
9. Do not modify application behavior merely to make it match the template structure.
10. Treat the template as guidance and reusable infrastructure, not as authority over the existing product.

## Phase 1: Read-Only Audit

Inspect the existing workspace and collect evidence for the following areas.

### Repository state

- Repository root and active branch.
- `git status --short`.
- Existing ignored and untracked files relevant to agent or secret configuration.
- Existing workspace/template metadata.

### Project profile

- Package manifests and build configuration.
- Application framework and source-code layout.
- Database and authentication providers.
- Hosting and deployment configuration.
- Evidence for `nextjs`, `flutterflow`, or another profile.

### Instructions and context

- Existing `AGENTS.md`, `agent.md`, nested instruction files, and local context files.
- Project-specific rules that must be preserved.
- Conflicting or duplicated rules.

### Agent assets

- `.agents/skills/` and any legacy `.agent/skills/` directories.
- `.agents/workflows/` and legacy workflow locations.
- Skill package names, bundled scripts, references, assets, and data files.
- Differences between installed assets and `agent-library/` versions.

### Documentation and planning

- `docs/`, `roadmap/`, existing specifications, plans, and milestone files.
- Existing `docs/features/` or similar feature documentation.
- Existing README and onboarding documentation.

### Safety and configuration

- Existing `.gitignore` rules.
- MCP and agent-specific config paths.
- Potentially tracked secret files. Do not print secret values.

## Phase 2: Present an Adoption Plan

Before changing files, present a concise table using these actions:

| Action | Meaning |
| :--- | :--- |
| `CREATE` | New file or directory with no existing equivalent. |
| `MERGE` | Preserve existing content and add selected template content. |
| `KEEP` | Existing project artifact remains authoritative. |
| `INSTALL` | Add a missing skill or workflow from the library. |
| `UPDATE` | Replace an unmodified installed asset with a selected library version. |
| `CONFLICT` | Local and library/template content differ and require a user decision. |
| `RENAME` | Proposed path normalization requiring user approval. |
| `ARCHIVE` | Proposed recoverable retirement requiring user approval. |
| `SKIP` | Template component is not applicable. |

For every `MERGE`, `CONFLICT`, `RENAME`, or `ARCHIVE`, explain:

- current path;
- proposed destination or source;
- why the change is useful;
- what content will be preserved;
- whether user approval is required.

Ask the user to approve the adoption plan before beginning mutation.

## Phase 3: Select the Technology Profile

Use project evidence to recommend a profile.

### Next.js evidence

- Next.js package and App Router structure.
- React and Tailwind configuration.
- Relational database or Neon configuration.

### FlutterFlow evidence

- FlutterFlow workspace configuration.
- `custom_code/`, Firebase, or Cloud Functions structure.
- FlutterFlow-specific documentation or exported project artifacts.

If both profiles are present, describe the hybrid architecture and ask the user
which profile should control the global `AGENTS.md`. Do not delete either stack.

Only the selected profile rules should be merged into the final `AGENTS.md`.

## Phase 4: Adopt Global Instructions

### No existing `AGENTS.md`

Create it from the Basic template, resolve project placeholders, keep only the
selected profile block, and adapt paths to the actual project structure.

### Existing `AGENTS.md`

Perform a section-by-section merge:

1. Preserve project-specific product context and established conventions.
2. Add missing safety, documentation, roadmap, context, and asset-management rules.
3. Adapt template stack paths to the existing source layout.
4. Resolve direct conflicts with the user instead of silently choosing a side.
5. Keep one global `AGENTS.md` after adoption.

Do not copy template placeholders into the existing workspace.

## Phase 5: Adopt Local Context

The target convention is `CONTEXT.md` for descriptive local context only.

If legacy `agent.md` files exist:

1. Read and classify every section.
2. Move global or normative rules into the proposed `AGENTS.md` merge.
3. Keep Purpose, Architecture, Current State, Dependencies, and Known Issues as local context.
4. Propose renaming `agent.md` to `CONTEXT.md`.
5. Ask for approval before each material rename or archive operation.

Do not create `CONTEXT.md` in every directory automatically. Create it only for
directories with meaningful independent architecture or operational context.

## Phase 6: Adopt Specifications and Roadmap

### Product specifications

- Create `roadmap/specs/` only if the workspace has no equivalent specification catalog.
- Preserve an existing specification system if it already provides the same function.
- Human-readable product requirements belong in `roadmap/specs/`.
- Specifications and milestones must link to each other in both directions.

### Existing `docs/features/`

Do not delete or move it automatically. Classify its files:

- Human-readable product intent and acceptance criteria → propose migration to `roadmap/specs/`.
- Architecture, API, schema, implementation, or operational details → keep under the appropriate technical documentation section.
- Obsolete duplicates → propose archival with an explanation.

### Milestones

- Preserve existing roadmap identifiers and history.
- Add specification links without renumbering existing milestones.
- Do not replace an existing milestone template unless the user approves the differences.

## Phase 7: Adopt Skills and Workflows

Use `agent-library/registry.yaml` and `agent-library/bundles/basic.yaml` as the
source catalog. Install only assets applicable to the selected profile or
explicitly selected by the user.

For each asset:

| Existing state | Required action |
| :--- | :--- |
| Missing | `INSTALL` the complete package or workflow. |
| Byte-identical | `KEEP`; no copy required. |
| Existing asset matches an older clean library version | Propose `UPDATE`. |
| Locally modified | Mark `CONFLICT`; show a concise diff and ask. |
| Workspace-only asset | `KEEP`; optionally propose promotion to the library. |
| Same name, unrelated purpose | Do not overwrite; propose rename or skip. |

When installing a skill, copy its complete directory including `SKILL.md`,
scripts, references, assets, and data. Never copy only `SKILL.md` when supporting
files exist.

The final agent structure is:

```text
.agents/
├── skills/
└── workflows/
```

Do not create `.agents/rules/`.

## Phase 8: Merge `.gitignore` and Secret Protection

Merge missing ignore rules instead of replacing the existing `.gitignore`.

Ensure coverage for:

- environment and secret files;
- agent-local caches;
- Graphify output;
- local MCP configurations;
- profile-specific build artifacts;
- IDE-local state.

For every secret-bearing MCP config inside the workspace:

1. Add its exact path to `.gitignore`.
2. Verify with `git check-ignore -v -- <path>`.
3. Check tracking with `git ls-files --error-unmatch <path>`.
4. If a real secret was committed, tell the user to rotate it immediately.

Never expose secret values while reporting findings.

## Phase 9: Apply Approved Changes

After the user approves the plan:

1. Apply additive and merge-safe changes first.
2. Preserve formatting and project-specific content.
3. Stop at any newly discovered conflict.
4. Ask again before destructive or hard-to-recover actions.
5. Keep changes small enough for the user to review with Git diff.

Do not interpret plan approval as permission for an unlisted deletion, rename,
archive, dependency change, deployment, or database mutation.

## Phase 10: Verify and Report

Run all applicable checks:

- unresolved template placeholders;
- broken relative Markdown links;
- duplicate global rules files;
- invalid `CONTEXT.md` structure;
- missing skill support files;
- workflow links and paths;
- profile-incompatible assets;
- ignored MCP configs;
- `git diff --check`;
- relevant project tests when implementation files were affected.

Provide a final report containing:

- selected profile;
- created and merged files;
- installed, updated, kept, and conflicted assets;
- renamed or archived files;
- verification performed;
- unresolved user decisions;
- exact remaining risks or manual actions.

