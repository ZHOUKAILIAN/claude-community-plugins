---
name: structure-explainer
description: This skill should be used when the user asks to "explain codebase structure",
"understand project layout", "show project organization", or discusses "directory structure".
allowed-tools: ["Read", "Glob", "Grep", "Bash"]
license: MIT
status: enabled
---

# Structure Explainer

## Overview

Explain codebase structure and organization to help understand project layout.

## When This Skill Applies

- User wants to understand codebase structure
- User needs project organization overview
- User asks to find specific file types
- User wants navigation guidance

## Workflow

### Phase 1: Directory Scanning

**Goal**: Map project structure

**Actions**:
1. Scan directory tree
2. Identify key directories
3. List important files

---

### Phase 2: Pattern Recognition

**Goal**: Identify common patterns

**Actions**:
1. Recognize file patterns
2. Identify module types
3. Detect framework conventions

---

### Phase 3: Structure Analysis

**Goal**: Understand organization

**Actions**:
1. Analyze directory purposes
2. Map file relationships
3. Identify entry points

---

### Phase 4: Documentation

**Goal**: Explain structure

**Actions**:
1. Create structure diagram
2. Explain each section
3. Provide navigation tips

---

## Output Format

```markdown
# Project Structure Overview

## Directory Tree
```
project/
├── src/
│   ├── components/
│   ├── utils/
│   └── index.js
├── tests/
└── package.json
```

## Key Directories
- **src/**: Source code
- **tests/**: Test files
- **components/**: UI components

## Entry Points
- Main: src/index.js
- Tests: tests/index.test.js

## Navigation Tips
- Components in src/components/
- Utilities in src/utils/
```

## Best Practices

- Scan thoroughly before explaining
- Use tree diagrams for clarity
- Explain purpose of each directory
- Provide navigation guidance
