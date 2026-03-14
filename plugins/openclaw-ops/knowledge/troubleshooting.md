# OpenClaw Operations Troubleshooting Guide

Common issues and solutions when using the OpenClaw Operations plugin.

## Connection Issues

### SSH Connection Failed

**Symptoms:**
```
❌ Cannot connect to server
```

**Solutions:**

1. **Verify server is reachable:**
   ```bash
   ping ${OPENCLAW_SSH_HOST}
   ```

2. **Test SSH connection:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} echo "OK"
   ```

3. **Check SSH configuration:**
   ```bash
   # View SSH config
   cat ~/.ssh/config

   # List SSH keys
   ssh-add -l

   # Add key if needed
   ssh-add ~/.ssh/id_rsa
   ```

4. **Check firewall/network:**
   - Verify port 22 is open
   - Check if VPN is required
   - Confirm network connectivity

### Permission Denied

**Symptoms:**
```
❌ Permission denied (publickey)
```

**Solutions:**

1. **Verify SSH key permissions:**
   ```bash
   chmod 600 ~/.ssh/id_rsa
   chmod 644 ~/.ssh/id_rsa.pub
   chmod 700 ~/.ssh
   ```

2. **Use correct user:**
   ```bash
   export OPENCLAW_SSH_USER="root"
   ```

3. **Check server authorized_keys:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'cat ~/.ssh/authorized_keys'
   ```

## Environment Configuration

### Required Variable Not Set

**Symptoms:**
```
ERROR: OPENCLAW_SSH_HOST environment variable is required
```

**Solution:**

Set the required variable:
```bash
# Temporary (current session only)
export OPENCLAW_SSH_HOST="104.168.43.20"

# Permanent (add to shell config)
echo 'export OPENCLAW_SSH_HOST="104.168.43.20"' >> ~/.bashrc
source ~/.bashrc
```

### Variables Not Persisting

**Problem:** Environment variables reset after closing terminal

**Solution:**

Add to shell configuration file:

For **bash** (`~/.bashrc`):
```bash
export OPENCLAW_SSH_HOST="your-server-ip"
export OPENCLAW_SSH_USER="root"
export OPENCLAW_SERVICE_NAME="openclaw"
```

For **zsh** (`~/.zshrc`):
```zsh
export OPENCLAW_SSH_HOST="your-server-ip"
export OPENCLAW_SSH_USER="root"
export OPENCLAW_SERVICE_NAME="openclaw"
```

Then reload:
```bash
source ~/.bashrc  # or ~/.zshrc
```

## Diagnostic Issues

### Command Timeout

**Symptoms:**
```
⏱️  Diagnostic command timed out after 30 seconds
```

**Causes:**
- Server is overloaded
- Network latency is high
- Service is unresponsive

**Solutions:**

1. **Check server load:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} uptime
   ```

2. **Check network latency:**
   ```bash
   ping -c 5 ${OPENCLAW_SSH_HOST}
   ```

3. **Run diagnostics directly on server:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST}
   # Then on server:
   systemctl status openclaw
   free -h
   journalctl -u openclaw -n 50
   ```

### False Positive Warnings

**Symptoms:** Diagnostics report warnings for normal conditions

**Solutions:**

1. **Adjust thresholds via environment variables:**
   ```bash
   # Increase memory warning threshold
   export OPENCLAW_MEM_WARN_PCT="80"
   export OPENCLAW_MEM_CRIT_PCT="90"
   ```

2. **Ignore expected warnings:**
   - Token expiry warnings < 7 days are informational
   - Memory usage 60-70% is normal for production systems

## Token Update Issues

### Token File Not Found

**Symptoms:**
```
❌ Token file not found: /path/to/auth.json
```

**Solutions:**

1. **Find your token file:**
   ```bash
   find ~ -name "auth.json" -type f 2>/dev/null
   ```

2. **Check common locations:**
   - `~/.codex/auth.json` (Claude Code default)
   - `~/Downloads/auth.json` (downloaded)
   - `~/.config/claude/auth.json` (alternative)

3. **Use absolute path:**
   ```bash
   /openclaw-update-token /Users/yourname/.codex/auth.json
   ```

### Token Expired Locally

**Symptoms:**
```
❌ Token has expired
Expired on: 2026-03-12
```

**Solutions:**

1. **Refresh token via Claude Code:**
   ```bash
   # Open Claude Code CLI
   codex

   # Run any command to trigger refresh
   codex auth status
   ```

2. **Or manually login:**
   ```bash
   codex auth login
   ```

3. **Then retry update:**
   ```bash
   /openclaw-update-token ~/.codex/auth.json
   ```

### Invalid JSON Format

**Symptoms:**
```
❌ Invalid JSON format in token file
```

