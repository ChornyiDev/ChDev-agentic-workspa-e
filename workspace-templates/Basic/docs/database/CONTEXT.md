# Database Context

## Purpose

Relational schema definitions, connection documentation, migrations, and security-policy references for database-backed profiles.

## Architecture

- `001_schema_full.sql` is the canonical relational schema when the active profile uses SQL.
- `001_schema_simple.sql` is the derived AI-oriented schema summary.
- `01_connection.md` documents connection configuration and troubleshooting.

## Current State

Schema files are placeholders in the base template and are populated for projects that use a relational database.

## Dependencies

- Active database profile in `AGENTS.md`.
- Deployed database schema and migration history.

## Known Issues

- This directory is not applicable to Firebase-only projects unless they also use a relational database.
