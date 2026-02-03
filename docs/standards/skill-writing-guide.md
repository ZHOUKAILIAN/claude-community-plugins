# Skill 写作指南

## 简洁原则

**核心理念**：说做什么，不说怎么做

## 标准模板

```markdown
---
name: skill-name
description: This skill should be used when the user asks to "phrase1", "phrase2", or discusses topic.
allowed-tools: [...]
license: MIT
---

# Skill Name

## Overview

One-line or brief description of what this skill does.

## When This Skill Applies

- Trigger scenario 1
- Trigger scenario 2
- Trigger scenario 3

## Workflow

### Phase 1: Name

**Goal**: One-line goal

**Actions**:
1. Step 1 (≤10 words)
2. **Critical step** (bold)
3. Step 3

---

### Phase 2: Name

**Goal**: One-line goal

**Actions**:
1. Step 1
2. Step 2

---

## Output Format

```markdown
Expected output template
```

## Best Practices

- Practice 1
- Practice 2
```

## 对比示例

### ❌ 啰嗦版本

```markdown
---
name: doc-generator
description: |
  Generate standardized project documentation based on templates and project analysis.
  Use when you need to "generate project docs", "create documentation", or "setup project documentation structure".
---

## How It Works

1. **Template Selection**: Chooses appropriate documentation templates based on project type and requirements
2. **Project Analysis Integration**: Uses extracted patterns and project characteristics to populate templates
3. **Intelligent Content Generation**: Creates project-specific content while maintaining standardized structure
4. **Documentation Structure Creation**: Establishes complete docs/ directory hierarchy with proper organization
5. **Metadata Management**: Adds appropriate frontmatter and version information to all generated documents

### Example 1: Complete Documentation Setup

User request: "Generate complete documentation structure for our React TypeScript project"

The skill will:
1. Create docs/ directory with requirements/, design/, standards/, and analysis/ subdirectories
2. Generate project-specific requirements documentation based on existing code analysis
3. Create technical design documents reflecting current architecture and patterns
4. Produce coding standards documentation based on extracted project conventions
5. Add appropriate frontmatter and metadata to all generated documents
```

**问题**：
- Description 未使用引号包裹触发短语
- 步骤描述过长（"Chooses appropriate documentation templates based on project type and requirements"）
- Example 使用教学式（"The skill will..."）
- 每个步骤都包含过多细节

### ✅ 简洁版本

```markdown
---
name: doc-generator
description: This skill should be used when the user asks to "generate project docs",
"create documentation", or discusses "documentation setup".
allowed-tools: ["Read", "Write", "Glob", "Grep", "Bash"]
license: MIT
---

# Document Generator

## Overview

Generate standardized project documentation using templates and project analysis.

## When This Skill Applies

- User requests to generate missing documentation
- User wants to create documentation structure
- User needs to update documentation standards

## Workflow

### Phase 1: Analysis

**Goal**: Understand project and documentation needs

**Actions**:
1. Determine project type
2. Identify missing documents
3. Select templates

---

### Phase 2: Document Creation

**Goal**: Generate numbered documents

**Actions**:
1. **Scan existing document numbers**
2. **Calculate next number**
3. Create paired documents
4. Populate using templates

**Critical**: Ensure filename number matches title number.

---

### Phase 3: Verification

**Goal**: Validate generated documents

**Actions**:
1. Verify numbering consistency
2. Verify pairing
3. Report to user

---

## Output Format

```markdown
✅ Documents Created

**Requirement**: docs/requirements/009-feature-name.md
**Design**: docs/design/009-feature-name-technical-design.md
**Number**: 009

✅ Numbering verified
✅ Pairing verified
```

## Best Practices

- Use standardized templates
- Generate meaningful content
- Ensure proper numbering
- Integrate with existing structure
```

**优点**：
- Description 使用引号包裹触发短语
- 每步 ≤5 词
- 使用指令式（Determine, Identify, Select）
- 关键步骤用粗体
- 包含明确的输出格式

## 写作清单

创建 Skill 时检查：

- [ ] Description 使用引号包裹触发短语
- [ ] 包含 "Overview" 章节（简短说明）
- [ ] 包含 "When This Skill Applies" 章节
- [ ] 使用 Phase 结构（`---` 分隔）
- [ ] 每个 Phase 有 Goal
- [ ] Actions ≤4 个步骤
- [ ] 每步 ≤10 词
- [ ] 关键步骤用粗体
- [ ] 包含输出格式模板
- [ ] 包含 Best Practices

## 常见错误

| 错误 | 示例 | 修正 |
|------|------|------|
| Description 无引号 | 'Use when you need to generate docs' | 'when the user asks to "generate docs"' |
| 教学式描述 | "The skill will analyze..." | "Analyze..." |
| 步骤过长 | "Chooses appropriate documentation templates based on project type" | "Select templates" |
| 缺少 When 章节 | 直接进入 How It Works | 添加 "When This Skill Applies" |
| Example 过于详细 | "The skill will: 1. Create... 2. Generate... 3. Produce..." | 使用 Phase 结构代替 |

## Description 字段最佳实践

### ❌ 错误写法

```yaml
description: |
  Generate standardized project documentation based on templates and project analysis.
  Use when you need to generate project docs, create documentation, or setup project documentation structure.
```

**问题**：
- 未使用引号包裹触发短语
- 过于啰嗦

### ✅ 正确写法

```yaml
description: This skill should be used when the user asks to "generate project docs",
"create documentation", "setup documentation structure", or discusses "documentation workflow".
```

**优点**：
- 使用标准格式："This skill should be used when..."
- 引号包裹具体触发短语
- 简洁明了
