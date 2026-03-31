---
name: doc-workflow-enforcer
description: This skill should be used when the user asks to "setup doc-driven development",
"enforce documentation workflow", "initialize project standards", or discusses "CLAUDE.md/AGENTS.md configuration".
allowed-tools: ["Read", "Write", "Edit", "Glob"]
license: MIT
---

# Document Workflow Enforcer

## Overview

Establish or repair the instruction-file rules that make docs-first development enforceable. The core outcome is a lightweight `CLAUDE.md` for project workflow, a separate `AGENTS.md` for AI behavior rules, clear approval gates, and document naming that follows the current date-based convention.

**Warning**: This skill can write to `CLAUDE.md` and `AGENTS.md`. Always present the proposed changes and wait for explicit approval before writing.

## When This Skill Applies

- User wants to initialize docs-first development
- User wants to improve `CLAUDE.md` or `AGENTS.md`
- User wants to enforce documentation workflow rules
- User wants to separate workflow rules from AI behavior rules
- Project instructions need to align with current docs-first standards

## Workflow

### Phase 1: Instruction Surface

**Goal**: Understand the current entry files

**Actions**:
1. Check root instruction files
2. Read existing workflow rules
3. Detect mixed responsibilities
4. Detect monolithic instruction files

---

### Phase 2: Rule Alignment

**Goal**: Prepare the right workflow structure

**Actions**:
1. Keep valid project-specific rules
2. Add missing docs-first gates
3. Enforce CLAUDE/AGENTS separation
4. Apply date-based naming guidance

**Core Rules**:
- `CLAUDE.md` is the lightweight workflow entry point and document pointer hub.
- `AGENTS.md` holds AI-specific execution rules and behavior constraints.
- Requirement and technical design docs use date-based filenames.
- Documentation and approval happen before implementation.

---

### Phase 3: Approval Gate

**Goal**: Get consent before modifying instruction files

**Actions**:
1. Show proposed changes
2. Show file responsibility changes
3. Explain extracted or moved content
4. **WAIT for user approval**

---

### Phase 4: Apply and Verify

**Goal**: Write a maintainable instruction setup

**Actions**:
1. Update or create `CLAUDE.md`
2. Update or create `AGENTS.md`
3. Preserve project-specific content
4. Verify workflow clarity

## Workflow Rules Added

```markdown
## Documentation-Driven Development Workflow

### Instruction File Responsibilities

- `CLAUDE.md`: workflow entry point, project navigation, document links, high-level development rules
- `AGENTS.md`: AI behavior rules, execution constraints, approval gates, agent-specific instructions

### Development Process
1. Create or update `docs/requirements/YYYYMMDD-feature-name.md`
2. Create or update `docs/design/YYYYMMDD-feature-name-technical-design.md`
3. Get approval on the documentation
4. Implement the change

### Naming Guidance
- Use date-based filenames: `YYYYMMDD-feature-name.md`
- Handle same-day conflicts with `-v2`, `-v3`
- Keep requirement and design documents paired

### Visual-First Principle
- Use Mermaid for architecture, flow, and state diagrams
- Use Markdown tables for structured fields and configurations
- Show modifications inline in the same diagram or table
```

## Best Practices

- Read both `CLAUDE.md` and `AGENTS.md` before proposing changes
- Treat approval-before-write as a hard gate
- Preserve project-specific rules unless they directly conflict with current standards
- Keep `CLAUDE.md` small enough to stay readable as the main workflow entry
