---
name: openclaw-update-token
description: |
  Sync local authentication token file to OpenClaw server. Updates both codex and
  OpenClaw configuration files, then restarts the service. Use this when token expires,
  authentication fails, or when you need to refresh OpenClaw credentials.

  <example>/openclaw-update-token</example>
  <example>/openclaw-update-token ~/.codex/auth.json</example>
  <example>/openclaw-update-token ~/my-token.json</example>
  <example>Update OpenClaw token from my local auth file</example>
allowed-tools: ["Bash", "Read", "Write", "AskUserQuestion"]
license: MIT
---

# OpenClaw Token Update Command

**Purpose**: Synchronize local auth.json token file to remote OpenClaw server.

## What It Does

This command handles the complete token update workflow:

1. 📁 **Read local token** - Load auth.json from your machine
2. ✅ **Validate token** - Check JWT expiration and format
3. ⬆️  **Upload to server** - Securely transfer via SSH
4. 🔄 **Sync configurations** - Update both codex and OpenClaw configs
5. ♻️  **Restart service** - Apply changes with service restart
6. ✅ **Verify success** - Confirm service is running with new token

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `OPENCLAW_SSH_HOST` | ✅ **Yes** | - | Server IP/hostname (MUST be provided) |
| `OPENCLAW_SSH_USER` | No | `root` | SSH username |
| `OPENCLAW_SERVICE_NAME` | No | `openclaw` | systemd service name |
| `OPENCLAW_CONFIG_DIR` | No | `/root/.openclaw` | Configuration directory |

## Usage

```bash
# Interactive mode - will ask for token file path
/openclaw-update-token

# Specify token file directly
/openclaw-update-token ~/.codex/auth.json
/openclaw-update-token ~/custom-auth.json

# Common paths
/openclaw-update-token ~/.codex/auth.json          # Claude Code token
/openclaw-update-token ~/Downloads/auth.json       # Downloaded token
```

## Implementation

### Step 1: Get Token File Path

If the user didn't provide a file path, ask them:

Use `AskUserQuestion`:

```json
{
  "questions": [{
    "question": "Please provide the path to your auth.json token file",
    "header": "Token File",
    "multiSelect": false,
    "options": [
      {
        "label": "~/.codex/auth.json (recommended)",
        "description": "Claude Code default token location"
      },
      {
        "label": "~/Downloads/auth.json",
        "description": "Recently downloaded token file"
      },
      {
        "label": "Custom path (I'll type it)",
        "description": "Enter a different file path"
      }
    ]
  }]
}
```

If user selects "Custom path", prompt them to enter the full path.

Store the selected or provided path in `TOKEN_FILE_PATH`.

### Step 2: Validate Environment

Check required environment variables:

```bash
if [ -z "${OPENCLAW_SSH_HOST}" ]; then
    echo "ERROR: OPENCLAW_SSH_HOST environment variable is required"
    echo "Please set it with: export OPENCLAW_SSH_HOST='your-server-ip'"
    exit 1
fi

SSH_HOST="${OPENCLAW_SSH_HOST}"
SSH_USER="${OPENCLAW_SSH_USER:-root}"
SERVICE="${OPENCLAW_SERVICE_NAME:-openclaw}"
CONFIG_DIR="${OPENCLAW_CONFIG_DIR:-/root/.openclaw}"
```

Show progress to user:
```
🔄 OpenClaw Token Update Starting...

Configuration:
• Server: ${SSH_HOST}
• User: ${SSH_USER}
• Service: ${SERVICE}
• Token File: ${TOKEN_FILE_PATH}

Step 1/6: Reading local token...
```

### Step 3: Read and Validate Local Token

Expand tilde (~) to home directory and read the token file:

```bash
# Expand ~ to $HOME
TOKEN_FILE="${TOKEN_FILE_PATH/#\~/$HOME}"

# Check if file exists
if [ ! -f "${TOKEN_FILE}" ]; then
    echo "❌ Token file not found: ${TOKEN_FILE}"
    echo ""
    echo "Please check:"
    echo "1. File path is correct"
    echo "2. File exists and is readable"
    echo "3. Use absolute path (e.g., /Users/yourname/.codex/auth.json)"
    exit 1
fi
```

Read and validate the token using Python:

