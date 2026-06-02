# Universal FlutterFlow AI MCP Setup Guide

This guide explains how to initialize a FlutterFlow AI workspace and configure the Model Context Protocol (MCP) server for any project.

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

Create or update your `.agent/mcp_config.json` (or your IDE's global/workspace MCP settings) with the following configuration:

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
        "FLUTTERFLOW_API_TOKEN": "<your-flutterflow-api-token>"
      }
    }
  }
}
```

> [!NOTE]
> Make sure to replace `<absolute-path-to-your-project-root>` with the actual absolute path to your project folder (e.g., `/Users/username/Projects/my-project`).

---

## 4. Run/Test the MCP Server

You can test if the MCP server is working by launching it manually from your terminal:

```bash
FLUTTERFLOW_API_TOKEN="<your-flutterflow-api-token>" flutterflow ai mcp --workspace "<absolute-path-to-your-project-root>/my-app"
```

If the command starts up without errors and waits for input (interactive stdin/stdout communication), the setup is complete and ready to use with your AI coding assistant!
