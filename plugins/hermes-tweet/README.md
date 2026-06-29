# Hermes Tweet

Hermes Tweet helps Claude Code and Codex users route X/Twitter work to the
native Hermes Agent plugin maintained at
[`Xquik-dev/hermes-tweet`](https://github.com/Xquik-dev/hermes-tweet).

## Included

- Skill: `hermes-tweet`
- Runtime: Hermes Agent with the `hermes-tweet` plugin installed and enabled
- Tools covered: `tweet_explore`, `tweet_read`, `tweet_action`

## Use Cases

- Search tweets, profiles, trends, and public X/Twitter activity.
- Monitor launches, brands, creators, and communities.
- Draft and preview posting workflows before account-changing actions.
- Run giveaway, extraction, media, and webhook workflows after explicit approval.

## Safety Notes

- Keep `XQUIK_API_KEY` in the Hermes runtime environment.
- Keep `HERMES_TWEET_ENABLE_ACTIONS=false` unless a session needs approved writes.
- Never paste API keys, cookies, passwords, or TOTP secrets into chat.
- Start with `tweet_explore`, prefer `tweet_read`, and use `tweet_action` only
  after the exact endpoint, payload, and side effect are approved.
