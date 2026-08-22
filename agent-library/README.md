# Agent Library

This directory is the canonical local library for reusable skills and workflows.
Copies inside workspace templates and initialized workspaces are installed snapshots,
not independent sources of truth.

## Structure

```text
agent-library/
├── bundles/                 # asset selections for workspace templates
├── skills/                  # complete skill packages
├── workflows/               # reusable workflow files
├── README.md
└── registry.yaml            # catalog, versions, profiles, and source type
```

## Current Workflow

1. Create or update an asset in this library.
2. Update its version and metadata in `registry.yaml`.
3. Add or remove it from the appropriate bundle.
4. Copy the selected snapshot into the target template or workspace.

If an asset is first developed in a working workspace, test it there and then
promote the complete skill directory or workflow file into this library before
adding it to a template.

## External Assets

Third-party skills and workflows will be registered with a GitHub repository,
path, and pinned tag or commit. Do not track external assets from an unpinned
`main` branch when reproducible workspace initialization matters.

The repository-level `installers/init-new-workspace.sh` installs the selected
bundle into a new workspace. `installers/ADOPT_EXISTING_WORKSPACE.md` guides an
agent through safe adoption in an existing workspace.

Dedicated library update, validation, and promotion scripts will be added after
the library format and template contents are finalized.
