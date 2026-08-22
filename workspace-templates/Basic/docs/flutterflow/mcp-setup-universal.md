# Universal FlutterFlow AI MCP Setup Guide

This guide explains how to initialize a FlutterFlow AI workspace and configure the Model Context Protocol (MCP) server for any project.

> [!WARNING]
> MCP configuration files may contain `FF_API_KEY`, `FLUTTERFLOW_API_TOKEN`, or other credentials. Never commit a secret-bearing MCP configuration to Git, regardless of which agent created it or where it is located.

---

## 1. Prerequisites

Make sure the `flutterflow_cli` is installed globally:

```bash
# Install globally via Dart Pub
dart pub global activate flutterflow_cli

# Verify installation
flutterflow --version
```

Next, obtain your FlutterFlow API token from [FlutterFlow Account Settings](https://app.flutterflow.io/account) and set it as an environment variable in your terminal:

```bash
# Note: 'flutterflow ai' subcommands (like init, mcp, context-check) use FF_API_KEY
export FF_API_KEY="<your-flutterflow-api-token>"

# Standard export commands use FLUTTERFLOW_API_TOKEN
export FLUTTERFLOW_API_TOKEN="<your-flutterflow-api-token>"
```

---

## 2. Initialize the Workspace

The FlutterFlow AI workspace should be placed in a dedicated, separate folder so it does not conflict with or overwrite your generated Flutter codebase (which typically lives in `src/` or the root folder).

Navigate to your project root folder and run the following command to initialize the workspace directory (e.g., `my-app`):

```bash
flutterflow ai init my-app --project <your-flutterflow-project-id>
```

This will:
1. Create a new directory named `my-app`.
2. Scaffold the declarative FlutterFlow AI workspace files inside `my-app/` (including `.flutterflow/config.yaml`).

---

## 3. Configure the MCP Server

Once the workspace is initialized, you must configure your IDE / Editor to point to the correct workspace path. 

Different agents and IDEs store MCP configuration in different files and locations. Prefer a user-level configuration outside the repository whenever the agent supports it. If the configuration must live inside the workspace, identify its exact path and protect that path before adding credentials.

Common workspace filenames include `.mcp.json`, `mcp.json`, `mcp_config.json`, or an MCP section inside an agent-specific settings file. This list is illustrative, not exhaustive; always use the path required by the selected agent.

### 3.1 Protect the Configuration Before Adding Keys

1. Add the exact workspace-relative config path to the project `.gitignore`. The base workspace template already ignores common standalone MCP filenames, but an agent may use another location.
2. Verify that Git ignores the exact path:

```bash
MCP_CONFIG_PATH="<workspace-relative-path-to-the-agent-config>"
git check-ignore -v -- "$MCP_CONFIG_PATH"
```

The command must print the matching ignore rule. No output means the file is not protected and credentials must not be added yet.

3. Verify that the file is not already tracked:

```bash
git ls-files --error-unmatch "$MCP_CONFIG_PATH"
```

The expected result is an error stating that the path is not tracked. If the command prints the path, stop: remove the file from Git tracking before using it for secrets. If a real token was ever committed, rotate it immediately; adding the file to `.gitignore` does not remove secrets from Git history.

4. After configuring the agent, run:

```bash
git status --short --ignored
```

Confirm that the secret-bearing config appears only as ignored (`!!`) and never as staged, modified, or untracked content.

5. Commit only sanitized examples such as `mcp.example.json`. Example files must contain placeholders and must never contain working keys, tokens, absolute user paths, or private project identifiers.

> [!IMPORTANT]
> Do not assume that environment-variable syntax such as `${FF_API_KEY}` is supported inside every MCP config format. Use it only when the selected agent documents environment expansion. Otherwise, keep the real value in a verified ignored local config or in a user-level config outside the repository.

### 3.2 Add the FlutterFlow MCP Definition

Create or update the selected agent's protected local MCP config with the following definition:

```json
{
  "mcpServers": {
    "flutterflow": {
      "command": "flutterflow",
      "args": [
        "ai",
        "mcp",
        "--workspace",
        "<absolute-path-to-your-project-root>/my-app"
      ],
      "env": {
        "FLUTTERFLOW_API_TOKEN": "<your-flutterflow-api-token>",
        "FF_API_KEY": "<your-flutterflow-api-token>"
      }
    }
  }
}
```

> [!NOTE]
> Make sure to replace `<absolute-path-to-your-project-root>` with the actual absolute path to your project folder (e.g., `/Users/username/Projects/my-project`).

---

## 4. Run/Test the MCP Server

You can test if the MCP server is working by launching it manually after exporting `FF_API_KEY` in the current terminal session:

```bash
flutterflow ai mcp --workspace "<absolute-path-to-your-project-root>/my-app"
```

If the command starts up without errors and waits for input (interactive stdin/stdout communication), the setup is complete and ready to use with your AI coding assistant!
