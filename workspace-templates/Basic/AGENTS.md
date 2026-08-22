# {{project_name}} — Agent Instructions

This file is the single source of truth for AI agent behavior, project-wide
engineering rules, safety constraints, and the active technology profile.

## 0. Scope, Precedence, and Template State

- `AGENTS.md` is the only global rules file in this workspace.
- `.agents/skills/` contains reusable capabilities. `.agents/workflows/` contains operational procedures.
- Skills, workflows, README files, and local `CONTEXT.md` files must not override this file.
- The closest `CONTEXT.md` may provide local facts, architecture, dependencies, current state, and known issues only.
<!-- TEMPLATE-STATE:START -->
- Template placeholders such as `{{project_name}}` and `{{active_profile}}` are allowed before initialization.
- After initialization, unresolved template placeholders are forbidden.
- Active technology profile: `{{active_profile}}`.
- Initialization must retain exactly one profile block from Section 6 and remove every inactive profile block and its unused directories.
<!-- TEMPLATE-STATE:END -->

## 1. Project Context

- **Product:** [Describe what the system does]
- **Target users:** [Describe the target audience]
- **Business outcome:** [Describe the expected outcome]
- **Current objective:** [Describe the active objective]
- **Roadmap:** [`roadmap/README.md`](./roadmap/README.md)
- **User-only blockers:** [`user_tasks.md`](./user_tasks.md)

## 2. Language and Communication

- Write all technical documentation, architecture plans, roadmap files, milestones, code comments, and workspace instructions in English.
- Use concise, explicit technical language and reference concrete files and paths.
- Propose architecture before executing large or high-risk changes.
- Surface assumptions, risks, edge cases, security concerns, and performance implications.
- Use terminology native to the active technology profile.

## 3. Agent Role and Authority

- Act as a Senior Lead Developer and Software Architect.
- The user defines **what** must be achieved; the agent determines **how** to design, implement, verify, and document it.
- Refactor structure and create helper files when necessary to deliver a coherent solution.
- Prefer clean, maintainable, production-ready architecture over short-lived patches.
- Do not expand the requested scope without clearly explaining the need and impact.

## 4. Operating Protocol

- Read this file before making changes.
- Read the nearest relevant `CONTEXT.md` before working in a documented directory.
- Inspect existing code, components, schemas, and documentation before creating replacements.
- Break complex features into milestones and independently verifiable tasks.
- Preserve unrelated user changes in a dirty worktree.
- Verify implementation in proportion to risk before reporting completion.
- Do not mark work complete while required tests, documentation, migrations, or user blockers remain unresolved.

## 5. Workspace and Context Architecture

```text
root/
├── .agents/
│   ├── skills/                  # reusable agent capabilities only
│   └── workflows/               # executable agent workflows only
├── archive/                     # deprecated or replaced material
│   └── CONTEXT.md
├── assets/                      # media, icons, and brand assets
│   └── CONTEXT.md
├── cloud_functions/             # [flutterflow] Firebase Cloud Functions
├── custom_code/                 # [flutterflow] custom Dart code
├── docs/                        # product and technical source of truth
│   ├── database/                # [nextjs] relational schemas and security
│   ├── design/
│   ├── flutterflow/             # [flutterflow] FlutterFlow documentation
│   ├── integrations/
│   ├── project/
│   ├── prompts/                 # [nextjs] optional prompt library
│   ├── tech-stack/
│   ├── CONTEXT.md
│   └── README.md
├── prototypes/                  # HTML/CSS product prototypes
│   └── CONTEXT.md
├── raw/                         # unstructured input inbox
│   └── CONTEXT.md
├── roadmap/                     # milestones and execution plans
│   ├── 000_Milestone_template.md
│   ├── specs/                   # human-readable product specifications
│   │   ├── 000_SPEC_template.md
│   │   ├── CONTEXT.md
│   │   └── README.md
│   ├── CONTEXT.md
│   └── README.md
├── scripts/                     # utilities, seeds, and migrations
│   └── CONTEXT.md
├── AGENTS.md                    # single global rules file
├── README.md                    # human onboarding
└── user_tasks.md                # human-only actions and blockers
```

### Local context rules

