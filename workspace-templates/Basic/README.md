# 🚀 {{project_name}}

Welcome to the development repository for **{{project_name}}**.

## 📖 Quick Start

1. **AI Setup:** Introduce your agent to the project by pointing them to [agent.md](file://./agent.md).
2. **Core rules:** [.agents/rules/meta-rules.md](file://./.agents/rules/meta-rules.md) (always applies).
3. **Pick your stack** — enable **one** stack rules file in Cursor (or tell the agent to follow it):
   * **Next.js:** [.agents/rules/stack-nextjs.md](file://./.agents/rules/stack-nextjs.md)
   * **FlutterFlow:** [.agents/rules/stack-flutterflow.md](file://./.agents/rules/stack-flutterflow.md)
4. **Cleanup:** Delete the unused `stack-*.md`, folders, and workflows listed at the bottom of your stack file.
5. **Execution Plan:** Follow the active roadmap milestones in [roadmap/README.md](file://./roadmap/README.md).

## 📂 Repository Structure

* **[.agents/](file://./.agents/)** — Core rules (`meta-rules.md`), stack instructions (`stack-*.md`), and workflows.
* **[cloud_functions/](file://./cloud_functions/)** — FlutterFlow / Firebase only.
* **[custom_code/](file://./custom_code/)** — FlutterFlow Custom Dart only.
* **[docs/](file://./docs/)** — Project overview, schemas, integrations, and feature specs.
* **[roadmap/](file://./roadmap/)** — Phase-by-phase planning, milestone templates, and autopsies.
* **[raw/](file://./raw/)** — Inbox directory for raw dumps, customer chats, and legacy texts.
* **[archive/](file://./archive/)** — Preserved history of replaced, legacy, or deprecated files.
