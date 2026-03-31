---
name: doc-detector
description: This skill should be used when the user asks to "analyze project documentation",
"check doc completeness", "assess documentation status", or discusses "documentation quality".
allowed-tools: ["Read", "Glob", "Grep"]
license: MIT
---

# Documentation Detector

## Overview

Assess whether a project's documentation is usable for docs-first development. Focus on coverage, pairing, naming consistency, and the most important gaps the user should resolve before implementation.

## When This Skill Applies

- User wants to assess documentation readiness
- User wants to identify missing or outdated docs
- User wants to check requirement/design pairing
- User needs a docs-first gap summary before changing code

## Workflow

### Phase 1: Discovery

**Goal**: Understand the current documentation surface

**Actions**:
1. Scan `docs/` and root instruction files
2. Identify document categories
3. Note major missing areas

---

### Phase 2: Standards Alignment

**Goal**: Check docs against current project rules

**Actions**:
1. Verify date-based naming
2. Verify requirement/design pairing
3. Check template-shaped sections
4. Flag legacy numbering drift

**Reference Assets**:
- Current requirement and design templates live in the plugin's `knowledge/templates/` directory.
- Project-level standards usually live under `docs/standards/`.

---

### Phase 3: Gap Assessment

**Goal**: Identify the highest-value problems

**Actions**:
1. Highlight missing pairs
2. Highlight inconsistent naming
3. Highlight incomplete core docs
4. Prioritize user-facing risks

---

### Phase 4: Report

**Goal**: Give the user an actionable status summary

**Actions**:
1. Summarize current state
2. List critical gaps
3. Suggest next actions
4. **WAIT for user decision**

## Output Format

```markdown
# Documentation Analysis Report

## Summary
- Documentation readiness: Partial
- Critical gaps: 2
- Highest risk: Missing technical design for an active requirement

## Naming & Pairing
- Expected naming: `docs/requirements/YYYYMMDD-feature-name.md`
- Expected pairing: requirement document ↔ technical design document
- Legacy sequential naming detected in existing docs
- Missing pair: `docs/requirements/20260331-marketplace-consistency-optimization.md`

## Priority Actions
1. Create the missing technical design pair
2. Rename or retire legacy sequential-numbered docs
3. Fill required sections in incomplete docs
```

## Best Practices

- Keep analysis read-only unless the user asks for generation
- Treat legacy numbering as drift, not as the default standard
- Focus on the few gaps that block safe implementation
- Present recommendations in execution order
