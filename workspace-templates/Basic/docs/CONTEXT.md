# Documentation Context

## Purpose

Canonical product and technical knowledge for the workspace.

## Architecture

- [`database/`](./database/) — schemas, connections, and data security.
- [`design/`](./design/) — design tokens and UI standards.
- [`integrations/`](./integrations/) — external APIs, webhooks, and SDKs.
- [`project/`](./project/) — product overview and system architecture.
- [`tech-stack/`](./tech-stack/) — approved libraries and runtime choices.

## Current State

The base template contains documentation scaffolds that must be completed during project initialization.

## Dependencies

- `docs/README.md` provides the human-readable documentation map.
- `AGENTS.md` defines documentation maintenance policy.
- `roadmap/specs/` contains human-readable product requirements.

## Known Issues

- Stack-specific directories must be removed when they do not match the active profile.
