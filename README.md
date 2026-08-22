# ChDev Agentic Workspace

A workspace-template system for creating new AI-assisted projects and safely
adopting its structure in existing repositories.

The system separates global agent instructions, local project context, product
specifications, reusable skills, and operational workflows.

## Repository Structure

```text
agent-library/          # canonical reusable skills and workflows
installers/             # new-workspace and existing-workspace adoption tools
workspace-templates/    # distributable workspace templates
addons/                 # optional integrations and reference material
```

## Create a New Workspace

Use the executable installer only for a new or empty directory:

```bash
./installers/init-new-workspace.sh \
  --target ../my-project \
  --name "My Project" \
  --profile nextjs \
  --git-init
```

Supported profiles:

- `nextjs`
- `flutterflow`

Optional skills can be selected with `--skills`:

```bash
--skills brainstorming,ui-ux-pro-max
```

The installer refuses to run against a non-empty directory.

## Adopt an Existing Workspace

Do not run the automated installer in an existing project. Instead, give an AI
agent [ADOPT_EXISTING_WORKSPACE.md](./installers/ADOPT_EXISTING_WORKSPACE.md).

The guide requires a read-only audit, an adoption plan, explicit approval before
destructive changes, and safe merging of `AGENTS.md`, `.gitignore`, skills,
workflows, documentation, specifications, and roadmap artifacts.

## Basic Template

The current template is [workspace-templates/Basic](./workspace-templates/Basic/README.md).

Each initialized workspace contains:

- `AGENTS.md` — the only global agent-rules file;
- `CONTEXT.md` files — local descriptive context, not global rules;
- `.agents/skills/` and `.agents/workflows/` — installed reusable assets;
- `roadmap/specs/` — human-readable product requirements;
- `roadmap/` — delivery milestones, technical plans, and autopsies;
- `.workspace/template.lock.yaml` — initialization profile and installed assets.

## Skills and Workflows

[agent-library](./agent-library/README.md) is the canonical local library.

- [registry.yaml](./agent-library/registry.yaml) catalogs available assets and their profiles.
- [bundles/basic.yaml](./agent-library/bundles/basic.yaml) selects assets for the Basic template.
- Template and workspace `.agents/` directories are installed snapshots, not separate sources of truth.

Third-party assets should be registered with a pinned Git tag or commit before
they are added to a template bundle.

## Security

- Never commit secrets, tokens, local MCP configurations, or service-account files.
- Verify ignored MCP config paths with `git check-ignore -v -- <path>`.
- If a real secret was committed, rotate it immediately; `.gitignore` does not remove Git history.

## Current Scope

The repository currently provides workspace initialization and safe adoption.
Dedicated scripts for updating, validating, and promoting skills/workflows will
be added after the asset library format is finalized.

