# ERP Deploy Repository

This is the **deploy** repository. It contains only Docker Compose orchestration,
deployment scripts, and environment variable templates.

> **Governance is external.**
> All AI skills, coding standards, architecture rules, and execution protocols
> live in the `governance-repo` repository. Do NOT recreate them here.

---

## External Dependency

This repository depends on **governance-repo**.

Before modifying any deployment configuration:

1. Confirm `governance-repo` is available in the workspace (see layout below).
2. Read `governance-repo/CLAUDE.md` — it is the canonical AI governance document.
3. Load the DevOps skill from `governance-repo/.github/skills/devops/deploy/SKILL.md`.

If `governance-repo` is missing:
- Stop implementation.
- Explain the missing dependency.
- Never recreate governance artifacts locally.
- Never duplicate governance files.

---

## Workspace Layout

This repository is one of four sibling repositories that form the ERP platform:

```
workspace/
  backend/          ← Java / Spring Boot source code
  frontend/         ← Angular source code
  deploy/           ← this repository — orchestration and deployment
  governance-repo/  ← AI governance, skills, context, commands
```

The repositories are independent — there is no monorepo root above them.
Each of `backend/` and `frontend/` contains its own `Dockerfile`.
This repository only provides `docker-compose.yml` and `deploy.sh`.

---

## Where to Find Governance

| Governance artifact | Location |
|---------------------|----------|
| DevOps / deploy skill | `governance-repo/.github/skills/devops/deploy/SKILL.md` |
| Task routing table | `governance-repo/CLAUDE.md` |

---

## Repository Structure

```
docker-compose.yml     ← Production orchestration (builds from sibling repos)
deploy.sh              ← Git pull → build → restart script
.env.example           ← Environment variable template
.env                   ← Live secrets (never committed)
README.md              ← Deployment runbook
```

---

## Key Configuration

- Backend image builds from context: `../backend` (Dockerfile at `backend/Dockerfile`)
- Frontend image builds from context: `../frontend` (Dockerfile at `frontend/Dockerfile`)
- Both sibling repositories must be cloned at the same level as this repository

---

## Running a Deployment

```bash
# Copy environment template
cp .env.example .env
# Edit .env with production values

# Full build and start
docker compose up -d --build

# Or use the deployment script (pulls latest from each repo first)
bash deploy.sh
```
