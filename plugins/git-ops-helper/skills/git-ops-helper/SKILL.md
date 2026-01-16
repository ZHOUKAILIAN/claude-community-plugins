---
name: git-ops-helper
description: Git operations helper for commit summaries, commit message drafting, conflict resolution, rebase/cherry-pick/merge guidance, and safe revert/reset workflows in local repositories. Use when a user asks to summarize git changes, craft commit messages, resolve conflicts, perform rebase/cherry-pick/merge, or handle revert/reset safely.
---

# Git Ops Helper

## Overview

Provide safe, repeatable Git workflows with clear commands, change summaries, and expert guidance for conflict resolution and rebase. Default to a standard commit message style, and switch to a custom style when the user provides a template.

## Global Safety Rules

- Do not run any Git command without explicit user confirmation.
- Always show the exact command before asking for confirmation.
- If the current branch is `main` or `master`, ask whether to create a new branch before committing.

## Commit Summary and Message Workflow

1. Collect context (after confirmation):
   - `git status -sb`
   - `git diff` (unstaged)
   - `git diff --staged` (staged)
   - `git log -n 5 --oneline`
2. Check whether changes are staged. If both staged and unstaged exist, summarize them separately.
3. Perform a code check before summarizing:
   - Review diffs for obvious bugs, risky changes, and missing tests.
   - If issues are found, warn the user and ask whether to continue.
4. Summarize changes concisely in the user’s language.
5. Draft a commit message:
   - If the user gave a custom template, follow it exactly.
   - Otherwise use the default style from `references/commit-messages.md`.
6. If committing on `main`/`master`, offer to create a branch (`git switch -c <branch>`).
7. Present the suggested `git commit` command and ask for confirmation.

## Command: summarize-commit

Use this command when the user asks to summarize current changes or generate a commit message. The command should:

1. Follow the workflow above.
2. Produce a concise summary + a recommended commit message.
3. Ask whether to proceed with `git commit` and whether to adjust the message.

## Git Expert Operations

### Conflict Resolution

- Load `references/conflict-resolution.md` for the standard workflow.
- Always list conflicted files and show the next command (`rebase --continue` or `merge --continue`).
- Summarize what was kept or removed per file.

### Rebase Guidance

1. Clarify intent: linear history, squash, or reordering.
2. Decide between `git rebase -i <base>` and merge-based alternatives.
3. If rebase touches shared branches, confirm whether force-push is allowed.
4. After rebase, show `git log --oneline -n 5` and ask for confirmation to push.

### Revert and Reset

- Prefer `git revert <commit>` for shared history.
- Explain reset types clearly:
  - `--soft`: keep staged changes
  - `--mixed`: keep working tree only
  - `--hard`: discard changes (high risk)
- Require explicit confirmation before `reset --hard` or forced pushes.

## Resources

- `references/commit-messages.md`: default commit message guidance
- `references/conflict-resolution.md`: conflict resolution workflow
