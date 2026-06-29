---
name: hermes-tweet
version: 0.1.6
author: Xquik
description: Use Hermes Agent with Hermes Tweet for X/Twitter search, monitoring, publishing previews, and approval-gated account actions.
tags:
  - hermes-agent
  - xquik
  - twitter
  - x
  - social-media
  - automation
capabilities:
  network:
    required: true
    justification: Hermes Tweet tools call catalog-listed Xquik API routes through the Hermes Agent plugin.
  environment:
    required: true
    variables:
      - XQUIK_API_KEY
      - HERMES_TWEET_ENABLE_ACTIONS
      - HERMES_ENABLE_PROJECT_PLUGINS
    justification: Runtime configuration controls authenticated reads, gated actions, and trusted project-local plugin loading.
  files:
    required: false
    justification: Normal use does not require local files.
  shell:
    required: false
    justification: Shell checks are only for optional Hermes CLI diagnostics.
  mcp:
    required: false
    justification: No MCP server is required.
  tools:
    - tweet_explore
    - tweet_read
    - tweet_action
---

# Hermes Tweet

Use this skill when a user wants X/Twitter work through the native Hermes Agent
Hermes Tweet plugin.

## When to Use

Use Hermes Tweet for social listening, launch monitoring, creator research,
brand research, community audits, giveaway workflows, media workflows, and
controlled publishing tasks.

Use `tweet_explore` first when the endpoint or capability is unclear. Use
`tweet_read` for read-only endpoints after discovery. Use `tweet_action` only
for writes, private reads, monitors, webhooks, extraction jobs, giveaway draws,
or media operations after explicit user approval.

## Workflow

1. Call `tweet_explore` with a short query.
2. Choose a catalog-listed `/api/v1/...` endpoint.
3. Use `tweet_read` for safe read-only endpoints.
4. Use `tweet_action` only after stating the endpoint, payload, and side effect.

## Rules

- Never guess endpoint paths.
- Never create direct HTTP fallbacks.
- Never ask for or reveal API keys, cookies, passwords, or TOTP secrets.
- Do not pass credentials in tool arguments.
- Keep `HERMES_TWEET_ENABLE_ACTIONS=false` by default.
- If `XQUIK_API_KEY` is missing, ask the user to configure it in the Hermes
  runtime environment without pasting the value into chat.
- If project-local plugins are used, remind the user that Hermes requires
  `HERMES_ENABLE_PROJECT_PLUGINS=true` for trusted repositories.

## Install Checks

After installing or updating Hermes Tweet in Hermes Agent:

1. Run `hermes plugins enable hermes-tweet` unless install used `--enable`.
2. Run `hermes plugins list` and confirm the plugin is enabled.
3. Run `hermes tools list` and confirm the Hermes Tweet toolset is visible.
4. Confirm `tweet_explore` is available without an API key.
5. Confirm `tweet_read` appears only when `XQUIK_API_KEY` is configured.
6. Confirm `tweet_action` stays hidden or disabled unless actions are enabled.
