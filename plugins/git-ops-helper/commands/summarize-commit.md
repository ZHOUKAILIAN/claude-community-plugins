---
description: Summarize current git changes and propose a commit message
category: git
shortcut: "sc"
model: inherit
---

# Summarize Commit

Summarize current working tree changes and draft a commit message.

## Usage

```bash
/summarize-commit
```

## Behavior

- Inspect `git status`, `git diff`, and `git diff --staged`.
- Distinguish staged vs unstaged changes when summarizing.
- Perform a code check on the diffs and surface issues before summarizing.
- Produce a short summary in the user’s language.
- Generate a commit message using the default style, or a user-provided template.
- If on `main` or `master`, ask whether to create a new branch before committing.
- Ask for confirmation before running `git commit`.
