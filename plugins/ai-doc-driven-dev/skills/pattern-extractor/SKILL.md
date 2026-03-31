---
name: pattern-extractor
description: This skill should be used when the user asks to "analyze code patterns",
"extract coding conventions", "document project standards", or discusses "codebase patterns".
allowed-tools: ["Read", "Glob", "Grep", "LSP"]
license: MIT
---

# Pattern Extractor

## Overview

Extract the dominant coding and architectural patterns from an existing codebase so they can be turned into usable standards. Focus on the patterns the team should keep repeating, the exceptions that matter, and the guidance that belongs in `docs/standards/`.

## When This Skill Applies

- User wants to document current coding conventions
- User wants standards extracted from an existing codebase
- User wants AI-generated changes to follow established patterns
- A docs-first workflow needs project-specific standards

## Workflow

### Phase 1: Codebase Shape

**Goal**: Understand the system being sampled

**Actions**:
1. Identify project type
2. Identify key frameworks
3. Identify important directories

---

### Phase 2: Dominant Patterns

**Goal**: Find what the codebase consistently does

**Actions**:
1. Extract naming patterns
2. Extract structure patterns
3. Extract API and error patterns
4. Note meaningful exceptions

**Available Assets**:
- Use repository files as the primary evidence source.
- Use LSP when it helps confirm signatures, types, or structural relationships.

---

### Phase 3: Standards Synthesis

**Goal**: Turn findings into reusable guidance

**Actions**:
1. Prioritize dominant conventions
2. Separate standards from outliers
3. Add concrete examples
4. Target `docs/standards/`

---

### Phase 4: Output

**Goal**: Produce guidance the team can follow

**Actions**:
1. Summarize recommended standards
2. Show representative examples
3. Explain notable exceptions
4. Highlight adoption priorities

## Output Format

```markdown
# Project Coding Standards

## Dominant Conventions
| Area | Recommended Standard | Evidence |
| --- | --- | --- |
| Naming | camelCase for functions and variables | dominant usage across core modules |
| Files | kebab-case | repeated across feature directories |
| Architecture | service-oriented API layer | shared pattern in main entry points |

## Exceptions to Handle Carefully
- Legacy modules still use a different naming scheme
- Test helpers use a flatter structure than production code

## Representative Examples
- `src/api/user-service.ts`
- `src/features/order-history/`
```

## Best Practices

- Prefer dominant patterns over one-off examples
- Treat exceptions as migration notes, not default standards
- Keep standards output usable for future documentation and AI guidance
- Use LSP to confirm structure when plain text search is not enough
