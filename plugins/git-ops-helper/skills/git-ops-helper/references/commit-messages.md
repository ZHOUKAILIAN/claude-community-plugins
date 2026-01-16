# Commit Message Guide

## Default Style (Conventional Commits)

Use this as the default when the user has not provided a custom format.

Format:
```
<type>(<scope>): <summary>

<body>

<footer>
```

Types:
- feat: new user-facing behavior
- fix: bug fix
- perf: performance change
- refactor: refactor without behavior change
- docs: documentation-only
- test: tests-only
- build: build tooling
- ci: CI configuration
- chore: maintenance changes

Rules:
- Summary is imperative, present tense, <= 72 chars.
- Scope is optional; include when a clear area exists.
- Body explains what/why, not how; include breaking changes when relevant.

## Custom Style

If the user provides a template or style guide, follow it verbatim. If the user
provides only partial guidance, ask for the missing pieces before committing.

## Examples

```
feat(git): add summarize-commit command

Explain what changed and why.
```

```
fix(rebase): handle conflict markers in helper output
```
