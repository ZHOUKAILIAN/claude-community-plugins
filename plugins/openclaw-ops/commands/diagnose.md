---
name: openclaw-diagnose
description: |
  Diagnose OpenClaw Telegram bot gateway issues and provide actionable fix suggestions.
  Use this command when users mention OpenClaw service problems, bot timeouts, memory issues,
  authentication failures, or when they want to check system health.

  <example>/openclaw-diagnose</example>
  <example>/openclaw-diagnose Bot not responding, 60s timeout</example>
  <example>/openclaw-diagnose Memory usage is too high</example>
  <example>/openclaw-diagnose Check if the service is healthy</example>
  <example>My OpenClaw bot stopped working, can you check what's wrong?</example>
allowed-tools: ["Bash", "Read", "Write", "AskUserQuestion"]
license: MIT
---

# OpenClaw Diagnostics Command

**Purpose**: Automatically diagnose OpenClaw service health issues and provide fix suggestions.

## What It Checks

This command performs comprehensive diagnostics including:
- ✅ **Service status** - systemd service state (active/inactive)
- ✅ **OAuth token expiration** - JWT token validity check
- ✅ **Memory usage** - RAM and swap usage with threshold warnings
- ✅ **Recent log errors** - journalctl error analysis
- ✅ **Port listening** - verify gateway port is accessible

## Environment Variables

Configure your OpenClaw server via environment variables:

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `OPENCLAW_SSH_HOST` | ✅ **Yes** | - | Server IP/hostname (MUST be provided) |
| `OPENCLAW_SSH_USER` | No | `root` | SSH username |
| `OPENCLAW_SERVICE_NAME` | No | `openclaw` | systemd service name |
| `OPENCLAW_INSTALL_DIR` | No | `/root/openclaw` | Installation directory |
| `OPENCLAW_CONFIG_DIR` | No | `/root/.openclaw` | Configuration directory |
| `OPENCLAW_MEM_WARN_PCT` | No | `70` | Memory warning threshold (%) |
| `OPENCLAW_MEM_CRIT_PCT` | No | `80` | Memory critical threshold (%) |

**IMPORTANT**: `OPENCLAW_SSH_HOST` must be set before running this command.

## Usage

```bash
# Full diagnostics with all checks
/openclaw-diagnose

# With problem description (helps focus the diagnosis)
/openclaw-diagnose Bot timeout 60 seconds
/openclaw-diagnose Memory usage high
/openclaw-diagnose Service won't start
```

## Implementation

### Step 1: Validate Environment

Check if required environment variables are set:

```bash
if [ -z "${OPENCLAW_SSH_HOST}" ]; then
    echo "ERROR: OPENCLAW_SSH_HOST environment variable is required"
    echo "Please set it with: export OPENCLAW_SSH_HOST='your-server-ip'"
    exit 1
fi

SSH_HOST="${OPENCLAW_SSH_HOST}"
SSH_USER="${OPENCLAW_SSH_USER:-root}"
SERVICE="${OPENCLAW_SERVICE_NAME:-openclaw}"
INSTALL_DIR="${OPENCLAW_INSTALL_DIR:-/root/openclaw}"
CONFIG_DIR="${OPENCLAW_CONFIG_DIR:-/root/.openclaw}"
MEM_WARN="${OPENCLAW_MEM_WARN_PCT:-70}"
MEM_CRIT="${OPENCLAW_MEM_CRIT_PCT:-80}"
```

Show environment info to user:
```
🔍 OpenClaw Diagnostics Starting...

Environment Configuration:
• Server: ${SSH_HOST}
• User: ${SSH_USER}
• Service: ${SERVICE}
• Install Dir: ${INSTALL_DIR}

Running diagnostics...
```

### Step 2: Upload Diagnostic Script

Read the diagnostic script from `scripts/diagnose.sh` and upload it to the server:

```bash
# Create a temp file with the diagnostic script
cat scripts/diagnose.sh | ssh ${SSH_USER}@${SSH_HOST} 'cat > /tmp/openclaw-diagnose.sh && chmod +x /tmp/openclaw-diagnose.sh'
```

### Step 3: Execute Remote Diagnostics

Run the diagnostic script and capture JSON output:

```bash
DIAG_JSON=$(ssh ${SSH_USER}@${SSH_HOST} \
  "SERVICE=${SERVICE} \
   CONFIG_DIR=${CONFIG_DIR} \
   MEM_WARN=${MEM_WARN} \
   MEM_CRIT=${MEM_CRIT} \
   bash /tmp/openclaw-diagnose.sh")
```