**Solutions:**

1. **Verify JSON syntax:**
   ```bash
   cat /path/to/auth.json | jq .
   ```

2. **Check file wasn't corrupted:**
   ```bash
   # View file size
   ls -lh /path/to/auth.json

   # Should be 2-5 KB typically
   ```

3. **Re-download/regenerate token:**
   - Don't manually edit auth.json
   - Get fresh token from Claude Code

### Service Restart Failed

**Symptoms:**
```
❌ Service restart failed
```

**Solutions:**

1. **Check service logs:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'journalctl -u openclaw -n 100'
   ```

2. **Check service file:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'systemctl cat openclaw'
   ```

3. **Manual restart:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'systemctl restart openclaw'
   ```

4. **Check for port conflicts:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'ss -tlnp | grep 18789'
   ```

## Service Issues

### Service Inactive/Dead

**Symptoms:** Diagnostics show `Service: inactive (dead)`

**Solutions:**

1. **Start the service:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'systemctl start openclaw'
   ```

2. **Enable auto-start:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'systemctl enable openclaw'
   ```

3. **Check why it stopped:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'journalctl -u openclaw --since "1 hour ago"'
   ```

### Service Failed to Start

**Symptoms:** Diagnostics show `Service: failed`

**Causes:**
- Configuration error
- Missing dependencies
- Port already in use
- Out of memory

**Solutions:**

1. **Check detailed error:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'systemctl status openclaw -l'
   ```

2. **Verify configuration:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'cat /root/.openclaw/openclaw.json | jq .'
   ```

3. **Check dependencies:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'cd /root/openclaw && npm list --depth=0'
   ```

4. **Check port availability:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'ss -tlnp | grep 18789'
   ```

### High Memory Usage

**Symptoms:** Memory > 80%, OOM warnings

**Immediate Actions:**

1. **Check memory consumers:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'ps aux --sort=-%mem | head -10'
   ```

2. **Clear browser processes:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'pkill -9 chrome'
   ```

3. **Restart OpenClaw:**
   ```bash
   ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} \
     'systemctl restart openclaw'
   ```

**Long-term Solutions:**

1. **Upgrade server RAM** (recommended if consistently high)
2. **Optimize OpenClaw config** (reduce browser tabs/sessions)
3. **Add swap space:**
   ```bash
   # Create 2GB swap
   sudo dd if=/dev/zero of=/swapfile bs=1M count=2048
   sudo chmod 600 /swapfile
   sudo mkswap /swapfile
   sudo swapon /swapfile
   ```

## Plugin Issues

### Command Not Found

**Symptoms:**
```
Unknown skill: openclaw-diagnose
```

**Solutions:**

1. **Verify plugin installation:**
   ```bash
   ls -la ~/.claude/plugins/openclaw-ops/
   ```

2. **Reinstall plugin:**
   ```bash
   cd ~/.claude/plugins/
   rm -rf openclaw-ops
   git clone <repo-url> openclaw-ops
   ```

3. **Check Claude Code version:**
   ```bash
   claude --version
   ```

### Outdated Scripts

**Symptoms:** Errors about missing features or changed behavior

**Solution:**

Update plugin to latest version:
```bash
cd ~/.claude/plugins/openclaw-ops/
git pull origin main
```

## Getting Help

If issues persist:

1. **Enable verbose mode** (when implemented):
   ```bash
   export OPENCLAW_DEBUG=1
   /openclaw-diagnose
   ```

2. **Collect diagnostic info:**
   ```bash
   # Environment
   env | grep OPENCLAW

   # SSH status
   ssh -v ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} echo OK

   # Plugin version
   cat ~/.claude/plugins/openclaw-ops/.claude-plugin/plugin.json
   ```

3. **Check GitHub issues:**
   https://github.com/your-org/openclaw-ops/issues

4. **File a bug report** with:
   - Error messages
   - Environment configuration (sanitized)
   - Steps to reproduce
   - Plugin version

## Best Practices

To avoid issues:

1. **Set environment variables permanently** in shell config
2. **Keep tokens updated** before expiration (3+ days remaining)
3. **Run diagnostics regularly** to catch issues early
4. **Monitor server resources** via `/openclaw-diagnose`
5. **Test after updates** to verify functionality
6. **Keep backups** of configuration files

## Quick Reference

Common commands for troubleshooting:

```bash
# Test SSH connection
ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} echo OK

# Check environment
env | grep OPENCLAW

# View service status
ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} 'systemctl status openclaw'

# View recent logs
ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} 'journalctl -u openclaw -n 50'

# Check memory
ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} 'free -h'

# Find token file
find ~ -name "auth.json" -type f

# Validate token
cat ~/.codex/auth.json | jq .

# Re-diagnose
/openclaw-diagnose
```
