#!/bin/bash
# Start a team
# Usage: ./scripts/team-up.sh <team-id>

set -e

TEAM_ID=$1
FRAMEWORK_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG_FILE="$FRAMEWORK_ROOT/config/teams/$TEAM_ID.yaml"
STATE_DIR="$FRAMEWORK_ROOT/teams/$TEAM_ID"

if [ -z "$TEAM_ID" ]; then
    echo "Usage: $0 <team-id>"
    echo "Available teams:"
    ls -1 "$FRAMEWORK_ROOT/config/teams/" | grep -v _template | sed 's/.yaml$//'
    exit 1
fi

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Team config not found: $CONFIG_FILE"
    exit 1
fi

echo "🚀 Starting team: $TEAM_ID"

# Create state directory
mkdir -p "$STATE_DIR"
mkdir -p "$STATE_DIR/logs"

# Parse config (requires yq - https://github.com/mikefarah/yq)
if ! command -v yq &> /dev/null; then
    echo "Error: yq is required. Install with: brew install yq"
    exit 1
fi

TEAM_NAME=$(yq '.team.name' "$CONFIG_FILE")
PM_AGENT=$(yq '.roster.pm.agent' "$CONFIG_FILE")
PM_MODEL=$(yq '.roster.pm.model // "gemini-pro"' "$CONFIG_FILE")

echo "📋 Team: $TEAM_NAME"
echo "👔 PM: $PM_AGENT (model: $PM_MODEL)"

# Check if already running
if [ -f "$STATE_DIR/state.json" ]; then
    STATUS=$(jq -r '.status' "$STATE_DIR/state.json" 2>/dev/null || echo "unknown")
    if [ "$STATUS" = "running" ]; then
        echo "⚠️  Team already running. Use team-down.sh first."
        exit 1
    fi
fi

# Create initial state
cat > "$STATE_DIR/state.json" << EOF
{
    "team_id": "$TEAM_ID",
    "status": "starting",
    "started_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "pm": {
        "agent": "$PM_AGENT",
        "model": "$PM_MODEL",
        "status": "starting"
    },
    "members": []
}
EOF

echo "📝 State initialized"

# TODO: Actually start the PM container/process
# This would integrate with docker-compose or openclaw directly
echo ""
echo "⚠️  Container orchestration not yet implemented."
echo "   Manual steps required:"
echo "   1. Start PM agent: openclaw gateway start --config agents/pool/$PM_AGENT/"
echo "   2. PM will spawn team members automatically"
echo ""

# Update state
jq '.status = "running" | .pm.status = "pending_manual"' "$STATE_DIR/state.json" > "$STATE_DIR/state.json.tmp"
mv "$STATE_DIR/state.json.tmp" "$STATE_DIR/state.json"

echo "✅ Team $TEAM_ID initialized"
echo "   State: $STATE_DIR/state.json"
echo "   Logs:  $STATE_DIR/logs/"