```python
import json
import base64
from datetime import datetime, timezone

# Read token file
with open(token_file) as f:
    try:
        auth = json.load(f)
    except json.JSONDecodeError as e:
        print(f"❌ Invalid JSON format: {e}")
        exit(1)

# Verify structure
if 'tokens' not in auth:
    print("❌ Invalid token file: missing 'tokens' field")
    exit(1)

if 'access_token' not in auth['tokens']:
    print("❌ Invalid token file: missing 'access_token'")
    exit(1)

# Parse JWT to extract info
token = auth['tokens']['access_token']
try:
    # Decode JWT payload (no verification needed, just reading)
    parts = token.split('.')
    if len(parts) != 3:
        raise ValueError("Invalid JWT format")

    # Base64 decode payload (add padding if needed)
    payload_b64 = parts[1] + '==='
    payload = json.loads(base64.urlsafe_b64decode(payload_b64))

    # Extract expiration
    exp_timestamp = payload.get('exp')
    if not exp_timestamp:
        raise ValueError("No expiration in token")

    exp_dt = datetime.fromtimestamp(exp_timestamp, tz=timezone.utc)
    now = datetime.now(timezone.utc)

    # Calculate remaining time
    remaining = (exp_dt - now).total_seconds()
    days_left = remaining / 86400

    # Check if expired
    if remaining < 0:
        print(f"❌ Token has expired")
        print(f"   Expired on: {exp_dt.isoformat()}")
        print(f"   Please obtain a fresh token from Claude Code")
        exit(1)

    # Extract email if available
    email = payload.get('email', 'unknown')

    # Show validation result
    print(f"✅ Token validation passed")
    print(f"   Email: {email}")
    print(f"   Valid for: {days_left:.1f} days (until {exp_dt.strftime('%Y-%m-%d')})")

    # Warn if expiring soon
    if days_left < 3:
        print(f"   ⚠️  Warning: Token expires in less than 3 days")

except Exception as e:
    print(f"❌ Token validation failed: {e}")
    exit(1)
```

### Step 4: Upload Token to Server

Upload the auth.json file to server's /tmp directory:

```bash
echo ""
echo "Step 2/6: Uploading token to server..."

scp "${TOKEN_FILE}" ${SSH_USER}@${SSH_HOST}:/tmp/sync_auth.json

if [ $? -ne 0 ]; then
    echo "❌ Upload failed"
    echo ""
    echo "Possible causes:"
    echo "1. SSH connection issue"
    echo "2. Server unreachable"
    echo "3. Permission denied"
    echo ""
    echo "Test connection: ssh ${SSH_USER}@${SSH_HOST} echo OK"
    exit 1
fi

echo "✅ Token uploaded successfully"
```

### Step 5: Read and Execute Sync Script

Read the Python sync script from `scripts/update-token.py` and execute it on the server:

```bash
echo ""
echo "Step 3/6: Syncing configuration files..."

# Upload the sync script
cat scripts/update-token.py | ssh ${SSH_USER}@${SSH_HOST} 'cat > /tmp/update-token.py'

# Execute the sync script
ssh ${SSH_USER}@${SSH_HOST} "CONFIG_DIR=${CONFIG_DIR} python3 /tmp/update-token.py"

if [ $? -ne 0 ]; then
    echo "❌ Configuration sync failed"
    echo ""
    echo "The script encountered an error updating config files."
    echo "Please check server logs for details."
    exit 1
fi
```

The sync script will output:
```
✅ Configuration files updated:
   • /root/.codex/auth.json
   • /root/.openclaw/agents/main/agent/auth-profiles.json

Token synced for: user@example.com
```

### Step 6: Restart OpenClaw Service

Restart the service to apply the new token:

```bash
echo ""
echo "Step 4/6: Restarting OpenClaw service..."

ssh ${SSH_USER}@${SSH_HOST} "systemctl restart ${SERVICE}"

if [ $? -ne 0 ]; then
    echo "❌ Service restart failed"
    echo ""
    echo "Manual restart required:"
    echo "  ssh ${SSH_USER}@${SSH_HOST} 'systemctl restart ${SERVICE}'"
    exit 1
fi

echo "✅ Service restarted: ${SERVICE}"
```

### Step 7: Verify Service Status

Wait a moment and verify the service is running:

```bash
echo ""
echo "Step 5/6: Verifying service status..."

# Wait 3 seconds for service to stabilize
sleep 3

# Check service status
SERVICE_STATUS=$(ssh ${SSH_USER}@${SSH_HOST} "systemctl is-active ${SERVICE}")

if [ "${SERVICE_STATUS}" != "active" ]; then
    echo "⚠️  Service status: ${SERVICE_STATUS}"
    echo ""
    echo "Service may not have started properly."
    echo "Check logs: ssh ${SSH_USER}@${SSH_HOST} 'journalctl -u ${SERVICE} -n 50'"
    exit 1
fi

echo "✅ Service is active and running"
```

### Step 8: Validate Token on Server

Double-check the token was updated correctly:

