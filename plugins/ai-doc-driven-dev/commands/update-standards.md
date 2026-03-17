---
description: Check and synchronize local docs and instruction files with the plugin's latest documentation standards
category: maintenance
shortcut: "us"
model: inherit
---

# Update Documentation Standards

Check whether local `docs/` files and instruction files have drifted from the plugin's latest standards, then synchronize them after user approval.

## Description

This command helps you keep project documentation standards current by:

1. **Docs Drift Check**: Compare local `docs/**/*.md` files against the plugin's latest templates and principles
2. **Instruction File Review**: Check `CLAUDE.md`, `AGENTS.md`, and `GEMINI.md` for missing workflow rules
3. **Gap Summary**: Report outdated docs, missing principles, and candidate updates
4. **Approved Synchronization**: Apply updates across `docs/` and instruction files only after the user confirms the proposed changes

## Behavior

### Documentation Review Scope

The command reviews:

- `docs/` - All Markdown documentation under the project docs tree, including `requirements/`, `design/`, `analysis/`, `standards/`, and custom subdirectories
- `CLAUDE.md`, `AGENTS.md`, `GEMINI.md` - Workflow instruction files, when present

### Synchronization Workflow

After scanning the project:

- Compare all `docs/**/*.md` files and instruction files against the plugin's latest standards
- Highlight missing principles such as the "Visual-First Design Principles"
- Summarize which docs are outdated or incomplete
- Present proposed updates for user approval
- Update all approved `docs/` files and instruction files only after approval

## Examples

```bash
# Check current documentation standards and synchronize if needed
update-standards
```

## Output

The command reports:

```text
Documentation drift summary
- docs/requirements/20260117-enforce-doc-workflow-scan-optimization.md: missing latest visual-first guidance
- docs/design/20260117-enforce-doc-workflow-scan-optimization-technical-design.md: missing inline diff conventions
- docs/analysis/skills-optimization-analysis.md: outdated workflow terminology
- CLAUDE.md: missing current workflow principles
- AGENTS.md: already up to date

Proposed updates
- Add missing principles
- Refresh outdated docs
- Keep unchanged files untouched
```

## Relationship with update-doc-driven-dev

These two commands serve different purposes:

| Command | Focus | What it updates |
|---------|-------|-----------------|
| `update-doc-driven-dev` | **Structure** | CLAUDE.md/AGENTS.md organization, file naming conventions, directory layout |
| `update-standards` (this) | **Content** | Template compliance, missing sections, new principles in existing docs |

### Recommended Workflow After Plugin Upgrade

```bash
# Step 1: Update infrastructure and structure
update-doc-driven-dev

# Step 2: Sync content with latest templates and standards
update-standards
```

**Example**: If you updated your technical design template to require a new "Security Considerations" section:
- `update-doc-driven-dev` won't detect this (structural focus)
- `update-standards` **will detect** and suggest adding the section to existing design docs

## Related Commands

- `update-doc-driven-dev` - Update documentation infrastructure and structure (run this first)
- `init-doc-driven-dev` - Initialize documentation structure and workflow files (for new projects)
