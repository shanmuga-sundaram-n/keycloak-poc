#!/bin/bash
# Start in local dev mode: Keycloak+PostgreSQL in Docker, backend and frontend run natively
# This gives you hot-reload for both backend and frontend development.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Starting Keycloak POC (Local Dev Mode) ==="

# Check .env exists
if [ ! -f .env ]; then
    echo "[!] .env file not found. Run ./setup.sh first."
    exit 1
fi

# Start only PostgreSQL + Keycloak
echo "[*] Starting PostgreSQL + Keycloak..."
docker compose up -d postgres keycloak

echo ""
echo -n "[*] Waiting for Keycloak: "
timeout=120
elapsed=0
while [ $elapsed -lt $timeout ]; do
    if curl -sf http://localhost:8080/health/ready > /dev/null 2>&1; then
        echo "READY"
        break
    fi
    echo -n "."
    sleep 5
    elapsed=$((elapsed + 5))
done
if [ $elapsed -ge $timeout ]; then
    echo "TIMEOUT"
    echo "    Check: docker compose logs keycloak"
    exit 1
fi

# Check frontend dependencies
if [ ! -d frontend/node_modules ]; then
    echo "[!] Frontend dependencies not installed. Run ./setup.sh first."
    exit 1
fi

echo ""
echo "[*] Starting backend (Spring Boot) on port 8081..."
cd backend
./mvnw spring-boot:run -q &
BACKEND_PID=$!
cd ..

echo "[*] Starting frontend (React) on port 3000..."
cd frontend
npm start &
FRONTEND_PID=$!
cd ..

# Trap to clean up on exit
cleanup() {
    echo ""
    echo "[*] Shutting down..."
    kill $BACKEND_PID 2>/dev/null
    kill $FRONTEND_PID 2>/dev/null
    echo "[*] Backend and frontend stopped."
    echo "    To stop Keycloak: ./stop.sh"
}
trap cleanup EXIT INT TERM

echo ""
echo "=== Services ==="
echo "  Frontend:       http://localhost:3000 (hot-reload)"
echo "  Backend API:    http://localhost:8081/api/public/health (restart on recompile)"
echo "  Keycloak Admin: http://localhost:8080"
echo ""
echo "=== Test Accounts ==="
echo "  testuser    / testuser123    (USER role)"
echo "  testadmin   / testadmin123   (USER + ADMIN roles)"
echo "  testsupport / testsupport123 (USER + SUPPORT roles)"
echo ""
echo "Press Ctrl+C to stop backend and frontend."
echo ""

# Wait for both processes
wait
