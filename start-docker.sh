#!/bin/bash
# Start all services via Docker Compose (PostgreSQL + Keycloak + Backend + Frontend)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Starting Keycloak POC (Docker Mode) ==="

# Check .env exists
if [ ! -f .env ]; then
    echo "[!] .env file not found. Run ./setup.sh first."
    exit 1
fi

# Build and start all services
echo "[*] Building and starting all services..."
docker compose up --build -d

echo ""
echo "[*] Waiting for services to become healthy..."
echo "    This may take 30-60 seconds on first run."
echo ""

# Wait for Keycloak to be ready
echo -n "    Keycloak: "
timeout=120
elapsed=0
while [ $elapsed -lt $timeout ]; do
    if docker compose exec -T keycloak bash -c "exec 3<>/dev/tcp/localhost/8080" 2>/dev/null; then
        echo "READY"
        break
    fi
    echo -n "."
    sleep 5
    elapsed=$((elapsed + 5))
done
if [ $elapsed -ge $timeout ]; then
    echo "TIMEOUT (check: docker compose logs keycloak)"
fi

# Check backend
echo -n "    Backend:  "
timeout=60
elapsed=0
while [ $elapsed -lt $timeout ]; do
    if curl -sf http://localhost:8081/api/public/health > /dev/null 2>&1; then
        echo "READY"
        break
    fi
    echo -n "."
    sleep 3
    elapsed=$((elapsed + 3))
done
if [ $elapsed -ge $timeout ]; then
    echo "TIMEOUT (check: docker compose logs backend)"
fi

# Check frontend
echo -n "    Frontend: "
if curl -sf http://localhost:3000 > /dev/null 2>&1; then
    echo "READY"
else
    echo "STARTING (may take a moment)"
fi

echo ""
echo "=== Services ==="
echo "  Frontend:       http://localhost:3000"
echo "  Backend API:    http://localhost:8081/api/public/health"
echo "  Keycloak Admin: http://localhost:8080 (credentials in .env)"
echo ""
echo "=== Test Accounts ==="
echo "  testuser    / testuser123    (USER role)"
echo "  testadmin   / testadmin123   (USER + ADMIN roles)"
echo "  testsupport / testsupport123 (USER + SUPPORT roles)"
echo ""
echo "To stop: ./stop.sh"