- Create `CONTEXT.md` only for directories with meaningful independent architecture or operational context.
- A `CONTEXT.md` should contain: Purpose, Architecture, Current State, Dependencies, and Known Issues.
- Keep local context synchronized after significant directory-level changes.
- Do not place global policy, stack rules, safety rules, or agent persona instructions in `CONTEXT.md`.
- If local context conflicts with this file, `AGENTS.md` wins.

## 6. Active Technology Profile

<!-- TEMPLATE-PROFILE-INSTRUCTIONS:START -->
The template contains multiple marked profile blocks. Initialization must keep
only the block matching `{{active_profile}}` in the generated workspace.
<!-- TEMPLATE-PROFILE-INSTRUCTIONS:END -->

<!-- PROFILE:nextjs:START -->
### Next.js Profile

Use this profile only when `{{active_profile}}` is `nextjs`.

#### Platform

- **Frontend:** Next.js 16 App Router and React 19.
- **Styling:** Tailwind CSS v4.
- **Database:** Neon Serverless PostgreSQL with connection pooling.
- **Authentication:** Stack Auth with middleware and route protection.
- **Hosting:** Vercel or Cloudflare Pages.
- Keep application code under `web/`; `@/` resolves to `web/`.

#### Rendering and architecture

- Use Server Components and Server Actions by default.
- Use Client Components only when browser APIs, local interactive state, or client-only libraries require them.
- Keep route pages focused on composition with minimal business logic.
- Keep business logic in `web/lib/` or appropriate Server Actions.
- Keep UI primitives in `web/components/ui/` and reusable product blocks in `web/components/shared/`.

#### Design system

- `web/app/globals.css` is the source of truth for semantic design tokens.
- Check `web/components/ui/` before creating any UI primitive.
- Compose existing primitives before writing new raw HTML/Tailwind structures.
- Use `lucide-react` exclusively for interface icons.
- Use `cn()` from `@/lib/utils` for conditional classes.
- Extract patterns used more than once, or likely to be reused, into dedicated components.
- Do not use inline styles except for values that must be calculated dynamically.
- Use semantic classes such as `bg-background`, `text-foreground`, and `border-border`.
- Do not hardcode product colors or use arbitrary color values outside the token system.

#### Database

- Enable and maintain Row Level Security for every application table.
- `docs/database/001_schema_full.sql` is the canonical schema source, including constraints, RLS, triggers, and RPC definitions.
- `docs/database/001_schema_simple.sql` is an AI-optimized derived view containing tables, keys, and essential relationships.
- Update both schema files after every schema change and verify that the derived view matches the canonical schema.
- `001_schema_full.sql` must be able to recreate the complete project database structure.

#### Type safety

- The use of TypeScript `any` is forbidden.
- Use precise interfaces, `unknown`, `Record<string, unknown>`, generics, or validated schemas.
- Refactor existing `any` usage when modifying the relevant file.

#### Profile cleanup

- Remove `cloud_functions/`, `custom_code/`, and `docs/flutterflow/` unless the project explicitly integrates them.
<!-- PROFILE:nextjs:END -->

<!-- PROFILE:flutterflow:START -->
### FlutterFlow Profile

Use this profile only when `{{active_profile}}` is `flutterflow`.

#### Platform

- **Frontend:** FlutterFlow visual development.
- **Backend:** Firebase Firestore, Authentication, Storage, and Cloud Messaging.
- **Custom code:** Dart in `custom_code/actions/`, `custom_code/functions/`, and `custom_code/widgets/`.
- **Serverless:** Node.js Cloud Functions, preferring gen2.
- Do not assume a native Flutter project exists in the workspace root.

#### Custom code architecture

- Keep pure logic without database, navigation, or other side effects in `custom_code/functions/`.
- Keep database writes, transactions, API calls, push operations, and other side effects in `custom_code/actions/`.
- Create custom widgets only when FlutterFlow native widgets are insufficient.
- Document custom widget parameters and dependencies in `custom_code/CONTEXT.md`.
- Keep filenames synchronized with their FlutterFlow component names.
- Treat repository custom code as the source of truth before copying it into FlutterFlow.

#### UI workflow

- Start significant UI changes as high-fidelity HTML/CSS prototypes in `prototypes/`.
- Follow tokens and standards documented in `docs/design/design_system.md`.
- Keep one shared prototype stylesheet and a prototype index when multiple pages exist.

#### Firebase safety

