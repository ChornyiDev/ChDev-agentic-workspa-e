# 📘 Product & Technical Documentation Hub

This directory serves as the **Single Source of Truth (SSOT)** for all product specifications, architecture, Neon database schemas, Tailwind CSS styling tokens, and API integrations of the project.

---

## 📂 Documentation Directory Map

```text
docs/
├── database/ ............. Neon Postgres schemas, connection parameters, and RLS policies
├── design/ ............... Tailwind CSS design tokens, visual elements, and CSS variables
├── features/ ............. Functional specifications and API routing endpoints
├── integrations/ ......... Stripe payment processing and API authentication protocols
├── project/ .............. High-level architecture, user journeys, and core project overviews
└── tech-stack/ ........... React 19 rules, Next.js App Router guidelines, and package whitelist
```

---

## 🛠️ Directory Breakdown

### 1. 🗄️ [database/](file://./database/)
* Neon Postgres serverless integration guidelines.
* Contains `001_schema_simple.sql` (AI-optimized flat reference) and `001_schema_full.sql` (complete constraints & RLS).
* Active database migrations and connection strategies.

### 2. 🎨 [design/](file://./design/)
* Tailwind CSS theme configuration and styling rules.
* Premium typography parameters (e.g., Outfit, Inter) and glassmorphism standards.

### 3. ⚙️ [features/](file://./features/)
* Server Actions definitions, routing layouts, and endpoints specifications.
* Interactive flow charts and UI/UX state rules.

### 4. 🔌 [integrations/](file://./integrations/)
* Stripe payment configurations (webhook handlers and client flows).
* Stack Auth credential configurations.

### 5. 🗺️ [project/](file://./project/)
* Component hierarchies, state maps, and production deployments.

### 6. 🛠️ [tech-stack/](file://./tech-stack/)
* React 19 hooks standards (e.g., standardizing `use()` hook and async actions).
* Whitelisted npm packages and strict local development setup checklists.