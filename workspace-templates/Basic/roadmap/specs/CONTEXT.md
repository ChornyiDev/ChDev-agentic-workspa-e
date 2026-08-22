# Product Specifications Context

## Purpose

Human-readable product requirements describing what should be built and why.

## Architecture

- `000_SPEC_template.md` is the source template for new specifications.
- `README.md` is the specification catalog and status index.
- `SPEC-XXX_name.md` files describe products, modules, features, flows, or business rules.
- Specifications and milestones maintain bidirectional delivery links.

## Current State

The base template contains the specification template and an empty catalog.

## Dependencies

- `roadmap/` milestones deliver approved specification scope.
- `docs/` describes implemented architecture and operational details.
- `AGENTS.md` defines specification and roadmap policy.

## Known Issues

- Bidirectional links are maintained manually until workspace initialization and validation tooling is implemented.

