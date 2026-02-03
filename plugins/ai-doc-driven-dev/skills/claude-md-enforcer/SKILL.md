---
name: claude-md-enforcer
description: This skill should be used when the user asks to "setup doc-driven development",
"enforce documentation workflow", "initialize project standards", or discusses "CLAUDE.md configuration".
allowed-tools: ["Read", "Write", "Edit", "Glob"]
license: MIT
---

# CLAUDE.md Enforcer

## Overview

Enforce documentation-driven development workflow in CLAUDE.md with mandatory docs-first process.

**Warning**: This skill can write to CLAUDE.md files. Always presents changes for user approval first.

## When This Skill Applies

- User requests to initialize documentation-driven development
- User wants to enforce documentation workflow
- User asks to update or improve CLAUDE.md
- User mentions "documentation-first" or "docs-before-code"
- Project needs documentation workflow enforcement

## Workflow

### Phase 1: Detection

**Goal**: Locate and analyze CLAUDE.md

**Actions**:
1. Check for CLAUDE.md in project root
2. Read current content (if exists)
3. Identify missing workflow sections

---

### Phase 2: Content Preparation

**Goal**: Prepare workflow rules

**Actions**:
1. Create documentation workflow section
2. Add numbering system rules
3. Add AI automation instructions
4. Preserve existing content

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

**Goal**: Update CLAUDE.md

**Actions**:
1. Apply approved changes
2. Verify file integrity
3. Report completion

---

## Workflow Rules Added

```markdown
## Documentation-Driven Development Workflow

### Development Process
1. Create requirement document (REQ-NNN)
2. Create technical design (DESIGN-NNN)
3. Get approval
4. Implement code

❌ PROHIBITED: Direct code implementation without documentation

### Document Numbering System
- File format: NNN-feature-name.md
- Title format: # REQ-NNN: Feature Name
- AI auto-assigns numbers by scanning docs/requirements/

### AI Automation
When creating documents, AI MUST:
1. Scan existing numbers
2. Calculate next number
3. Create paired documents
4. Verify consistency
```

## Best Practices

- Always read existing CLAUDE.md first
- Preserve project-specific information
- Use clear, unambiguous language
- Include explicit prohibitions
- Add approval gates for all phases
