# 🚀 {{project_name}}

Welcome to the development repository for **{{project_name}}**.

<!-- TEMPLATE-SOURCE:START -->
This template receives reusable skills and workflows from the local
[`agent-library`](../../agent-library/README.md) according to
[`bundles/basic.yaml`](../../agent-library/bundles/basic.yaml).

- New or empty workspace: run [`init-new-workspace.sh`](../../installers/init-new-workspace.sh).
- Existing workspace: give [`ADOPT_EXISTING_WORKSPACE.md`](../../installers/ADOPT_EXISTING_WORKSPACE.md) to the agent.
<!-- TEMPLATE-SOURCE:END -->

## 📖 Quick Start

1. **AI Setup:** Introduce your agent to the project by pointing it to [`AGENTS.md`](./AGENTS.md).
<!-- TEMPLATE-INITIALIZATION-STEPS:START -->
2. **Choose one technology profile:** replace `{{active_profile}}` with `nextjs` or `flutterflow`, retain the matching marked profile block in [`AGENTS.md`](./AGENTS.md), and remove the inactive block and unused directories.
3. **Resolve template fields:** replace all remaining `{{...}}` placeholders before development starts.
<!-- TEMPLATE-INITIALIZATION-STEPS:END -->
4. **Use `.agents/` only for reusable skills and workflows.** Global rules do not belong there.
5. **Use local `CONTEXT.md` files for directory facts only.** They do not define agent rules.
6. **Execution Plan:** Follow the active roadmap milestones in [`roadmap/README.md`](./roadmap/README.md).

## 📂 Repository Structure

* **[.agents/](./.agents/)** — Reusable skills and workflows only.
* **[cloud_functions/](./cloud_functions/)** — FlutterFlow / Firebase only.
* **[custom_code/](./custom_code/)** — FlutterFlow Custom Dart only.
* **[docs/](./docs/)** — Implemented architecture, schemas, integrations, design, and technology documentation.
* **[roadmap/](./roadmap/)** — Product specifications, milestones, execution plans, and autopsies.
* **[raw/](./raw/)** — Inbox directory for raw dumps, customer chats, and legacy texts.
* **[archive/](./archive/)** — Preserved history of replaced, legacy, or deprecated files.
