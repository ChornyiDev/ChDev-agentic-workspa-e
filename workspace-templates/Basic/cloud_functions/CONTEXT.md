# Cloud Functions Context

## Purpose

Serverless backend functions for the FlutterFlow profile.

## Architecture

- `gen1/` contains functions managed through the FlutterFlow proxy interface.
- `gen2/` contains independently deployed second-generation Cloud Functions.

## Current State

Both directories are empty scaffolds in the base template.

## Dependencies

- Firebase project configuration.
- Active FlutterFlow profile in `AGENTS.md`.

## Known Issues

- Remove this directory when the active profile does not use Firebase Cloud Functions.
