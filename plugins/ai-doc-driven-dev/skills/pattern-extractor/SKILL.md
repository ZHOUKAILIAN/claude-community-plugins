---
name: pattern-extractor
description: This skill should be used when the user asks to "analyze code patterns",
"extract coding conventions", "document project standards", or discusses "codebase patterns".
allowed-tools: ["Read", "Glob", "Grep", "LSP"]
license: MIT
---

# Pattern Extractor

## Overview

Extract project-specific coding patterns, conventions, and standards from existing codebase.

## When This Skill Applies

- User requests to document existing coding standards
- User wants to extract patterns from codebase
- User needs project-specific development guidelines
- AI code generation needs to follow established patterns

## Workflow

### Phase 1: Codebase Analysis

**Goal**: Understand project structure and type

**Actions**:
1. Detect project type (frontend/backend/fullstack)
2. Identify frameworks and libraries
3. Scan file organization

---

### Phase 2: Pattern Extraction

**Goal**: Identify common patterns

**Actions**:
1. Extract naming conventions
2. Identify architectural patterns
3. Analyze API design patterns
4. Document error handling

**Tools**: Use LSP for deep code analysis when available.

---

### Phase 3: Frequency Analysis

**Goal**: Prioritize dominant patterns

**Actions**:
1. Count pattern occurrences
2. Calculate percentages
3. Rank by frequency

**Example**:
- camelCase: 127 (85%) ← Recommend
- snake_case: 18 (12%)
- PascalCase: 5 (3%)

---

### Phase 4: Documentation Generation

**Goal**: Create standards document

**Actions**:
1. Generate coding standards
2. Include code examples
3. Provide usage statistics
4. Save to docs/standards/

---

## LSP Tool Usage

When available, use LSP for:

**TypeScript/JavaScript**:
- Type definitions extraction
- Interface pattern recognition
- Import/export analysis

**Python**:
- Class/function signatures
- Type annotation patterns
- Decorator usage

**Go**:
- Interface patterns
- Error handling conventions
- Package structure

## Output Format

```markdown
# Project Coding Standards

## Naming Conventions
- **Variables**: camelCase (85% usage)
- **Functions**: camelCase (90% usage)
- **Classes**: PascalCase (100% usage)

## Architectural Patterns
- **Component Structure**: Flat organization
- **State Management**: Context API (primary)
- **API Communication**: Axios with interceptors

## Examples
[Code examples from codebase]
```

## Best Practices

- Prioritize patterns by frequency (>70% usage)
- Consider framework conventions
- Include concrete code examples
- Document rationale for recommendations
