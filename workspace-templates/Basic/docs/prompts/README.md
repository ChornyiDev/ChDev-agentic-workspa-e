# 🤖 System Prompts Directory

This directory stores all the generated System Prompts for creating specialized AI assistants or micro-agents within this project.

## 🚀 How to Generate & Manage Prompts

This project template integrates the `system-prompt-generator` skill, which uses a professional 10-component Prompt Engineering framework to automatically construct high-performance AI system prompts.

### 1. The `!BUILD` Command (Generation)

Open the AI Chat and type `!BUILD` to generate a new system prompt. The AI will read the context files from the `.context/` directory and create the prompt here.

- **`!BUILD`**: Analyzes the global context files in `.context/` and generates a main system prompt. The result is saved as `docs/prompts/system_prompt.md`.
- **`!BUILD [AgentName]`**: Analyzes both the global context in `.context/` AND specific files in an optional `.context/[AgentName]/` subdirectory to generate a specialized prompt. The result is saved as `docs/prompts/[AgentName]_prompt.md`.

*Tip: Before generating, populate the `.context/` directory with your project's persona details, technical stack, and specific constraints.*

### 2. The `!CHECK` Command (Audit & Review)

Use the `!CHECK` command to audit an existing prompt against professional prompt engineering guidelines.

- Open any generated prompt in this folder (or provide its path), and type **`!CHECK`** in the chat. 
- The AI will analyze the prompt's structure, verify the presence of negative constraints and dynamic variables, and suggest improvements to make it more reliable and precise.
