# 🗄️ Database Schemas & Connection | `docs/database/`

---

## 🎯 Purpose
Maintains the relational schema definitions, database integrations, connection policies, and security policies (Row Level Security) for the Neon serverless database.

---

## 📂 Core Requirements
1. **Schema Specifications:** Ensure that `001_schema_simple.sql` (AI-optimized reference) and `001_schema_full.sql` (production-grade master SQL script) are kept perfectly in sync with the database schema state at all times.
2. **Security Compliance:** Row Level Security (RLS) policies must be fully defined for all tables and logged in the full schema file.
