#!/bin/bash
#
# OpenClaw Diagnostics Script
# Runs on the remote server to collect diagnostic information
#
# Environment Variables:
#   SERVICE - systemd service name (default: openclaw)
#   CONFIG_DIR - configuration directory (default: /root/.openclaw)
#   MEM_WARN - memory warning threshold % (default: 70)
#   MEM_CRIT - memory critical threshold % (default: 80)
#
# Output: JSON formatted diagnostic results
#

set -euo pipefail

# Configuration
SERVICE="${SERVICE:-openclaw}"
CONFIG_DIR="${CONFIG_DIR:-/root/.openclaw}"
MEM_WARN="${MEM_WARN:-70}"
MEM_CRIT="${MEM_CRIT:-80}"
AUTH_FILE="/root/.codex/auth.json"

# Timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Initialize results array
CHECKS='[]'

# Helper function to add a check result
add_check() {
    local name="$1"
    local status="$2"
    local message="$3"
    local severity="$4"
    local details="$5"

    local check=$(cat <<EOF
{
  "name": "$name",
  "status": "$status",
  "message": "$message",
  "severity": $severity,
  "details": $details
}
EOF
)
    CHECKS=$(echo "$CHECKS" | jq ". += [$check]")
}

#
# Check 1: Service Status
#
check_service_status() {
    local state=$(systemctl is-active "$SERVICE" 2>/dev/null || echo "unknown")
    local enabled=$(systemctl is-enabled "$SERVICE" 2>/dev/null || echo "unknown")

    if [ "$state" = "active" ]; then
        local uptime=$(systemctl show "$SERVICE" --property=ActiveEnterTimestamp --value)
        local uptime_sec=$(( $(date +%s) - $(date -d "$uptime" +%s 2>/dev/null || echo 0) ))

        add_check "service_status" "ok" \
            "Service is active and running" \
            "0.0" \
            "{\"state\": \"$state\", \"enabled\": \"$enabled\", \"uptime_sec\": $uptime_sec}"
    elif [ "$state" = "inactive" ]; then
        add_check "service_status" "error" \
            "Service is not running (inactive)" \
            "1.0" \
            "{\"state\": \"$state\", \"enabled\": \"$enabled\"}"
    elif [ "$state" = "failed" ]; then
        add_check "service_status" "error" \
            "Service failed to start" \
            "1.0" \
            "{\"state\": \"$state\", \"enabled\": \"$enabled\"}"
    else
        add_check "service_status" "warning" \
            "Service status unknown: $state" \
            "0.5" \
            "{\"state\": \"$state\", \"enabled\": \"$enabled\"}"
    fi
}

#
# Check 2: Token Expiry
#
check_token_expiry() {
    if [ ! -f "$AUTH_FILE" ]; then
        add_check "token_expiry" "error" \
            "Auth configuration file not found" \
            "1.0" \
            "{\"file\": \"$AUTH_FILE\"}"
        return
    fi

    local result=$(python3 <<'PYEOF'
import json, base64, sys
from datetime import datetime, timezone

try:
    with open("/root/.codex/auth.json") as f:
        auth = json.load(f)

    token = auth['tokens']['access_token']
    payload = token.split('.')[1] + '==='
    jwt = json.loads(base64.urlsafe_b64decode(payload))

    exp_timestamp = jwt['exp']
    exp_dt = datetime.fromtimestamp(exp_timestamp, tz=timezone.utc)
    now = datetime.now(timezone.utc)

    remaining = (exp_dt - now).total_seconds()
    days_remaining = remaining / 86400
    email = jwt.get('email', 'unknown')

    # Determine status and severity
    if remaining < 0:
        status = 'error'
        severity = 1.0
        message = 'Token has expired'
    elif days_remaining < 1:
        status = 'error'
        severity = 0.9
        message = f'Token expires in {remaining/3600:.1f} hours'
    elif days_remaining < 3:
        status = 'warning'
        severity = 0.6
        message = f'Token expires in {days_remaining:.1f} days'
    elif days_remaining < 7:
        status = 'warning'
        severity = 0.3
        message = f'Token expires in {days_remaining:.1f} days (consider renewal)'
    else:
        status = 'ok'
        severity = 0.0
        message = f'Token valid for {days_remaining:.1f} days'

    # Output JSON
    result = {
        'status': status,
        'message': message,
        'severity': severity,
        'details': {
            'expires_at': exp_dt.isoformat(),
            'days_remaining': round(days_remaining, 1),
            'email': email
        }
    }
    print(json.dumps(result))

except Exception as e:
    result = {
        'status': 'error',
        'message': f'Token check failed: {str(e)}',
        'severity': 0.8,
        'details': {'error': str(e)}
    }
    print(json.dumps(result))
PYEOF
)

    local status=$(echo "$result" | jq -r '.status')
    local message=$(echo "$result" | jq -r '.message')
    local severity=$(echo "$result" | jq -r '.severity')
    local details=$(echo "$result" | jq -c '.details')

    add_check "token_expiry" "$status" "$message" "$severity" "$details"
}

