# ERP Governance Repository

This is the **single source of truth** for all AI governance across the ERP platform.

All AI skills, coding standards, architecture rules, context documents, commands, and
execution protocols live here. No other repository may duplicate or redefine them.

> **Other repositories reference this one — they do not own governance.**
> `backend/CLAUDE.md`, `frontend/CLAUDE.md`, and `deploy/CLAUDE.md` contain only
> repository-local documentation and a pointer back to this file.

---

## Workspace Layout

This governance repository is one of four sibling repositories:

```
workspace/
  backend/          ← Java / Spring Boot source code
  frontend/         ← Angular source code
  deploy/           ← Docker Compose orchestration and deployment scripts
  governance-repo/  ← this repository — AI governance, skills, context, commands
```

The repositories are independent — there is no monorepo root above them.

---

## Governance Content Map

| Artifact | Path in this repository |
|----------|------------------------|
| Backend skills | `.github/skills/backend/` |
| Frontend skills | `.github/skills/frontend/` |
| DevOps / deploy skill | `.github/skills/devops/deploy/` |
| Backend architecture context | `.github/context/backend.md` |
| Frontend architecture context | `.github/context/frontend.md` |
| Master entity registry | `master-registry.md` |
| Modules registry | `modules-registry.json` |
| AI commands | `.claude/commands/` |
| Governance automation tools | `governance-tools/` |
| Module execution plans | `modules/` |

---

## Task → Skill Routing

Read the matching skill BEFORE generating or modifying any code.

### Backend (code lives in `backend` repo)

| Task | Skill |
|------|-------|
| **Always first — contract validation** | `enforce-backend-contract` |
| Create / modify Entity | `create-entity` |
| Create / modify Repository | `create-repository` |
| Create / modify DTOs | `create-dto` |
| Create / modify Mapper | `create-mapper` |
| Create / modify Service | `create-service` |
| Create / modify Controller | `create-controller` |
| Review / validate backend code | `enforce-backend-contract` |
| Add / review caching | `enforce-caching-rules` |
| Add / review error handling | `enforce-error-handling` |
| Validate a complete feature | `validate-backend-feature` |

### Frontend (code lives in `frontend` repo)

> ERP rules always take precedence over Angular/skills guidance.

| Task | Skill |
|------|-------|
| Create / modify models / DTOs / FormMapper | `create-models` |
| Create / modify API service | `create-api-service` |
| Create / modify Facade | `create-facade` |
| Create / modify Routing | `create-routing` |
| Create / modify Components | `create-components` |
| Review frontend architecture | `enforce-frontend-architecture` |
| Review UI/UX & data display | `enforce-ui-ux` |
| Review design system & CSS | `enforce-design-system` |
| Review code reusability | `enforce-reusability` |
| Review permissions | `enforce-permissions` |
| Review state management | `enforce-state-management` |
| Validate a complete feature | `validate-frontend-feature` |

### DevOps (infrastructure lives in `deploy` repo)

| Task | Skill |
|------|-------|
| Dockerfiles / docker-compose / nginx / deployment | `deploy` |

---

## Execution Order

**Backend (strict):**
`enforce-backend-contract` → `create-entity` → `create-repository` → `create-dto` → `create-mapper` → `create-service` → `create-controller` → `validate-backend-feature`

**Frontend (strict):**
`create-models` → `create-api-service` → `create-facade` → `create-routing` → `create-components` → `validate-frontend-feature`

---

## Governance Rules

- NEVER generate backend code without first reading the corresponding skill
- NEVER generate frontend code without first reading the corresponding skill
- When a task spans multiple layers, read ALL relevant skills
- After completing a feature, run the validation skill to verify compliance
- Reference existing implementations in the codebase as canonical examples
- `master-registry.md` is the single source of truth for all entities and rules

---

## Context Reference (read on demand)

- Backend architecture overview: `.github/context/backend.md`
- Frontend architecture overview + navigation i18n keys: `.github/context/frontend.md`
- All detailed rules live in `.github/skills/`

---

## Phase Execution Protocol

> Applies when executing a governance phase from the execution plan.
> This section governs HOW to execute — the skill routing table above governs WHAT to use.

### Entry — before writing any code in a phase

1. Read `modules/[MODULE]/execution-state.json`
2. Confirm the requested phase matches `current_phase` in state
3. Read the phase index file: `modules/[MODULE]/packages/execution/[PHASE]/index.md`
4. Identify all subs inside the phase (in order)
5. For each sub, read its file completely before executing it

### Execution — per sub

1. Read sub file completely
2. Identify all tasks in the sub
3. Map each task to the skill routing table above
4. Read required skills from `.github/skills/`
5. Execute all tasks in order
6. Run `validate-backend-feature` or `validate-frontend-feature` after last task
7. Mark sub as COMPLETE in `modules/[MODULE]/execution-state.json`

### Blocked items — OQ / XM DEFERRED

- OQ-blocked task → skip, add to `execution-state.json` blocked list
  Mark in code: `// TODO: OQ-[ID] — pending resolution`
- XM DEFERRED → implement mock strategy
  Mark in code: `// TODO: XM-[MOD]-[N] DEFERRED — replace when READY`
- Continue remaining tasks — never stop the phase for a blocked item

### Exit — after all subs in phase complete

1. Mark phase as COMPLETE in `modules/[MODULE]/execution-state.json`
2. Set `current_phase` to next PENDING phase
3. Print execution report:
   ```
   PHASE [NAME] COMPLETE
   ─────────────────────────────
   Subs executed : [list]
   Blocked       : [OQ-IDs / none]
   XM Deferred   : [XM-IDs / none]
   Next phase    : [name] — awaiting your instruction
   ```

### Constraints (NON-NEGOTIABLE)

- NEVER skip a sub within a phase
- NEVER invent field or column names — always look up db-script.md
- NEVER copy QRC entries as production code — read intent, write implementation
- NEVER implement a blocked OQ item — mark and skip only
- NEVER advance to next phase without explicit instruction from user