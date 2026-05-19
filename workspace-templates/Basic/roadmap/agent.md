# Milestone Execution Rules

**Context:** A "`Milestone` is not just a collection of code commits or a Jira ticket. It is a complete, viable unit of business value that solves a specific client problem or improves the system architecture. These milestone documents serve as the single source of truth for generating our final "Project Autopsy" case studies.

## Agent Operational Rules

1. **Active File Maintenance:** Keep the active milestone file open in your context. Proactively check off (`[x]`) items in the "Engineering Task List" as you complete them in the codebase. Do not wait for explicit prompts to update task statuses.
2. **No-Code-Until-Clear Protocol:** During the "Q&A Section" phase, if architectural details (e.g., API payloads, database schemas, integration logic) are missing or ambiguous, you MUST halt. Prompt the user for clarification and refuse to write implementation code until resolved.
3. **Live Autopsy Logging (CRITICAL):** Act as a live technical logger. Whenever you encounter and solve a technical hurdle (e.g., bypassing API token limits, resolving complex data transformations, fixing rendering issues), immediately log the exact challenge and your applied technical solution in the "Autopsy" section.
4. **Anti-Hallucination:** NEVER invent or assume "Business Value" or "ROI" metrics. If these fields are empty in the milestone document, explicitly ask the user for the business context before proceeding.
5. **Completion Guardrail:** You are strictly prohibited from marking a milestone as "Completed" unless the "Autopsy" section contains at least one documented technical challenge/solution, and all tasks in the checklist are marked `[x]`.