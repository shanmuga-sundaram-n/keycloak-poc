#!/bin/bash
# One-time setup: creates .env and installs frontend dependencies

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Keycloak POC Setup ==="

# Create .env from example if it doesn't exist
if [ ! -f .env ]; then
    cp .env.example .env
    echo "[+] Created .env from .env.example"
    echo "    IMPORTANT: Edit .env to set your own passwords before running in production."
else
    echo "[~] .env already exists, skipping"
fi

# Install frontend dependencies
echo "[*] Installing frontend dependencies..."
cd frontend
npm install
cd ..

echo ""
echo "=== Setup complete ==="
echo "Run ./start-docker.sh for Docker mode (all-in-one)"
echo "Run ./start-local.sh  for local dev mode (requires Keycloak running separately)"
