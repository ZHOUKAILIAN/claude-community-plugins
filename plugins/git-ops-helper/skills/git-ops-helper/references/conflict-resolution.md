# Conflict Resolution Guide

## Before You Start
- Confirm whether the user prefers rebase or merge resolution.
- Identify the target branch and the commits involved.
- Ask if force-push is allowed (for rebase on shared branches).

## Standard Conflict Workflow
1. Inspect conflicts: `git status`
2. Open each conflicted file and resolve markers:
   - Keep needed lines, remove conflict markers.
3. Verify changes with `git diff`.
4. Mark resolved: `git add <file>`.
5. Continue:
   - Rebase: `git rebase --continue`
   - Merge: `git merge --continue` (or commit if needed)

## Rebase-Specific Notes
- Use `git rebase --abort` to cancel if resolution is wrong.
- Use `git rebase --skip` only when a commit is no longer needed.
- Avoid rewriting shared history unless confirmed.

## Safety Checks
- Run tests if the user expects validation.
- Summarize resolved files and remaining conflicts.
- Confirm before force-push: `git push --force-with-lease`.
