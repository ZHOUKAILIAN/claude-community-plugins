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

### Scan Confirmation

Before entering enforcement mode, the command will ask if you want to scan the repository:

- **Scan Purpose**: Check documentation completeness and project status
- **Scan Scope**:
  - `docs/requirements/` - Requirement documents
  - `docs/standards/` - Project standards and templates
  - `CLAUDE.md` - Workflow enforcement configuration

**User Options**:
- **Yes**: Perform full repository scan (recommended if docs changed)
- **No**: Skip scan and enter enforcement mode directly (faster if docs unchanged)

**Command Line Parameter**:
- `--scan=yes`: Skip prompt and scan automatically
- `--scan=no`: Skip prompt and don't scan
- No parameter: Ask user (default)

### Enforcement Workflow

After scan decision:
- Enter enforcement mode and intercept code change requests
- Detect intent (feature/bugfix/refactor) and required documents
- If scan was performed: Use scan results to check for missing docs
- If scan was skipped: Check for docs on-demand when needed
- Guide the user to create missing documents using templates from `docs/standards/requirements-template.md` and `docs/standards/technical-design-template.md`
- Enforce the workflow: requirement → technical design → coding
- Require all code changes to align with the technical design and update docs when changes diverge
- Require a plan-to-code consistency check before any code changes proceed
- Allow code changes only after documents are confirmed

## Examples

### Example 1: Interactive Mode (Default)

```bash
# Command prompts for scan decision
claude enforce-doc-workflow

# Output:
# 📋 Documentation Scan
#
#    The scan will check:
#    • docs/requirements/ - Requirement documents
#    • docs/standards/ - Project standards
#    • CLAUDE.md - Workflow enforcement
#
# ❓ Do you want to scan the repository?
#    [Y] Yes - Scan now (recommended if docs changed)
#    [N] No - Skip scan (faster, if docs unchanged)
#
# Your choice [Y/n]:
```

### Example 2: Auto-scan Mode

```bash
# Skip prompt and scan automatically
claude enforce-doc-workflow --scan=yes
```

### Example 3: Skip Scan Mode

```bash
# Skip prompt and don't scan
claude enforce-doc-workflow --scan=no
```

## Related Commands

- `init-doc-driven-dev` - Initialize documentation structure and templates
- `analyze-docs` - Analyze documentation completeness
- `extract-patterns` - Extract coding patterns from codebase
