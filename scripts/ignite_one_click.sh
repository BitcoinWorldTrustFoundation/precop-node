#!/bin/bash
# 👸 SOVEREIGN ONE-CLICK IGNITION v1.1.0
# The ultimate entry point for the Precop Sentinel.

# 🏹 1. IDENTIFY THE WORLD
OS_TYPE=$(uname -s)
HW_TYPE=$(uname -m)
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="$PROJECT_ROOT/bin"
REPO_URL="https://github.com/BitcoinWorldTrustFoundation/precop-node"
RELEASE_TAG="v1.0.3"

mkdir -p "$BIN_DIR"

echo "🏹 AWAKENING SOVEREIGN SENTINEL (ONE-CLICK MODE)..."

# 🛰️ 2. FETCH THE BLADE (Download binary)
case "$OS_TYPE" in
    Linux)
        echo "🐧 Linux detected ($HW_TYPE). Fetching Universal Linux Sentinel..."
        BINARY_NAME="precop-node-linux-x86_64"
        [[ "$HW_TYPE" == "aarch64" ]] && BINARY_NAME="precop-node-linux-arm64"
        LOCAL_BINARY="$BIN_DIR/precop-node"
        ;;
    Darwin)
        echo "🍎 MacOS detected ($HW_TYPE). Fetching Apple Sentinel..."
        BINARY_NAME="precop-node-macos-x86_64"
        [[ "$HW_TYPE" == "arm64" ]] && BINARY_NAME="precop-node-macos-arm64"
        LOCAL_BINARY="$BIN_DIR/precop-node"
        ;;
    MINGW*|CYGWIN*|MSYS*)
        echo "🪟 Windows detected. Fetching Windows Sentinel..."
        BINARY_NAME="precop-node-windows.exe"
        LOCAL_BINARY="$BIN_DIR/precop-node.exe"
        ;;
    *)
        echo "🚨 Unsupported OS: $OS_TYPE"
        exit 1
        ;;
esac

if [ ! -f "$LOCAL_BINARY" ]; then
    DOWNLOAD_URL="$REPO_URL/releases/download/$RELEASE_TAG/$BINARY_NAME"
    echo "📥 Downloading binary from $DOWNLOAD_URL..."
    curl -L "$DOWNLOAD_URL" -o "$LOCAL_BINARY"
    chmod +x "$LOCAL_BINARY"
else
    echo "✅ Binary already present in $LOCAL_BINARY."
fi

# 🏗️ 3. FORGE THE FULL-STACK (L2 & Dashboard)
echo "🏗️  FORGING FULL-STACK REAPER ENGINE..."

# --- 🟢 NODE.JS & NPM CHECK ---
if ! command -v npm &> /dev/null; then
    echo "⚠️  WARNING: Node.js/NPM not found. Skip L2/Dashboard setup."
else
    echo "✅ Node.js detected. Synchronizing modules..."
    
    # 1. PRECOP-INDEXER
    if [ -d "$PROJECT_ROOT/../precop-indexer" ]; then
        echo "📦 Preparing Indexer..."
        (cd "$PROJECT_ROOT/../precop-indexer" && npm install --silent && npx prisma db push --accept-data-loss --silent && npx prisma generate --silent)
        echo "✅ Indexer Alchemy Complete."
    fi

    # 2. PRECOP-DASHBOARD
    if [ -d "$PROJECT_ROOT/../precop-dashboard" ]; then
        echo "📦 Preparing Dashboard..."
        (cd "$PROJECT_ROOT/../precop-dashboard" && npm install --silent && npx prisma generate --silent)
        echo "✅ Dashboard Alchemy Complete."
    fi
fi

# --- 🔵 DATABASE CHECK ---
if ! command -v psql &> /dev/null; then
    echo "⚠️  WARNING: PostgreSQL 'psql' not found. Ensure Postgres is installed for the Indexer."
else
    echo "✅ PostgreSQL tools detected."
fi

# 🏗️ 4. BASTION SETUP (Sentinel Logic)
echo "🏗️  Running Sentinel setup..."
bash "$PROJECT_ROOT/scripts/setup_bastion.sh"

# 🚀 5. FINAL IGNITION (L1)
echo "🚀 Igniting Precop Sentinel..."
bash "$PROJECT_ROOT/scripts/ignite_precop.sh"

echo "✨ FULL-STACK SUCCESSFUL. MISSION ACCOMPLISHED."
echo "📜 Watch logs with: tail -f node.log"
