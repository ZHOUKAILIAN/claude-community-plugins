---
name: microfrontend-isolation-analyzer
description: This skill should be used when the user asks to "analyze microfrontend isolation",
"understand JS/CSS isolation", "compare microfrontend frameworks", or discusses
"qiankun/wujie/single-spa/emp isolation mechanisms".
allowed-tools: ["Read", "Glob", "Grep", "Bash"]
license: MIT
status: enabled
---

# Microfrontend Isolation Analyzer

## Overview

Analyze microfrontend framework source code to understand JS and CSS isolation mechanisms.

## When This Skill Applies

- User wants to understand microfrontend isolation
- User needs to compare isolation strategies
- User asks about sandbox implementations
- User wants to document isolation for learning

## Workflow

### Phase 1: Framework Detection

**Goal**: Identify microfrontend framework

**Actions**:
1. Check package.json
2. Identify framework type
3. Locate source directory

---

### Phase 2: Isolation Discovery

**Goal**: Find isolation-related code

**Actions**:
1. Search keywords (sandbox, shadow, scope, isolate)
2. Locate core files
3. Identify entry points

---

### Phase 3: Mechanism Analysis

**Goal**: Understand implementation

**Actions**:
1. Analyze JS isolation (sandbox, proxy, scope)
2. Analyze CSS isolation (shadow DOM, scoped CSS)
3. Map dependencies
4. Identify trade-offs

---

### Phase 4: Report Generation

**Goal**: Create comprehensive report

**Actions**:
1. Generate PlantUML diagram
2. Document mechanisms
3. Provide code examples
4. Create bilingual report (EN/CN)

**CRITICAL**: Report MUST include all required sections.

---

## Required Report Structure

```markdown
# [Framework] Isolation Mechanism Analysis

## 1. Overall Structure
[PlantUML diagram]

## 2. Framework Information
- Name & Version
- Isolation Strategy
- Key Features

## 3. JavaScript Isolation
### Core Files
### Mechanisms
### Code Snippets
### Trade-offs

## 4. CSS Isolation
### Core Files
### Mechanisms
### Code Snippets
### Trade-offs

## 5. Summary & Insights
### Overall Assessment
### Comparison Points
### Best Practices
```

## Output Format

**English Version**: `[framework]-isolation-analysis-en.md`
**Chinese Version**: `[framework]-isolation-analysis-zh.md`

## Best Practices

- Search thoroughly before analyzing
- Use PlantUML for architecture
- Include actual code snippets
- Provide bilingual reports
- Document trade-offs clearly
