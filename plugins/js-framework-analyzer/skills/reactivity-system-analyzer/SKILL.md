---
name: reactivity-system-analyzer
description: This skill should be used when the user asks to "analyze reactivity system",
"understand framework reactivity", "compare reactivity implementations", or discusses
"Vue/React/SolidJS/Svelte reactivity".
allowed-tools: ["Read", "Glob", "Grep", "Bash"]
license: MIT
status: enabled
---

# Reactivity System Analyzer

## Overview

Analyze frontend framework source code to understand reactivity system implementation.

## When This Skill Applies

- User wants to understand framework reactivity
- User needs to compare reactivity implementations
- User asks about reactive programming patterns
- User wants to document reactivity for learning

## Workflow

### Phase 1: Framework Detection

**Goal**: Identify framework and version

**Actions**:
1. Check package.json
2. Identify framework type
3. Locate source directory

---

### Phase 2: Reactivity Discovery

**Goal**: Find reactivity-related code

**Actions**:
1. Search for keywords (reactive, effect, watch, proxy, observable)
2. Locate core files
3. Identify entry points

---

### Phase 3: Code Analysis

**Goal**: Understand implementation

**Actions**:
1. Map file dependencies
2. Analyze call relationships
3. Extract core mechanisms
4. Identify trade-offs

---

### Phase 4: Report Generation

**Goal**: Create comprehensive report

**Actions**:
1. Generate PlantUML diagram
2. Document implementation
3. Provide code examples
4. Create bilingual report (EN/CN)

**CRITICAL**: Report MUST include all required sections.

---

## Required Report Structure

```markdown
# [Framework] Reactivity System Analysis

## 1. Overall Structure

[PlantUML diagram showing architecture]

## 2. Framework Information
- Name & Version
- Reactivity Model
- Key Features

## 3. Reactivity Implementation
### Core Files
[List with descriptions]

### Mechanisms
[Implementation details]

### Code Snippets
[Key code examples]

### Trade-offs
[Design decisions]

## 4. Component Update Mechanism
### Dependency Tracking
[How dependencies tracked]

### Update Triggering
[How updates triggered]

### Batch Updates
[Optimization strategies]

## 5. Summary & Insights
### Overall Assessment
[Key characteristics]

### Comparison Points
[Unique aspects]

### Best Practices
[Usage recommendations]
```

## Output Format

**English Version**: `[framework]-reactivity-analysis-en.md`
**Chinese Version**: `[framework]-reactivity-analysis-zh.md`

## Best Practices

- Search thoroughly before analyzing
- Use PlantUML for structure diagrams
- Include actual code snippets
- Provide bilingual reports
- Document trade-offs and design decisions
