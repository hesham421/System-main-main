# ERP Deploy — GitHub Copilot Instructions

This is the **deploy** repository. It contains only Docker Compose orchestration
and deployment scripts.

## Governance Dependency

All AI skills, coding standards, and deployment architecture rules are defined
in the **governance-repo** repository.

**Before modifying deployment configuration:**
1. Confirm `governance-repo` is available in the workspace.
2. Read `governance-repo/.github/copilot-instructions.md`.
3. Load the deploy skill from `governance-repo/.github/skills/devops/deploy/SKILL.md`.

If `governance-repo` is not available: **stop and report the missing dependency.**

## This Repository

```
docker-compose.yml   ← Production orchestration
deploy.sh            ← Git pull → build → restart
.env.example         ← Environment variable template
.env                 ← Live secrets (never committed)
README.md            ← Deployment runbook
```

## Key Architecture Rules

- Backend image: `context: ../backend`, `dockerfile: Dockerfile`
- Frontend image: `context: ../frontend`, `dockerfile: Dockerfile`
- Backend runs with `network_mode: host`
- All API calls proxied through Nginx `/api` — no direct backend access
- Deployment is Git pull-based, not image push-based