The script returns JSON like:
```json
{
  "timestamp": "2026-03-14T10:30:00Z",
  "checks": [
    {
      "name": "service_status",
      "status": "ok",
      "message": "Service is active and running",
      "details": {"state": "active", "uptime_sec": 86400},
      "severity": 0.0
    },
    {
      "name": "token_expiry",
      "status": "warning",
      "message": "Token expires in 2 days",
      "details": {"days_left": 2, "expires_at": "2026-03-16T10:30:00Z"},
      "severity": 0.6
    },
    {
      "name": "memory_usage",
      "status": "ok",
      "message": "Memory usage is normal (44%)",
      "details": {"used_pct": 44, "used_gb": 1.06, "total_gb": 2.4},
      "severity": 0.0
    }
  ]
}
```

### Step 4: Parse and Analyze Results

Parse the JSON and analyze problems:

```python
import json
from datetime import datetime

diag = json.loads(diag_json)
checks = {c['name']: c for c in diag['checks']}

# Determine overall status
max_severity = max([c['severity'] for c in diag['checks']], default=0.0)
if max_severity >= 0.8:
    overall = "🔴 CRITICAL"
elif max_severity >= 0.5:
    overall = "⚠️  WARNING"
else:
    overall = "✅ HEALTHY"

# Identify problems
problems = []
for check in diag['checks']:
    if check['status'] in ['warning', 'error']:
        problems.append({
            'check': check['name'],
            'severity': check['severity'],
            'message': check['message'],
            'details': check['details']
        })

# Sort by severity (descending)
problems.sort(key=lambda x: x['severity'], reverse=True)
```

### Step 5: Generate Report

Display a formatted diagnostic report:

```markdown
## 🔍 OpenClaw Diagnostic Report

**Time**: {timestamp}
**Server**: {ssh_host}
**Overall Status**: {overall}

### System Status

| Check Item | Status | Details |
|------------|--------|---------|
| Service Status | {icon} | {message} |
| Token Expiry | {icon} | {message} |
| Memory Usage | {icon} | {message} |
| Log Errors | {icon} | {message} |

### {Problems if any}

{If overall != HEALTHY:}
**{severity_level} Issues Found ({count} items)**:

1. **{problem_name}**: {problem_description}
   - Severity: {severity_pct}%
   - Details: {problem_details}

### Suggested Actions

{Generate fix suggestions based on problems}
```

### Step 6: Generate Fix Suggestions

Based on identified problems, suggest fixes:

**Problem patterns**:

1. **Token expired/expiring** → Suggest `/openclaw-update-token`
2. **Service inactive** → Suggest restart: `systemctl restart openclaw`
3. **Memory > 80%** → Suggest cleanup or restart
4. **Log errors** → Show error excerpt and suggest investigation

Example suggestions output:
```markdown
### Recommended Actions

1. **Update Token** (Priority: Medium)
   - Reason: Token expires in 2 days
   - Command: `/openclaw-update-token`
   - Risk: Safe

2. **Monitor Memory** (Priority: Low)
   - Reason: Memory usage at 68%, approaching warning threshold
   - Action: Keep an eye on it, no immediate action needed
```

### Step 7: Offer to Execute Fixes

For actionable fixes, ask the user if they want to proceed:

Use `AskUserQuestion` with options:

```json
{
  "questions": [{
    "question": "Would you like me to execute any of these fixes?",
    "header": "Fix Actions",
    "multiSelect": true,
    "options": [
      {
        "label": "Update Token (/openclaw-update-token)",
        "description": "Sync latest token from local machine to server"
      },
      {
        "label": "Restart Service",
        "description": "Run: systemctl restart openclaw (requires confirmation)"
      },
      {
        "label": "Skip - I'll handle it manually",
        "description": "Just show me the report, no actions"
      }
    ]
  }]
}
```

### Step 8: Execute Selected Fixes

Based on user selection:

- **Update Token** → Call `/openclaw-update-token` command
- **Restart Service** → Run SSH command and verify:
  ```bash
  ssh ${SSH_USER}@${SSH_HOST} "systemctl restart ${SERVICE}"
  # Wait 2 seconds
  sleep 2
  # Verify service is active
  ssh ${SSH_USER}@${SSH_HOST} "systemctl is-active ${SERVICE}"
  ```

