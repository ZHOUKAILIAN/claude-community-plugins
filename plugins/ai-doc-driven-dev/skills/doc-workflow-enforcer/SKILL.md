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
4. **Check for monolithic anti-pattern**: Detect if `CLAUDE.md` contains detailed coding standards, project structure descriptions, or testing guidelines (indicators of bloated single-file design)
5. **Validate responsibility separation**: Verify that `CLAUDE.md` serves as lightweight workflow entry point with document pointers, while `AGENTS.md` (if exists) manages AI agent behavior rules

---

### Phase 2: Content Preparation

**Goal**: Prepare workflow rules and identify necessary refactoring

**Actions**:
1. Reuse existing workflow content when already present
2. Add missing workflow sections when absent
3. Add date-based naming system rules
4. Add AI automation instructions
5. Preserve existing project-specific content
6. **If monolithic pattern detected**: Prepare recommendations to extract detailed content (coding standards, architecture details, testing guidelines) into separate files under `docs/standards/` or `docs/analysis/`, leaving only pointers in `CLAUDE.md`
7. **If AGENTS.md missing but AI rules exist in CLAUDE.md**: Prepare to split AI-specific instructions into separate `AGENTS.md`

**Critical**: Never overwrite project-specific content. When suggesting decoupling, preserve all information by moving (not deleting) content to appropriate locations.

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

**Goal**: Update instruction file(s) with modern lightweight standards

**Actions**:
1. If either file already contains valid workflow, keep and reuse it
2. If missing, add workflow rules to available file(s)
3. If both missing, create one instruction file and add rules
4. **Apply decoupling recommendations**:
   - If `CLAUDE.md` is bloated with detailed standards, suggest or execute extraction to `docs/standards/coding-conventions.md`, `docs/standards/architecture.md`, etc.
   - Update `CLAUDE.md` to reference these external documents via links
   - Ensure `CLAUDE.md` remains as a lightweight "workflow entry point and document pointer hub"
5. **Enforce AGENTS.md separation**:
   - If AI agent rules are mixed into `CLAUDE.md`, extract them to `AGENTS.md`
   - Ensure clear responsibility: `CLAUDE.md` for development workflow, `AGENTS.md` for AI behavior
6. Verify file integrity
7. Report completion with summary of decoupling actions taken

---

## Workflow Rules Added

```markdown
## Documentation-Driven Development Workflow

### Instruction File Standards (Decoupling Principle)

**CLAUDE.md should be lightweight**:
- ✅ Acts as workflow entry point and document pointer hub
- ✅ Contains only high-level project overview and workflow rules
- ✅ References detailed content via links to `docs/` subdirectories
- ❌ Should NOT contain detailed coding standards, architecture descriptions, or testing guidelines inline

**AGENTS.md manages AI behavior**:
- ✅ Dedicated file for AI agent instructions and system prompts
- ✅ Separate from development workflow concerns
- ❌ AI rules should NOT be mixed into CLAUDE.md

**Anti-pattern detection**:
If `CLAUDE.md` contains sections like "Project Structure", "Coding Standards", "Testing Guidelines" with detailed content (>100 lines), this is a **monolithic anti-pattern** requiring refactoring:
1. Extract detailed content to `docs/standards/` or `docs/analysis/`
2. Replace with pointers: "See [Coding Standards](docs/standards/coding-conventions.md)"
3. Keep `CLAUDE.md` focused on workflow and navigation

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

### Visual-First Design Principles
- ✅ **REQUIRED**: Technical designs and requirements MUST prioritize visual representations over long text descriptions.
- ✅ **REQUIRED**: System architectures, data flows, and state transitions MUST be represented using Mermaid diagrams (`flowchart`, `sequenceDiagram`, `classDiagram`, etc.).
- ✅ **REQUIRED**: Database schemas and entity relationships MUST be represented using Mermaid ER diagrams (`erDiagram`).
- ✅ **REQUIRED**: Data structures, API parameters, and configuration enumerations MUST use Markdown Tables, not lists.
- ✅ **REQUIRED**: When documenting technical modifications, differences MUST be shown inline within the same diagram or table (e.g., using `~~strikethrough~~` or HTML tags in tables, or `style`/`classDef` node coloring in Mermaid). Do not create separate "Before" and "After" views.
```

## Best Practices

- Always read existing `CLAUDE.md` and `AGENTS.md` first
- Preserve project-specific information
- Use clear, unambiguous language
- Include explicit prohibitions
- Add approval gates for all phases
