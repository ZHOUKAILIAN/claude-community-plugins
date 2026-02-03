---
name: git-ops-helper
description: This skill should be used when the user asks to "summarize git changes",
"craft commit messages", "resolve conflicts", "perform rebase", "cherry-pick commits",
or discusses "git operations" and "safe git workflows".
allowed-tools: ["Bash", "Read"]
license: MIT
---

# Git Ops Helper

## Overview

Safe, repeatable Git workflows with clear commands and expert guidance.

## When This Skill Applies

- User requests to summarize git changes
- User wants to craft commit messages
- User needs to resolve merge conflicts
- User asks for rebase/cherry-pick/merge guidance
- User needs safe revert/reset workflows

## Global Safety Rules

- **DO NOT run any Git command without user confirmation**
- **ALWAYS show exact command before execution**
- **ALWAYS check if on main/master before committing**

---

## Workflow: Commit Summary and Message

### Phase 1: Context Collection

**Goal**: Gather current git state

**Actions**:
1. Run `git status -sb`
2. Run `git diff` (unstaged)
3. Run `git diff --staged` (staged)
4. Run `git log -n 5 --oneline`

**WAIT for user confirmation before running commands.**

---

### Phase 2: Code Check

**Goal**: Review changes for issues

**Actions**:
1. Review diffs for obvious bugs
2. Check for risky changes
3. Identify missing tests
4. **Warn user if issues found**

---

### Phase 3: Summary Generation

**Goal**: Create concise change summary

**Actions**:
1. Summarize staged changes
2. Summarize unstaged changes (if any)
3. Use user's language

---

### Phase 4: Commit Message Drafting

**Goal**: Generate commit message

**Actions**:
1. Check for custom template
2. Use template if provided
3. Otherwise use default style
4. Present suggested message

**Reference**: `references/commit-messages.md`

---

### Phase 5: Commit Execution

**Goal**: Execute commit safely

**Actions**:
1. Check if on main/master
2. Offer to create branch if needed
3. Present `git commit` command
4. **WAIT for user confirmation**

---

## Workflow: Conflict Resolution

**Reference**: `references/conflict-resolution.md`

### Phase 1: Conflict Assessment

**Goal**: Identify conflicts

**Actions**:
1. List conflicted files
2. Show conflict markers
3. Explain conflict types

---

### Phase 2: Resolution Guidance

**Goal**: Guide user through resolution

**Actions**:
1. Present resolution options
2. Show next command (--continue)
3. Summarize kept/removed per file

---

## Workflow: Rebase Operations

### Phase 1: Intent Clarification

**Goal**: Understand rebase goal

**Actions**:
1. Clarify intent (linear/squash/reorder)
2. Decide between rebase and merge
3. Check if shared branch

**CRITICAL**: If shared branch, confirm force-push allowed.

---

### Phase 2: Rebase Execution

**Goal**: Execute rebase safely

**Actions**:
1. Present `git rebase` command
2. **WAIT for confirmation**
3. Show `git log --oneline -n 5`
4. Confirm before push

---

## Workflow: Revert and Reset

### Phase 1: Operation Selection

**Goal**: Choose safe operation

**Actions**:
1. Prefer `git revert` for shared history
2. Explain reset types:
   - `--soft`: keep staged
   - `--mixed`: keep working tree
   - `--hard`: discard all (⚠️ HIGH RISK)

---

### Phase 2: Execution

**Goal**: Execute with confirmation

**Actions**:
1. Present exact command
2. **WAIT for explicit confirmation**
3. Execute
4. Verify result

**CRITICAL**: Require explicit confirmation for `reset --hard`.

---

## Output Format

```markdown
## Git Status
Branch: feature/xyz
Changes: 5 files modified

## Change Summary
- Added user authentication
- Updated API endpoints
- Fixed bug in validation

## Suggested Commit Message
feat: add user authentication

- Implement JWT-based auth
- Add login/logout endpoints
- Update validation logic

## Command
git commit -m "feat: add user authentication

- Implement JWT-based auth
- Add login/logout endpoints
- Update validation logic"

Proceed? [Y/n]
```

## Best Practices

- Always confirm before executing commands
- Show exact commands to user
- Prefer safe operations (revert over reset)
- Explain risks clearly
- Reference documentation files
