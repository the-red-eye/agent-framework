#!/bin/bash
# Show team status
# Usage: ./scripts/team-status.sh [team-id]

FRAMEWORK_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

show_team_status() {
    local TEAM_ID=$1
    local STATE_FILE="$FRAMEWORK_ROOT/teams/$TEAM_ID/state.json"
    local CONFIG_FILE="$FRAMEWORK_ROOT/config/teams/$TEAM_ID.yaml"
    
    if [ ! -f "$STATE_FILE" ]; then
        echo "Team: $TEAM_ID"
        echo "Status: not started"
        echo ""
        return
    fi
    
    STATUS=$(jq -r '.status' "$STATE_FILE")
    STARTED=$(jq -r '.started_at' "$STATE_FILE")
    PM_AGENT=$(jq -r '.pm.agent' "$STATE_FILE")
    PM_MODEL=$(jq -r '.pm.model' "$STATE_FILE")
    PM_STATUS=$(jq -r '.pm.status' "$STATE_FILE")
    
    # Status emoji
    case $STATUS in
        running) STATUS_EMOJI="🟢" ;;
        stopped) STATUS_EMOJI="🔴" ;;
        starting) STATUS_EMOJI="🟡" ;;
        *) STATUS_EMOJI="⚪" ;;
    esac
    
    echo "╔═══════════════════════════════════════════════════════════"
    echo "║ Team: $TEAM_ID"
    echo "╠═══════════════════════════════════════════════════════════"
    echo "║ Status: $STATUS_EMOJI $STATUS"
    echo "║ Started: $STARTED"
    echo "║"
    echo "║ PM: $PM_AGENT ($PM_MODEL) - $PM_STATUS"
    echo "║"
    
    # Show members from config
    if [ -f "$CONFIG_FILE" ] && command -v yq &> /dev/null; then
        echo "║ ROSTER:"
        yq '.roster.members[] | "║   " + .agent + " (" + .role + ") - " + (.model // "default") + " [" + (if .active then "active" else "inactive" end) + "]"' "$CONFIG_FILE"
    fi
    
    echo "╚═══════════════════════════════════════════════════════════"
    echo ""
}

if [ -n "$1" ]; then
    # Show specific team
    show_team_status "$1"
else
    # Show all teams
    echo "📊 Team Status Overview"
    echo ""
    
    for config in "$FRAMEWORK_ROOT/config/teams/"*.yaml; do
        [ -f "$config" ] || continue
        TEAM_ID=$(basename "$config" .yaml)
        [ "$TEAM_ID" = "_template" ] && continue
        show_team_status "$TEAM_ID"
    done
fi
