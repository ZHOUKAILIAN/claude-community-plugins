# OpenClaw Operations Toolkit

A Claude Code plugin for managing and diagnosing OpenClaw Telegram bot gateway servers.

## Overview

OpenClaw Operations Toolkit provides two essential commands for maintaining your OpenClaw deployment:

- **`/openclaw-diagnose`** - Comprehensive service health diagnostics
- **`/openclaw-update-token`** - Automated token synchronization

## Features

### Diagnostics (`/openclaw-diagnose`)

Automatically checks:
- ✅ systemd service status
- ✅ OAuth token expiration
- ✅ Memory and resource usage
- ✅ Recent error logs
- ✅ Port availability

### Token Management (`/openclaw-update-token`)

Handles complete token update workflow:
- 📁 Reads local auth.json
- ✅ Validates JWT expiration
- ⬆️  Uploads to server
- 🔄 Syncs configuration files
- ♻️  Restarts service
- ✅ Verifies success

## Installation

```bash
# Install via Claude Code
claude code plugin install openclaw-ops

# Or manually
cd ~/.claude/plugins/
git clone <repo-url> openclaw-ops
```

## Configuration

### Required Environment Variables

```bash
export OPENCLAW_SSH_HOST="your-server-ip"  # REQUIRED
```

### Optional Environment Variables

```bash
export OPENCLAW_SSH_USER="root"                   # Default: root
export OPENCLAW_SERVICE_NAME="openclaw"           # Default: openclaw
export OPENCLAW_INSTALL_DIR="/root/openclaw"      # Default: /root/openclaw
export OPENCLAW_CONFIG_DIR="/root/.openclaw"      # Default: /root/.openclaw
export OPENCLAW_MEM_WARN_PCT="70"                 # Default: 70
export OPENCLAW_MEM_CRIT_PCT="80"                 # Default: 80
```

Add these to your `~/.bashrc` or `~/.zshrc` for persistence.

## Usage

### Basic Diagnostics

```bash
# Full system health check
/openclaw-diagnose

# With problem description
/openclaw-diagnose Bot not responding, timeout 60s
/openclaw-diagnose Memory usage high
```

### Token Updates

```bash
# Interactive mode (asks for token file)
/openclaw-update-token

# Specify token file directly
/openclaw-update-token ~/.codex/auth.json
/openclaw-update-token ~/Downloads/auth.json
```

## Example Output

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
✅ Logs: no errors

All checks passed!
```

### Warning State

```
🔍 OpenClaw Diagnostic Report
Time: 2026-03-14 10:30:00 UTC
Server: 104.168.43.20
Overall Status: ⚠️  WARNING

Problems Found (1 item):
⚠️ Token expires in 2 days

Suggested Actions:
1. Update Token: /openclaw-update-token
```

## Troubleshooting

### SSH Connection Failed

```bash
# Test SSH connection
ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} echo "OK"

# Check SSH key
ssh-add -l
```

### Environment Variable Not Set

```bash
# Check current value
echo $OPENCLAW_SSH_HOST

# Set temporarily
export OPENCLAW_SSH_HOST="104.168.43.20"

# Set permanently (add to ~/.bashrc)
echo 'export OPENCLAW_SSH_HOST="104.168.43.20"' >> ~/.bashrc
source ~/.bashrc
```

### Permission Denied

```bash
# Use root user
export OPENCLAW_SSH_USER="root"

# Or grant permissions
ssh root@server 'chown youruser /root/.openclaw -R'
```

## Requirements

### Local Machine
- Claude Code CLI
- SSH client
- SSH access to OpenClaw server

### Remote Server
- Linux with systemd
- Python 3.6+
- jq (for JSON parsing)
- OpenClaw installed and configured

## Architecture

```
┌─────────────────┐
│  Claude Code    │
│   (Local)       │
└────────┬────────┘
         │ SSH
         ▼
┌─────────────────┐
│  OpenClaw       │
│   Server        │
│                 │
│  • systemd      │
│  • auth.json    │
│  • configs      │
└─────────────────┘
```

The plugin uses SSH to execute diagnostic scripts and sync configurations on the remote server.

## Security Considerations

- Uses SSH for secure communication
- Tokens are transmitted via secure SSH channels
- No credentials stored in plugin code
- Environment variables keep sensitive data out of version control
- All operations logged for audit trail

## Contributing

Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License

MIT License - see LICENSE file for details

## Support

- Issues: [GitHub Issues](https://github.com/your-org/openclaw-ops/issues)
- Documentation: See `knowledge/` directory
- Related: [OpenClaw Official Docs](https://github.com/openclaw/openclaw)

---

**[中文版本](README-zh.md) | [English Version](README.md)**
