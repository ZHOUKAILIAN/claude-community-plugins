#!/usr/bin/env python3
"""
OpenClaw Token Sync Script
Runs on the remote server to sync auth tokens from /tmp/sync_auth.json
to OpenClaw configuration files.

Environment Variables:
    CONFIG_DIR - OpenClaw configuration directory (default: /root/.openclaw)

Input:
    /tmp/sync_auth.json - Uploaded auth.json file

Outputs:
    Updates /root/.codex/auth.json
    Updates /root/.openclaw/agents/main/agent/auth-profiles.json
"""

import json
import base64
import sys
import os
from pathlib import Path

# Configuration
CONFIG_DIR = os.environ.get('CONFIG_DIR', '/root/.openclaw')
CODEX_AUTH_PATH = '/root/.codex/auth.json'
OPENCLAW_PROFILES_PATH = f'{CONFIG_DIR}/agents/main/agent/auth-profiles.json'
SOURCE_FILE = '/tmp/sync_auth.json'


def read_uploaded_token():
    """Read the uploaded auth.json file."""
    try:
        with open(SOURCE_FILE) as f:
            return json.load(f)
    except FileNotFoundError:
        print(f"ERROR: Source file not found: {SOURCE_FILE}", file=sys.stderr)
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"ERROR: Invalid JSON in source file: {e}", file=sys.stderr)
        sys.exit(1)


def extract_token_info(auth):
    """Extract email and expiration from token."""
    try:
        tokens = auth['tokens']

        # Parse id_token for email
        id_token = tokens['id_token']
        id_payload = id_token.split('.')[1] + '==='
        id_jwt = json.loads(base64.urlsafe_b64decode(id_payload))
        email = id_jwt.get('email', 'unknown')

        # Parse access_token for expiration
        access_token = tokens['access_token']
        access_payload = access_token.split('.')[1] + '==='
        access_jwt = json.loads(base64.urlsafe_b64decode(access_payload))
        expires_ms = access_jwt.get('exp', 0) * 1000

        account_id = tokens.get('account_id', 'unknown')

        return {
            'email': email,
            'account_id': account_id,
            'expires_ms': expires_ms,
            'access_token': tokens['access_token'],
            'refresh_token': tokens['refresh_token']
        }
    except (KeyError, IndexError, ValueError) as e:
        print(f"ERROR: Failed to parse token: {e}", file=sys.stderr)
        sys.exit(1)


def update_codex_auth(auth):
    """Update /root/.codex/auth.json."""
    try:
        # Ensure directory exists
        codex_dir = Path(CODEX_AUTH_PATH).parent
        codex_dir.mkdir(parents=True, exist_ok=True)

        # Write auth.json
        with open(CODEX_AUTH_PATH, 'w') as f:
            json.dump(auth, f, indent=2)

        print(f"✅ Updated: {CODEX_AUTH_PATH}")
        return True
    except Exception as e:
        print(f"ERROR: Failed to update codex auth: {e}", file=sys.stderr)
        return False


def update_openclaw_profiles(token_info):
    """Update OpenClaw auth-profiles.json."""
    try:
        # Ensure directory exists
        profiles_path = Path(OPENCLAW_PROFILES_PATH)
        profiles_path.parent.mkdir(parents=True, exist_ok=True)

        # Read existing profiles or create new
        if profiles_path.exists():
            with open(profiles_path) as f:
                profiles = json.load(f)
        else:
            profiles = {
                "profiles": {
                    "openai-codex": {}
                }
            }

        # Update openai-codex profile
        profiles['profiles']['openai-codex'].update({
            'access': token_info['access_token'],
            'refresh': token_info['refresh_token'],
            'expires': token_info['expires_ms'],
            'email': token_info['email'],
            'accountId': token_info['account_id']
        })

        # Write updated profiles
        with open(profiles_path, 'w') as f:
            json.dump(profiles, f, indent=2)

        print(f"✅ Updated: {OPENCLAW_PROFILES_PATH}")
        return True
    except Exception as e:
        print(f"ERROR: Failed to update OpenClaw profiles: {e}", file=sys.stderr)
        return False


def main():
    """Main execution."""
    # Read uploaded token
    auth = read_uploaded_token()

    # Extract token information
    token_info = extract_token_info(auth)

    # Update both configuration files
    codex_success = update_codex_auth(auth)
    openclaw_success = update_openclaw_profiles(token_info)

    # Report results
    if codex_success and openclaw_success:
        print()
        print(f"Token synced for: {token_info['email']}")
        sys.exit(0)
    else:
        print()
        print("ERROR: Token sync incomplete")
        sys.exit(1)


if __name__ == '__main__':
    main()
