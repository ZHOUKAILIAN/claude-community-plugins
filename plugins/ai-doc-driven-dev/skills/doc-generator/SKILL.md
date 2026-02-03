---
name: doc-generator
description: This skill should be used when the user asks to "generate project docs",
"create documentation", "setup documentation structure", or discusses "missing documentation".
allowed-tools: ["Read", "Write", "Glob", "Grep", "Bash"]
license: MIT
---

# Document Generator

## Overview

Generate standardized project documentation using templates and project analysis.

## When This Skill Applies

- User requests to generate missing documentation
- User wants to create documentation structure for new projects
- User needs to update documentation to follow current standards
- Documentation-driven development setup requires initial documents

## Workflow

### Phase 1: Analysis

**Goal**: Understand project and documentation needs

**Actions**:
1. Determine project type
2. Identify missing documents
3. Select appropriate templates

---

### Phase 2: Document Creation

**Goal**: Generate numbered documents

**Actions**:
1. **Scan existing document numbers**
2. **Calculate next number**
3. Create paired documents
4. Populate using templates

**Critical**: Ensure filename number matches title number.

---

### Phase 3: Verification

**Goal**: Validate generated documents

**Actions**:
1. Verify numbering consistency
2. Verify pairing (requirement ↔ design)
3. Check placeholders replaced
4. Report to user

---

## Output Format

```markdown
✅ Documents Created

**Requirement**: docs/requirements/009-feature-name.md
**Design**: docs/design/009-feature-name-technical-design.md
**Number**: 009

✅ Numbering verified
✅ Pairing verified
```

## Best Practices

- Use standardized templates for consistency
- Generate meaningful content, not placeholders
- Ensure proper numbering and pairing
- Integrate with existing documentation structure
