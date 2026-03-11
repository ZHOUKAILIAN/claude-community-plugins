---
name: doc-workflow-enforcer
description: This skill should be used when the user asks to "setup doc-driven development",
"enforce documentation workflow", "initialize project standards", or discusses "CLAUDE.md/AGENTS.md configuration".
allowed-tools: ["Read", "Write", "Edit", "Glob"]
license: MIT
---

# Document Workflow Enforcer

## Overview

Enforce documentation-driven development workflow in instruction files with mandatory docs-first process.

**Warning**: This skill can write to `CLAUDE.md` and `AGENTS.md`. Always presents changes for user approval first.

## When This Skill Applies

- User requests to initialize documentation-driven development
- User wants to enforce documentation workflow
- User asks to update or improve CLAUDE.md / AGENTS.md
- User mentions "documentation-first" or "docs-before-code"
- Project needs documentation workflow enforcement

## Workflow

### Phase 1: Detection

**Goal**: Locate and analyze workflow instruction files

**Actions**:
1. Check for `CLAUDE.md` and `AGENTS.md` in project root
2. Read existing file(s), if present
3. Identify whether documentation-driven workflow already exists

---

### Phase 2: Content Preparation

**Goal**: Prepare workflow rules

**Actions**:
1. Reuse existing workflow content when already present
2. Add missing workflow sections when absent
3. Add date-based naming system rules
4. Add AI automation instructions
5. Preserve existing project-specific content

**Critical**: Never overwrite project-specific content.

---

### Phase 3: User Approval

**Goal**: Get user confirmation

**Actions**:
1. **Present proposed changes**
2. **Show what will be added**
3. **WAIT for user approval**

**DO NOT proceed without approval.**

---

### Phase 4: Application

**Goal**: Update instruction file(s)

**Actions**:
1. If either file already contains valid workflow, keep and reuse it
2. If missing, add workflow rules to available file(s)
3. If both missing, create one instruction file and add rules
4. Verify file integrity
5. Report completion

---

## Workflow Rules Added

```markdown
## Documentation-Driven Development Workflow

### Development Process
1. Create requirement document (REQ-YYYYMMDD)
2. Create technical design (TECH-YYYYMMDD)
3. Get approval
4. Implement code

❌ PROHIBITED: Direct code implementation without documentation

### Document Naming System (Date-Based)
- Requirement: docs/requirements/YYYYMMDD-feature-name.md
- Design: docs/design/YYYYMMDD-feature-name-technical-design.md
- Title format: # REQ-YYYYMMDD / # TECH-YYYYMMDD
- AI uses current date directly; no sequence scan required
- Same-day same-name conflicts: append -v2 / -v3

### AI Automation
When creating documents, AI MUST:
1. Use current date in YYYYMMDD format
2. Check same-day same-name collision
3. Create paired documents
4. Verify consistency
```

## Best Practices

- Always read existing `CLAUDE.md` and `AGENTS.md` first
- Preserve project-specific information
- Use clear, unambiguous language
- Include explicit prohibitions
- Add approval gates for all phases