#
# Check 3: Memory Usage
#
check_memory_usage() {
    local mem_info=$(free -m | awk 'NR==2 {print $2, $3, $4}')
    read -r total used available <<< "$mem_info"

    local used_pct=$(awk "BEGIN {printf \"%.0f\", ($used / $total) * 100}")
    local used_gb=$(awk "BEGIN {printf \"%.2f\", $used / 1024}")
    local total_gb=$(awk "BEGIN {printf \"%.2f\", $total / 1024}")

    local status severity message
    if [ "$used_pct" -ge "$MEM_CRIT" ]; then
        status="error"
        severity="0.9"
        message="Memory usage critical: ${used_pct}% (OOM risk)"
    elif [ "$used_pct" -ge "$MEM_WARN" ]; then
        status="warning"
        severity="0.5"
        message="Memory usage high: ${used_pct}%"
    else
        status="ok"
        severity="0.0"
        message="Memory usage normal: ${used_pct}%"
    fi

    add_check "memory_usage" "$status" "$message" "$severity" \
        "{\"used_pct\": $used_pct, \"used_gb\": $used_gb, \"total_gb\": $total_gb, \"available_mb\": $available}"
}

#
# Check 4: Log Errors
#
check_log_errors() {
    local error_count=$(journalctl -u "$SERVICE" --since "10 minutes ago" --no-pager 2>/dev/null \
        | grep -i "error" | wc -l || echo 0)

    if [ "$error_count" -eq 0 ]; then
        add_check "log_errors" "ok" \
            "No errors in last 10 minutes" \
            "0.0" \
            "{\"error_count\": 0, \"period_minutes\": 10}"
    elif [ "$error_count" -le 5 ]; then
        local sample=$(journalctl -u "$SERVICE" --since "10 minutes ago" --no-pager 2>/dev/null \
            | grep -i "error" | tail -1 | sed 's/"/\\"/g')
        add_check "log_errors" "warning" \
            "$error_count errors found in last 10 minutes" \
            "0.4" \
            "{\"error_count\": $error_count, \"period_minutes\": 10, \"sample\": \"$sample\"}"
    else
        local sample=$(journalctl -u "$SERVICE" --since "10 minutes ago" --no-pager 2>/dev/null \
            | grep -i "error" | tail -1 | sed 's/"/\\"/g')
        add_check "log_errors" "error" \
            "$error_count errors found in last 10 minutes" \
            "0.7" \
            "{\"error_count\": $error_count, \"period_minutes\": 10, \"sample\": \"$sample\"}"
    fi
}

#
# Check 5: Port Listening (optional, may fail in restricted environments)
#
check_port_listening() {
    local port="${OPENCLAW_GATEWAY_PORT:-18789}"

    # Try to check if port is listening (requires ss or netstat)
    if command -v ss &> /dev/null; then
        local listening=$(ss -tlnp 2>/dev/null | grep ":$port " | wc -l || echo 0)
    elif command -v netstat &> /dev/null; then
        local listening=$(netstat -tlnp 2>/dev/null | grep ":$port " | wc -l || echo 0)
    else
        # Skip check if tools not available
        add_check "port_listening" "ok" \
            "Port check skipped (tools not available)" \
            "0.0" \
            "{\"port\": $port, \"skipped\": true}"
        return
    fi

    if [ "$listening" -gt 0 ]; then
        add_check "port_listening" "ok" \
            "Gateway port $port is listening" \
            "0.0" \
            "{\"port\": $port, \"listening\": true}"
    else
        add_check "port_listening" "warning" \
            "Gateway port $port is not listening" \
            "0.4" \
            "{\"port\": $port, \"listening\": false}"
    fi
}

#
# Main execution
#
main() {
    # Run all checks
    check_service_status
    check_token_expiry
    check_memory_usage
    check_log_errors
    check_port_listening

    # Output final JSON
    cat <<EOF
{
  "timestamp": "$TIMESTAMP",
  "checks": $CHECKS
}
EOF
}

# Execute main function
main
