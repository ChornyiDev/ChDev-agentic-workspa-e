---
name: presentation-deploy
description: Skill for publishing presentations, documents, and individual files from the workspace to Cloudflare Pages (pages.dev). Use when you need to provide a client with a link to a document, MD presentation, or HTML prototype.
---

# Presentation Deploy Skill

This skill allows for quick publication of content (MD, HTML, PDF) directly to Cloudflare Pages (`https://[subdomain].pages.dev`).

## Assistant Workflow

### 1. Preparation (Workdir)
All presentations are prepared in `presentations/[subdomain]`.

### 2. Content Gathering
When requested to publish a file or folder:
1. Determine a clean, lowercase name for the presentation (e.g., `bits-nutrition`).
2. Run the deployment script with the source file and target project name.

### 3. Deployment Automation
Use the deployment script:
`path: .agents/skills/presentation-deploy/scripts/deploy.sh`

**Command:**
```bash
./.agents/skills/presentation-deploy/scripts/deploy.sh [source_path] [subdomain]
```

## `deploy.sh` Script Functions:
- Copies files and local linked media resources.
- Adds `index.html` with premium Docsify (Mermaid support, responsive theme).
- Ensures project existence via `npx wrangler pages project create`.
- Deploys via `npx wrangler pages deploy` using active Wrangler OAuth session.
- Outputs direct public URL: `https://[subdomain].pages.dev`.

## Presentation Content Setup
- **Markdown**: Add images using `![alt](path)`.
- **Downloads**: To force a file download (instead of opening it), use raw HTML:
  `<a href="path/to/file.pdf" download>Download File</a>`.
- **Interactive Prototypes**: If linking to an HTML prototype, use `target="_blank"` to prevent Docsify from intercepting the link:
  `<a href="prototype.html" target="_blank">View Prototype</a>`.
- **Diagrams**: Native support for ` ```mermaid ` blocks in Markdown.

## Updating Presentations
To update an existing presentation, simply re-run the deployment script with the same subdomain name. The script will synchronize updated assets immediately.

## Authentication
Authentication is handled natively by Wrangler OAuth (`npx wrangler login`). No API tokens or manual DNS configuration are required.

