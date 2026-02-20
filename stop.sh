#!/bin/bash
# Stop all Docker services and clean up

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Stopping Keycloak POC ==="

docker compose down

echo ""
echo "[+] All services stopped."
echo "    Data volume (postgres_data) is preserved."
echo "    To remove data: docker compose down -v"
