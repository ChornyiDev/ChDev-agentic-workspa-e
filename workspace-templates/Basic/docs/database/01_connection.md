# 🔌 Database Connection & Tooling

**Status:** Active
**Database Engine:** PostgreSQL (Default)
**ORM/Driver:** Prisma / Drizzle (Update as selected)

---

## 1. Connection Credentials
**⚠️ SECURITY WARNING:** Never paste actual passwords here.

The application connects to the database using the `DATABASE_URL` environment variable found in `.env.local`.

| Variable | Description | Example Format |
| :--- | :--- | :--- |
| `DATABASE_URL` | Transaction connection pool (Use for App). | `postgres://user:pass@host:5432/db?pgbouncer=true` |
| `DIRECT_URL` | Direct connection (Use for Migrations). | `postgres://user:pass@host:5432/db` |

## 2. Recommended Tools (For Humans)
*Since you are the Project Owner, use these tools to view data manually:*

1.  **TablePlus** (MacOS/Windows) - Recommended for visual management.
2.  **Prisma Studio** - Run `npx prisma studio` to open a web-interface for your data.
3.  **DBeaver** - Free, open-source alternative.

## 3. Connection Troubleshooting
*If the Agent reports connection errors, check these common issues:*

* **"Too many clients":** The connection pool is full. Restart the dev server.
* **"Connection refused":** Check if your IP address is allowed in the cloud provider (Supabase/Neon/AWS) settings.
* **"Schema missing":** Have you run the migration command? (`npx prisma db push` or equivalent).

---

## 🔄 Adaptation for Other Stacks
*If not using PostgreSQL:*

* **Firebase:** Replace credentials section with "Service Account Path" and "Project ID".
* **MongoDB:** Change URL format to `mongodb+srv://...`.
* **SQLite:** Start using a local file path: `file:./dev.db`.