### Step 9: Verify and Report Results

After executing fixes, re-run diagnostics (quick check) to verify:

```bash
# Quick verification - just check what was fixed
ssh ${SSH_USER}@${SSH_HOST} "systemctl status ${SERVICE} --no-pager"
```

Report results:
```markdown
## ✅ Fix Results

✅ Service restarted successfully
   - Status: active (running)
   - Uptime: 5 seconds

Next steps:
- Monitor the service for the next few minutes
- Check logs if issues persist: `journalctl -u openclaw -f`
```

## Error Handling

Handle common errors gracefully:

### SSH Connection Failed
```
❌ Cannot connect to ${SSH_HOST}

Possible causes:
1. Server is unreachable (check network/firewall)
2. SSH credentials are incorrect
3. SSH key is not configured

Troubleshooting:
- Test connection: ssh ${SSH_USER}@${SSH_HOST} echo "OK"
- Verify OPENCLAW_SSH_HOST is correct: ${SSH_HOST}
- Check SSH key permissions: chmod 600 ~/.ssh/id_rsa
```

### Environment Variable Missing
```
❌ Required environment variable not set: OPENCLAW_SSH_HOST

Please configure your environment:
export OPENCLAW_SSH_HOST="your-server-ip"
export OPENCLAW_SSH_USER="root"  # optional, defaults to root

Then run the command again.
```

### Permission Denied
```
❌ Permission denied on server

The user '${SSH_USER}' may not have sufficient privileges.

Solutions:
1. Use root user: export OPENCLAW_SSH_USER="root"
2. Or grant sudo access to ${SSH_USER}
```

### Command Timeout
```
⏱️  Diagnostic command timed out after 30 seconds

This may indicate server performance issues.

Suggestions:
- Check server load: ssh ${SSH_HOST} uptime
- Try running diagnostics directly on the server
```

## Output Examples

### Healthy System
```
🔍 OpenClaw Diagnostic Report
Time: 2026-03-14 10:30:00 UTC
Server: 104.168.43.20
Overall Status: ✅ HEALTHY

System Status:
✅ Service: active (running) - uptime 2 days
✅ Token: valid for 15 days
✅ Memory: 44% (1.06GB / 2.4GB)
✅ Logs: no errors in last 10 minutes

All checks passed! System is operating normally.
```

### Warning State
```
🔍 OpenClaw Diagnostic Report
Time: 2026-03-14 10:30:00 UTC
Server: 104.168.43.20
Overall Status: ⚠️  WARNING

System Status:
✅ Service: active (running)
⚠️  Token: expires in 2 days (2026-03-16)
✅ Memory: 44% (1.06GB / 2.4GB)
✅ Logs: no errors

Problems Found (1 item):
1. Token Expiry - Medium priority
   - Token will expire in 2 days
   - Recommend updating before expiration

Suggested Actions:
1. Update Token: /openclaw-update-token
   - Prevents service disruption
   - Takes ~30 seconds
```

### Critical State
```
🔍 OpenClaw Diagnostic Report
Time: 2026-03-14 10:30:00 UTC
Server: 104.168.43.20
Overall Status: 🔴 CRITICAL

System Status:
❌ Service: inactive (dead)
❌ Token: expired (2026-03-12)
⚠️  Memory: 85% (2.04GB / 2.4GB) - CRITICAL
✅ Logs: checked

Critical Problems (3 items):
1. Service Down - CRITICAL (100%)
   - systemd service is not running
   - Last exit: failed

2. Token Expired - CRITICAL (100%)
   - Token expired 2 days ago
   - Authentication will fail

3. Memory Critical - HIGH (85%)
   - Memory usage at 85%, OOM risk
   - May cause service crashes

Immediate Actions Required:
1. Update Token: /openclaw-update-token
2. Restart Service: systemctl restart openclaw
3. Monitor Memory: Consider clearing cache/restarting

Would you like me to execute these fixes?
```

## Tips for Users

- **Set environment variables once**: Add them to your `~/.bashrc` or `~/.zshrc` to persist across sessions
- **Regular health checks**: Run `/openclaw-diagnose` periodically to catch issues early
- **Token expiry**: Update tokens when they have 3+ days remaining to avoid service disruption
- **Memory monitoring**: If memory consistently exceeds 70%, consider upgrading server resources

## Related Commands

- `/openclaw-update-token` - Sync authentication token to server
- Standard SSH debugging: `ssh user@host 'command'`