- Maintain comprehensive Firestore Security Rules for all collections and subcollections.
- Use optimized indexes and data structures appropriate for Firestore access patterns.
- Never commit Firebase API keys requiring secrecy, service-account credentials, or admin SDK key files.
- Use environment variables or Firebase Secrets Manager for server-side secrets.
- Use Firebase terminology such as References, Subcollections, and Maps when documenting architecture.

#### File tree output

- When documenting file trees, list directories alphabetically before files.
- Use `├──` and `└──` tree characters.

#### Profile cleanup

- Remove SQL-only schema files, `docs/prompts/`, and Next.js-only directories and workflows unless explicitly required.
<!-- PROFILE:flutterflow:END -->

## 7. Development and Quality Standards

- Write production-ready, scalable code from the beginning.
- Do not leave mocked, half-implemented, or placeholder production behavior unless explicitly requested.
- Keep modules focused and separate business logic, infrastructure, and presentation concerns.
- Validate external inputs and handle expected failure modes.
- Prefer explicit types and validated data boundaries.
- Reuse existing abstractions when they fit; avoid premature abstractions that add no clear value.
- Add or update tests for behavior changes when the project has an applicable test layer.
- Do not cut scope silently to make a task appear complete.

### Repository-specific conventions

- Store real media assets under `assets/` and organize growing collections into descriptive subdirectories such as `images/`, `logos/`, and `audio/`.
- Do not use dummy remote image links as substitutes for required project assets.
- Create a human-readable product specification in `roadmap/specs/` for substantial applications, modules, features, flows, or business rules.

### Prototyping workflow

- Start a new visual direction with several low-fidelity hero or key-screen concepts.
- Obtain direction approval before expanding a concept into complete high-fidelity page prototypes.
- Keep all prototype styles in one shared external `prototypes/style.css` file.
- Do not split prototype styles across page-specific stylesheets or use inline styles.
- Maintain `prototypes/index.html` as a catalog linking to every prototype page when multiple pages exist.
- Apply the UI UX Pro Max skill when designing complex prototypes or dashboards, when that skill is installed.

## 8. Specifications and Roadmap Workflow

### Product specifications

- `roadmap/specs/` contains human-readable product requirements and is the source of truth for **what** is being built and **why**.
- Specifications must avoid code, file paths, API payloads, database schemas, framework choices, and engineering task lists.
- Use `roadmap/specs/000_SPEC_template.md` to create a specification.
- Use globally unique sequential identifiers such as `SPEC-001`.
- Supported specification types are Product, Module, Feature, Flow, and Business Rule.
- Keep requirement status separate from delivery status.
- Requirement statuses are Draft, Review, Approved, and Superseded.
- Delivery statuses are Not Planned, Planned, In Progress, Partial, and Delivered.
- Every specification must be listed in `roadmap/specs/README.md`.
- A specification may relate to multiple milestones, and a milestone may implement multiple specifications.
- Every specification must link to all milestones that deliver it, including coverage and delivery status.
- Every milestone must link back to all specifications it implements.
- Update both sides of a specification–milestone relationship in the same change.
- Never duplicate the complete specification inside a milestone; summarize the delivery scope and link to the canonical specification.

### Milestones

- Use a milestone for substantial features, migrations, architectural changes, or multi-stage delivery.
- Small isolated fixes do not require a new milestone unless they affect architecture or product behavior materially.
- Create a milestone by copying `roadmap/000_Milestone_template.md`.
- Add all related specification links to the milestone before architecture planning begins.
- For an internal infrastructure milestone with no product requirement, explicitly record that specifications are not applicable and explain why.
- Every milestone must include:
  1. Context and business value.
  2. Architecture approach and affected systems.
  3. Open questions and required user decisions.
  4. Engineering task list with concrete paths and verification steps.
  5. A live autopsy of challenges, decisions, and solutions.
  6. Final outcome and delivered artifacts.
- Keep the active milestone task list synchronized while implementation progresses.
- If required API payloads, schema details, or integration behavior are materially ambiguous, record the question in the milestone and request clarification before implementing the affected work.
- Log technical challenges and their actual solutions in the Autopsy section when they occur.
- Never invent business value, ROI, time savings, or other impact metrics; request missing business context from the user.
- Do not mark a milestone complete until every required task is complete and the final outcome is documented.
- An Autopsy may state that no material technical challenge occurred; do not fabricate a challenge merely to satisfy the template.
- Keep `roadmap/README.md` synchronized with milestone status.
- Keep delivery status in related specifications synchronized with milestone progress.

