# Raw Inbox Context

## Purpose

Temporary intake for unstructured documents, chat transcripts, notes, and imported source material.

## Architecture

Material moves from this directory into canonical documentation, roadmap artifacts, or the archive after processing and verification.

## Current State

No raw project material is included in the base template.

## Dependencies

- `docs/`, `roadmap/`, and `archive/` are the primary destinations.
- `AGENTS.md` defines the data lifecycle and deletion policy.

## Known Issues

- Raw material can become stale if processed sources are not archived or explicitly removed.
