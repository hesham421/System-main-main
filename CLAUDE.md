# ERP System

## Skills — Read Before Generating Code

All rules live inside the skills. Read the relevant skill FIRST, then generate.

### Backend Skills (`.github/skills/backend/`)
- `/enforce-backend-contract` — ALWAYS read first (77 contract rules)
- `/create-entity` — JPA entity (AuditableEntity, @SuperBuilder, sequences)
- `/create-repository` — JpaRepository + JpaSpecificationExecutor
- `/create-dto` — CreateRequest, UpdateRequest, Response, Search, Usage DTOs
- `/create-mapper` — @Component mapper
- `/create-service` — @Service with CRUD, @PreAuthorize, ServiceResult<T>
- `/create-controller` — thin REST layer, OperationCode.craftResponse()
- `/enforce-error-handling` — LocalizedException + Status compliance
- `/enforce-caching-rules` — caching eligibility + annotation rules
- `/validate-backend-feature` — master validation (77 rules, 139 pts)

### Frontend Skills (`.github/skills/frontend/`)
- `/create-models` — TypeScript DTOs + FormModel + FormMapper
- `/create-api-service` — extends BaseApiService
- `/create-facade` — Signal-based state (private signal, public computed)
- `/create-routing` — lazy routes + authGuard + permissionGuard
- `/create-components` — standalone OnPush components
- `/enforce-frontend-architecture` — 73 checks across 7 layers
- `/enforce-design-system` — CSS tokens, ThemeService, card layout
- `/enforce-reusability` — 42 checks across 9 layers
- `/enforce-ui-ux` — 54 checks across 10 layers
- `/enforce-state-management` — Signal patterns
- `/enforce-permissions` — triple enforcement
- `/validate-frontend-feature` — master validation (120 pts)

### DevOps Skills (`.github/skills/devops/`)
- `/deploy` — Dockerfiles, docker-compose, nginx

## Execution Order

**Backend:** `/enforce-backend-contract` → `/create-entity` → `/create-repository` → `/create-dto` → `/create-mapper` → `/create-service` → `/create-controller` → `/validate-backend-feature`

**Frontend:** `/create-models` → `/create-api-service` → `/create-facade` → `/create-routing` → `/create-components` → `/validate-frontend-feature`

## Deep Architecture Reference (read on demand, not by default)

- Backend rules: `.github/instructions/backend.instructions.md`
- Frontend rules: `.github/instructions/frontend.instructions.md`
- Global skill routing: `.github/copilot-instructions.md`
