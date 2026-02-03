---
name: ai-platform-analyzer
description: This skill should be used when the user asks to "analyze AI platform",
"understand platform architecture", "compare AI platforms", or discusses
"Coze/Dify/FastGPT platform implementation".
allowed-tools: ["Read", "Glob", "Grep", "Bash"]
license: MIT
status: disabled
---

# AI Platform Analyzer

## Overview

Analyze AI application platform source code to understand architecture and core functionality.

## When This Skill Applies

- User wants to understand AI platform architecture
- User needs to compare AI platforms
- User asks about platform implementations
- User wants to document platform for learning

## Workflow

### Phase 1: Platform Detection

**Goal**: Identify platform and version

**Actions**:
1. Check package.json/requirements.txt
2. Identify platform type
3. Locate source directory

---

### Phase 2: Architecture Discovery

**Goal**: Find core components

**Actions**:
1. Search keywords (agent, workflow, tool, plugin)
2. Locate core files
3. Identify entry points

---

### Phase 3: Feature Analysis

**Goal**: Understand implementation

**Actions**:
1. Analyze workflow engine
2. Analyze tool/plugin system
3. Map dependencies
4. Identify trade-offs

---

### Phase 4: Report Generation

**Goal**: Create comprehensive report

**Actions**:
1. Generate PlantUML diagram
2. Document architecture
3. Provide code examples
4. Create bilingual report (EN/CN)

**CRITICAL**: Report MUST include all required sections.

---

## Required Report Structure

```markdown
# [Platform] Architecture Analysis

## 1. Overall Structure
[PlantUML diagram]

## 2. Platform Information
- Name & Version
- Architecture Model
- Key Features

## 3. Core Components
### Workflow Engine
### Tool/Plugin System
### Agent Management
### Code Snippets
### Trade-offs

## 4. Integration Mechanisms
### API Design
### Extension Points
### Data Flow

## 5. Summary & Insights
### Overall Assessment
### Comparison Points
### Best Practices
```

## Output Format

**English Version**: `[platform]-architecture-analysis-en.md`
**Chinese Version**: `[platform]-architecture-analysis-zh.md`

## Best Practices

- Search thoroughly before analyzing
- Use PlantUML for architecture
- Include actual code snippets
- Provide bilingual reports
- Document extension points clearly
