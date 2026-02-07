#!/bin/bash
# Stop a team
# Usage: ./scripts/team-down.sh <team-id>

set -e

TEAM_ID=$1
FRAMEWORK_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
STATE_DIR="$FRAMEWORK_ROOT/teams/$TEAM_ID"

if [ -z "$TEAM_ID" ]; then
    echo "Usage: $0 <team-id>"
    exit 1
fi

if [ ! -d "$STATE_DIR" ]; then
    echo "Error: Team not found or not started: $TEAM_ID"
    exit 1
fi

echo "🛑 Stopping team: $TEAM_ID"

# TODO: Actually stop containers/processes
echo ""
echo "⚠️  Container orchestration not yet implemented."
echo "   Manual steps required:"
echo "   1. Stop any running agent processes"
echo "   2. Stop PM container if using Docker"
echo ""

# Update state
if [ -f "$STATE_DIR/state.json" ]; then
    jq '.status = "stopped" | .stopped_at = "'"$(date -u +"%Y-%m-%dT%H:%M:%SZ")"'"' \
        "$STATE_DIR/state.json" > "$STATE_DIR/state.json.tmp"
    mv "$STATE_DIR/state.json.tmp" "$STATE_DIR/state.json"
fi

echo "✅ Team $TEAM_ID stopped"