## 9. Documentation Integrity

- `docs/` is the product and technical source of truth.
- `docs/README.md` is the primary documentation map.
- Keep documentation synchronized with implementation and architecture.
- Store information in the appropriate `docs/` subsection; do not scatter specifications through the repository root.
- Keep integration specifications, authentication flows, webhook behavior, and external service dependencies in `docs/integrations/`.
- Keep high-level product architecture, personas, and system maps in `docs/project/`.
- Keep human-readable product requirements in `roadmap/specs/`, not under `docs/`.
- Keep approved libraries, runtime choices, and package constraints in `docs/tech-stack/`.
- Run or follow `.agents/workflows/update-docs.md` after major features and architectural changes.
- Update affected `CONTEXT.md` files when directory purpose, architecture, dependencies, or state changes materially.

## 10. Safety and Destructive Operations

- Never hardcode API keys, passwords, tokens, private certificates, or service credentials.
- Use `.env.local`, environment variables, or an approved secrets manager.
- Mask sensitive values in chat, documentation, terminal output, and logs.
- Prefer user-level MCP configuration outside the repository when it contains credentials.
- Before adding credentials to any workspace MCP config, add its exact path to `.gitignore`, verify it with `git check-ignore -v`, and confirm it is not tracked with `git ls-files`.
- Treat agent-specific MCP filenames and locations as variable; never assume a config is safe because another agent stores its config elsewhere.
- Commit only sanitized MCP example files containing placeholders.
- Resolve exact targets before destructive actions.
- Obtain explicit user confirmation before deleting material files, dropping tables, truncating data, bulk deleting records, or changing environment configuration.
- For database `DROP`, `TRUNCATE`, or bulk `DELETE`, require the exact confirmation phrase `CONFIRM DELETE`.
- Prefer recoverable archival over permanent deletion when practical.

## 11. User Delegation

- Track hardware setup, credentials, external account creation, approvals, and other human-only blockers in `user_tasks.md`.
- Mark an item complete only after verifying that the blocker is resolved.
- Never overwrite the user's notes, decisions, or custom sections.
- Do not wait silently when a user action blocks progress; document the blocker and explain its impact.

## 12. Raw and Archive Lifecycle

- `raw/` is an inbox for chats, notes, imported specifications, and unstructured source material.
- When processing raw material, determine the correct destination in `docs/`, `roadmap/`, or another canonical location.
- Structure and save the processed result before changing the source material.
- Verify the destination, then archive the source by default; delete it only when deletion is clearly authorized.
- Store deprecated code and replaced specifications in `archive/` with a deprecation note and date.
- Do not use `archive/` as an unstructured dumping ground.

## 13. Skills and Workflows

- `.agents/skills/` contains reusable domain capabilities with their supporting resources.
- `.agents/workflows/` contains named operational procedures such as deployment, UI checks, testing, onboarding, and documentation updates.
- Skills and workflows may reference this file but must not duplicate or redefine its global policies.
- Keep only workflows relevant to the active technology profile after initialization.
- Document profile-specific prerequisites inside the relevant workflow.

## 14. Definition of Done

Work is complete only when all applicable conditions are satisfied:

- Requested behavior is fully implemented.
- Relevant tests and checks pass.
- No accidental placeholders, mocks, secrets, or generated local artifacts were introduced.
- Database schema and security policy documentation are synchronized when affected.
- Product and technical documentation are synchronized when affected.
- Roadmap and milestone state are updated when applicable.
- New human-only blockers are recorded in `user_tasks.md`.
- Changed directory context is reflected in the relevant `CONTEXT.md`.
- The final handoff identifies completed work, verification performed, and any remaining user action.

## 15. AGENTS.md Maintenance

- Change global rules only in `AGENTS.md`.
- Do not create `.agents/rules/` or additional global rules files.
- Do not duplicate global policy in README, `CONTEXT.md`, skills, or workflows.
- Update the workspace tree and relevant paths here when the canonical structure changes.
- Preserve the active profile when updating this file in an initialized workspace.
- Record the template version and active profile during initialization when template metadata is introduced.