```bash
echo ""
echo "Step 6/6: Validating server token..."

# Read token expiry from server
ssh ${SSH_USER}@${SSH_HOST} "python3 << 'PYEOF'
import json, base64, datetime

try:
    with open('/root/.codex/auth.json') as f:
        auth = json.load(f)

    token = auth['tokens']['access_token']
    payload = token.split('.')[1] + '==='
    jwt = json.loads(base64.urlsafe_b64decode(payload))

    exp = datetime.datetime.utcfromtimestamp(jwt['exp'])
    now = datetime.datetime.utcnow()
    days = (exp - now).days

    print(f'Token valid for {days} days (expires: {exp.strftime(\"%Y-%m-%d\")})')
except Exception as e:
    print(f'Validation check failed: {e}')
PYEOF
"
```

### Step 9: Final Report

Show a comprehensive success report:

```markdown
## ✅ Token Update Complete

**Summary:**
✅ Token validated and uploaded
✅ Configuration files synced
   • /root/.codex/auth.json
   • /root/.openclaw/agents/main/agent/auth-profiles.json
✅ Service restarted successfully
✅ Token verified on server

**Server Status:**
• Service: active (running)
• Token: valid for {days} days
• Email: {email}

**Next Steps:**
- Test the bot by sending a message
- Monitor service: `journalctl -u openclaw -f`
- Check diagnostics: `/openclaw-diagnose`

Token will expire on: {expiry_date}
Remember to update again before then!
```

## Error Handling

### File Not Found
```
❌ Token file not found: /path/to/auth.json

Common locations to check:
1. ~/.codex/auth.json (Claude Code default)
2. ~/Downloads/auth.json (recent download)
3. /tmp/auth.json (temporary location)

To find your token:
  find ~ -name "auth.json" -type f 2>/dev/null

Make sure you're using the absolute path!
```

### Invalid JSON Format
```
❌ Invalid JSON format in token file

The file exists but is not valid JSON.

Troubleshooting:
1. Verify file is not corrupted
2. Check file contents: cat /path/to/auth.json | jq .
3. Re-download token from Claude Code
4. Ensure file wasn't edited manually
```

### Token Expired
```
❌ Token has expired

Your local token expired on: {date}

To fix:
1. Open Claude Code CLI
2. Run any command to trigger auto-refresh
3. Or run: codex auth login
4. Then retry: /openclaw-update-token
```

### Upload Failed
```
❌ Failed to upload token to server

Possible causes:
1. SSH connection issue
   - Test: ssh {user}@{host} echo OK
2. Server unreachable
   - Check: ping {host}
3. Permission denied
   - Verify SSH key: ssh-add -l

Check your SSH configuration and retry.
```

### Service Restart Failed
```
❌ Service restart failed

Token was updated, but service restart encountered an issue.

Manual restart:
  ssh {user}@{host} 'systemctl restart openclaw'

Check service logs:
  ssh {user}@{host} 'journalctl -u openclaw -n 50'
```

### Permission Denied on Server
```
❌ Permission denied: cannot write config files

The user '{user}' lacks write permissions.

Solutions:
1. Use root user:
   export OPENCLAW_SSH_USER="root"

2. Grant permissions to {user}:
   ssh root@{host} 'chown {user} /root/.codex /root/.openclaw -R'
```

## Output Example

### Successful Update
```
🔄 OpenClaw Token Update Starting...

Configuration:
• Server: 104.168.43.20
• User: root
• Service: openclaw
• Token File: /Users/john/.codex/auth.json

Step 1/6: Reading local token...
✅ Token validation passed
   Email: user@example.com
   Valid for: 15.3 days (until 2026-03-29)

Step 2/6: Uploading token to server...
✅ Token uploaded successfully

Step 3/6: Syncing configuration files...
✅ Configuration files updated:
   • /root/.codex/auth.json
   • /root/.openclaw/agents/main/agent/auth-profiles.json

Token synced for: user@example.com

Step 4/6: Restarting OpenClaw service...
✅ Service restarted: openclaw

Step 5/6: Verifying service status...
✅ Service is active and running

Step 6/6: Validating server token...
Token valid for 15 days (expires: 2026-03-29)

## ✅ Token Update Complete

Summary:
✅ Token validated and uploaded
✅ Configuration files synced
✅ Service restarted successfully
✅ Token verified on server

Server Status:
• Service: active (running)
• Token: valid for 15 days
• Email: user@example.com

Next Steps:
- Test the bot by sending a message
- Monitor service: journalctl -u openclaw -f
- Check diagnostics: /openclaw-diagnose

Token will expire on: 2026-03-29
Remember to update again before then!
```

## Tips

- **Keep local token fresh**: Run Claude Code CLI periodically to auto-refresh your token
- **Update proactively**: Don't wait until token expires - update when you have 3+ days remaining
- **Test after update**: Send a test message to your bot to verify it's working
- **Automate**: Consider setting up a cron job to update tokens automatically (advanced)

## Related Commands

- `/openclaw-diagnose` - Check service health and token expiry
- Native Claude Code: Token auto-refreshes when you use the CLI
