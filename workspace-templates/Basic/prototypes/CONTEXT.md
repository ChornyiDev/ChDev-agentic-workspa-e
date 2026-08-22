# Prototype Context

## Purpose

Reviewable HTML/CSS concepts used to validate visual direction and interaction before production implementation.

## Architecture

- `style.css` is the shared prototype stylesheet.
- `index.html` becomes the prototype catalog when pages are added.
- `pages/` may contain individual full-page prototypes.
- `dsign-system-showcase-specs.md` contains the current showcase specification.

## Current State

The base template contains a showcase specification and an empty shared stylesheet.

## Dependencies

- `docs/design/design_system.md`.
- Product specifications under `roadmap/specs/`.
- Prototyping rules in `AGENTS.md`.

## Known Issues

- The showcase specification filename contains the legacy spelling `dsign` and should be normalized separately.
