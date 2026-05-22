---
description: Stack-specific rules for FlutterFlow, Firebase, and Custom Dart. Enable after choosing this stack; delete stack-nextjs.md and unused folders.
---

# FlutterFlow & Firebase Stack Instructions

Apply these rules **in addition to** [meta-rules.md](./meta-rules.md). Remove this file if the project does not use this stack.

---

## Platform Context

This project uses **FlutterFlow + Firebase**. There is **NO** native Flutter scaffolding in the workspace root (no `main.dart`, no standard root `pubspec.yaml` layout).

Product context: read **`agent.md`** files throughout the project (`README.md` is for humans).

---

## Tech Stack

* **Frontend:** FlutterFlow visual development
* **Backend:** Firebase (Firestore, Auth, Storage, Cloud Messaging)
* **Custom Code:** Dart in `custom_code/` (actions, functions, widgets)
* **Serverless:** Node.js in `cloud_functions/` (prefer **gen2** unless specified)

---

## Core Development Rules

* **Custom Dart:** All extensions in `custom_code/` — pure logic in `functions/`; side effects in `actions/`.
* **HTML Prototypes First:** UI changes start as high-fidelity HTML/CSS in `prototypes/`, following `docs/design/design-system.md` tokens.
* **Documentation:** Keep all specs under `docs/` subfolders — no clutter elsewhere.

---

## Stack-Specific Rules

* **Dart Purity:** `custom_code/functions/` — pure only; no DB, navigation, or side effects.
* **FF Actions:** DB transactions, push, API calls → `custom_code/actions/`.
* **Custom Widgets:** Only when FlutterFlow widgets are insufficient; document params in local `agent.md`.
* **Cloud Functions:** Default to **gen2** unless explicitly gen1.

---

## Safety & Security

* **Firestore:** Comprehensive Security Rules on all collections and subcollections.
* **Secrets:** Never commit API keys or Firebase service accounts — use env vars or Firebase Secrets Manager.

---

## Communication

* Use Firebase terminology: References, Subcollections, Maps.
* Reference `docs/` when making changes; propose architecture before large execution.

---

## File Tree Listings

* Sort directories alphabetically first, then files alphabetically.
* Use `├──` and `└──` tree characters.

---

## Root `agent.md` — Fill Section 2 With

```markdown
* **Frontend:** FlutterFlow
* **Backend:** Firebase (Firestore, Auth, Storage, FCM)
* **Custom Code:** `custom_code/` (actions, functions, widgets)
* **Cloud Functions:** `cloud_functions/`
```

* **Security:** Strict Firestore rules; optimized indexes and subcollections.

---

## After Setup — Delete If Not Using This Stack

* `docs/database/01_connection.md`, SQL schema files (if any), `docs/prompts/`
* Next.js workflows: `deploy.md`, `check-ui.md`, `test-and-fix.md` (keep `update-docs.md` if useful)
* `.agents/rules/stack-nextjs.md`
