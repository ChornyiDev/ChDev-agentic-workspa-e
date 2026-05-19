# 🚀 Antigravity Project Template

**Role Model:** User = Project Owner | Agent = Lead Developer & Architect

This template provides a structured environment for AI-assisted development. It transforms the IDE into a "Mission Control" center where the user defines goals and the agent handles implementation, testing, and documentation.

---

## 🛠 Setup & Installation

To use this template efficiently, you should set up two main tools: **Spotlight Automation** (for new projects) and a **Terminal Alias** (for existing projects).

### 1. Spotlight Automation (`newproject` app)
Use this to create a brand new project from scratch or clone an existing repo while automatically "injecting" this template.

**Step-by-step Setup:**
1.  Open **Automator** on your Mac.
2.  Select **New Document** and choose **Application**.
3.  Add the **Run Shell Script** action to the workflow.
4.  Set **Pass input:** to **as arguments**.
5.  Paste the following code:

```bash
# 1. Ask for project name
PROJECT_NAME=$(osascript -e 'tell app "System Events" to display dialog "Project Name:" default answer "" with title "New Antigravity Project"' -e 'text returned of result')
if [ -z "$PROJECT_NAME" ]; then exit 0; fi

# 2. Ask for Repository URL (Optional)
REPO_URL=$(osascript -e 'tell app "System Events" to display dialog "Git Repo URL (leave empty for clean slate):" default answer "" with title "Git Clone"' -e 'text returned of result')

TEMPLATE_PATH="/path/to/your/Agent_template"
DEST_PATH="/path/to/your/projects_folder/$PROJECT_NAME"

# 3. Create or Clone
if [ -n "$REPO_URL" ]; then
    git clone "$REPO_URL" "$DEST_PATH"
else
    mkdir -p "$DEST_PATH"
fi

# 4. Inject Template
cp -R "$TEMPLATE_PATH/." "$DEST_PATH/"

# 5. Cleanup Git History (if clean slate)
if [ -z "$REPO_URL" ]; then
    cd "$DEST_PATH" && rm -rf .git && git init
fi

# 6. Open in Antigravity
open -a "/Applications/Antigravity.app" "$DEST_PATH"
```

6.  Save it as `newproject` in your `/Applications` folder.
7.  **Usage:** Press `Cmd + Space`, type `newproject`, and follow the prompts.

---

### 2. Terminal Injection (`ati` alias)
Use this when you've already opened a project in Antigravity (e.g., after a manual `git clone`) and want to quickly add the template's rules and structure.

**Step-by-step Setup:**
1.  Open your Terminal (or the terminal inside Antigravity).
2.  Type `nano ~/.zshrc` and press Enter.
3.  Scroll to the bottom and add this line:
    ```bash
    alias ati="bash /path/to/your/Agent_template/inject.sh"
    ```
4.  Press `Ctrl + O`, then `Enter` to save.
5.  Press `Ctrl + X` to exit.
6.  Type `source ~/.zshrc` to activate the command.

**Usage:**
In any project folder, simply type:
```bash
ati
```
This will copy all template files and automatically update your `.gitignore` to keep agent files private.

---

## 📂 System Architecture

### 1. The Brain (`.agent/`)
*   **`rules/`**: Immutable laws for the AI Agent (Persona, Safety, Tech Stack).
*   **`workflows/`**: Automated tasks like `/deploy` or `/test-and-fix`.

### 2. The Plan (`roadmap/` & `user_tasks.md`)
*   **`roadmap/`**: Strategic milestones. Focuses on "What" and "Why", not code.
*   **`user_tasks.md`**: Tasks for the Human (e.g., "Add API Keys to .env").

### 3. The Knowledge Base (`docs/`)
*   The Single Source of Truth. Always kept updated via `@agent /update-docs`.

---

## ⚡️ Day-to-Day Commands

| Command | Action |
| :--- | :--- |
| **`ati`** | Inject template rules into current folder. |
| **`/test-and-fix`** | Auto-fix lints and run tests. |
| **`/update-docs`** | Sync code changes with documentation. |
| **`/check-ui`** | Verify UI consistency and responsiveness. |

---

## 🔄 Adapting the Template
This structure is stack-agnostic. To adapt it:
1.  Modify `.agent/rules/tech-stack.md` with your new rules.
2.  Update workflows in `.agent/workflows/` to use your specific build/test tools.
3.  Refresh `docs/` to reflect your architecture.

---

**Status:** Ready to Build. 🚀
