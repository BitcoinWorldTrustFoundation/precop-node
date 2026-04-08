#!/bin/bash
# 🛰️ UNIVERSAL IGNITION SCRIPT - PRECOP PIONEER RC (v6640)

# 🚀 CLEANING PREVIOUS INSTANCE (Exorcism)
echo "🛡️ Releasing database locks..."
pkill -f "precop-node" || true
sleep 2

# Determining project root dynamically
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Standardized Relative Paths
BINARY="$PROJECT_ROOT/bin/precop-node"
CONFIG="$PROJECT_ROOT/node-config/floresta.toml"
DATA_DIR="$PROJECT_ROOT/data"

# Check if binary exists
if [ ! -f "$BINARY" ]; then
    echo "🚨 ERROR: Binary not found in $PROJECT_ROOT/bin/"
    echo "💡 Please place the 'precop-node' binary in the bin/ folder."
    exit 1
fi

# 🗡️ Cleanup
pkill -9 florestad || true
pkill -9 precop-node || true

echo "🏹 AWAKENING SOVEREIGN SENTINEL (PORTABLE MODE)..."
echo "🛡️ PROJECT ROOT: $PROJECT_ROOT"
echo "📡 DATA DIR: $DATA_DIR"

# 🚀 Ignition
chmod +x "$BINARY"
echo "🚀 Ignition globalisée via floresta.toml..."
# On force les adresses [::] via CLI pour garantir le mode Sentinel public (Dual-Stack).
# Note: On utilise des guillemets pour éviter que le shell n'interprète les crochets.
nohup "$BINARY" -c "$CONFIG" --data-dir "$DATA_DIR" --rpc-address "[::]:8332" --electrum-address "[::]:50001" -d > "$PROJECT_ROOT/node.log" 2>&1 &

echo "⏳ Awakening the Sentinel deep-state (30s cooldown)..."
sleep 5
if pgrep -f "precop-node" > /dev/null; then
    echo "✅ Sentinel is breathing. Initializing the Swarm handshake..."
    echo "✨ Logs available at $PROJECT_ROOT/node.log"
else
    echo "🚨 ERROR: Sentinel failed to ignite. Check $PROJECT_ROOT/node.log for details."
fi
