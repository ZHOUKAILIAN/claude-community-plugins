---
name: doc-generator
description: This skill should be used when the user asks to "generate project docs",
"create documentation", "setup documentation structure", or discusses "missing documentation".
allowed-tools: ["Read", "Write", "Glob", "Grep", "Bash"]
license: MIT
---

# Document Generator

## Overview

Create requirement and technical design documents that match the project's current docs-first standard. Focus on producing correctly named, correctly paired, template-aligned documents that are ready for review instead of placeholder scaffolds.

## When This Skill Applies

- User requests missing requirement or design docs
- User wants to create a docs-first structure in a new project
- User wants to generate paired documents from current templates
- Documentation analysis found concrete gaps to fill

## Workflow

### Phase 1: Generation Scope

**Goal**: Decide what must be created

**Actions**:
1. Confirm the target feature
2. Identify required document types
3. Check existing paired docs

---

### Phase 2: Template Alignment

**Goal**: Use the current project shapes

**Actions**:
1. Read active templates
2. Reuse project naming rules
3. Reuse project-specific context

**Reference Assets**:
- Requirement and technical design templates live in the plugin's `knowledge/templates/` directory.
- Project-specific standards usually live under `docs/standards/`.

---

### Phase 3: Document Creation

**Goal**: Produce correct paired documents

**Actions**:
1. Use current date naming
2. Create requirement/design pair
3. Apply same-day suffixes when needed
4. Replace placeholders with real content

**Critical**: The generated filenames, document IDs, and paired relationship must agree with each other.

---

### Phase 4: Validation

**Goal**: Confirm the output is reviewable

**Actions**:
1. Verify naming consistency
2. Verify pairing consistency
3. Verify template completion
4. Report created files

## Output Format

```markdown
✅ Documents Created

**Requirement**: docs/requirements/20260331-feature-name.md
**Design**: docs/design/20260331-feature-name-technical-design.md
**Naming Rule**: date-based
**Pairing**: verified

Next step: review and approve the documents before implementation.
```

## Best Practices

- Generate requirement and technical design docs together unless the user requests otherwise
- Use date-based naming by default: `YYYYMMDD-feature-name.md`
- Treat `-v2` / `-v3` as same-day conflict handling, not as a versioning shortcut
- Prefer meaningful project-specific content over empty scaffolds
