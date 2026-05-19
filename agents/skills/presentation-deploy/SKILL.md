---
name: presentation-deploy
description: Skill for publishing presentations, documents, and individual files from the workspace to Cloudflare Pages with automatic subdomain binding. Use when you need to provide a client with a link to a document, MD presentation, or HTML prototype.
---

# Presentation Deploy Skill

This skill allows for quick publication of content (MD, HTML, PDF) on a custom domain via Cloudflare Pages.

## Assistant Workflow

### 1. Preparation (Workdir)
All presentations must be located in the root `presentations/` directory. Each presentation is a separate folder.

### 2. Content Gathering
When requested to publish a file or folder, the Assistant must:
1. Determine a "clean" name for the presentation (this will be the subdomain).
2. Create the folder `presentations/[subdomain]`.
3. Copy the target file as `index.md` (if it's Markdown) or simply copy it as is.
4. **Critical**: Analyze the content of the MD file to find links to images (`static/`, `assets/`, etc.) or other files. Copy them to the presentation folder, maintaining their structure relative to the target file.

### 3. Deployment Automation
Use the deployment script:
`path: .agent/skills/presentation-deploy/scripts/deploy.sh`

**Command:**
```bash
./.agent/skills/presentation-deploy/scripts/deploy.sh [source_path] [subdomain]
```

## `deploy.sh` Script Functions:
- Copies files and resources.
- Adds `index.html` with premium Docsify (Mermaid support, animations, themes).
- Executes `wrangler pages deploy`.
- Binds the subdomain `[subdomain].[CF_ROOT_DOMAIN]` via the Cloudflare API.

## Presentation Content Setup
- **Markdown**: Add images using `![alt](path)`.
- **Downloads**: To force a file download (instead of opening it), use raw HTML:
  `<a href="path/to/file.pdf" download>Download File</a>`.
- **Interactive Prototypes**: If linking to an HTML prototype, use `target="_blank"` to prevent Docsify from intercepting the link:
  `<a href="prototype.html" target="_blank">View Prototype</a>`.
- **Diagrams**: Native support for ` ```mermaid ` blocks in MD.

## Updating Presentations
To update an existing presentation, simply run the deployment script with the **same subdomain name**. The script will:
1. Automatically clean up old files in the deployment folder.
2. Synchronize new files to the existing Cloudflare Pages project.
3. Automatically update the DNS record if needed.

## Environment Variables
The skill expects the following to be configured in the system (`~/.zshrc`):
- `CF_API_TOKEN` - Cloudflare API Token (with Pages and DNS permissions).
- `CF_ACCOUNT_ID` - Your Cloudflare Account ID.
- `CF_ROOT_DOMAIN` - The base domain (e.g., `chornyi.win`).
- `CF_ZONE_ID` - The Zone ID for the root domain (required for automated DNS).
