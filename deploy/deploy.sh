#!/bin/bash
set -euo pipefail

DEPLOY_DIR="$(cd "$(dirname "$0")" && pwd)"
# Repositories are expected as siblings: backend/, frontend/, deploy/ under the same parent.
PARENT_DIR="$(cd "$DEPLOY_DIR/.." && pwd)"

echo "=========================================="
echo " ERP System - Deploying"
echo "=========================================="

echo "[1/3] Pulling latest code..."
# Pull each split repository independently
for repo in backend frontend deploy; do
  REPO_PATH="$PARENT_DIR/$repo"
  if [ -d "$REPO_PATH/.git" ]; then
    echo "  Pulling $repo..."
    cd "$REPO_PATH"
    git pull origin main
  fi
done
cd "$DEPLOY_DIR"

echo "[2/3] Rebuilding containers..."
docker compose down
docker compose --env-file .env up -d --build

echo "[3/3] Verifying deployment..."

echo "Waiting for backend to be healthy..."

for i in {1..10}; do
  if wget --spider -q http://localhost:7272/actuator/health; then
    echo "Backend is healthy"
    break
  fi
  echo "Waiting... ($i)"
  sleep 5
done

echo "=========================================="
echo " Deployment complete"
echo "=========================================="