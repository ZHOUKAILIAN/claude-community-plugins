---
description: Enforce documentation-first workflow before allowing code changes
category: workflow
shortcut: "edw"
model: inherit
---

# Enforce Documentation Workflow

Enable documentation-first workflow enforcement for code change requests.

## Description

This command enforces the workflow:

1. Requirement document → Technical design → Coding
2. Code changes must align with the technical design
3. If plans and changes diverge, update the documents first

## Usage

```bash
claude enforce-doc-workflow
```

## Behavior

- Enter enforcement mode and intercept code change requests.
- Detect intent (feature/bugfix/refactor) and required documents.
- Check for required docs under `docs/requirements/`.
- If missing, guide the user to create requirement and technical design docs.
- Use templates from `docs/standards/requirements-template.md` and `docs/standards/technical-design-template.md`.
- Enforce the workflow: requirement → technical design → coding.
- Require all code changes to align with the technical design and update docs when changes diverge.
- Require a plan-to-code consistency check before any code changes proceed.
- Check for mismatch between plans and code changes before proceeding.
- Allow code changes only after documents are confirmed.

## Examples

```bash
# Enable documentation-first enforcement
claude enforce-doc-workflow
```

## Related Commands

- `init-doc-driven-dev` - Initialize documentation structure and templates
- `analyze-docs` - Analyze documentation completeness
- `extract-patterns` - Extract coding patterns from codebase
