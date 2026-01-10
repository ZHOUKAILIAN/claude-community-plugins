# Claude Code 技能文档标准模板

## 模板结构

### 1. Frontmatter（前置元数据）

```yaml
---
name: skill-name
description: |
  简洁的技能描述，说明核心功能。
  使用触发关键词："当用户需要...", "用于...", "构建..."等
allowed-tools: ["Read", "Write", "Edit", "Grep", "Glob", "Bash"]
license: MIT
---
```

### 2. Overview（概述）

**目的**：用1-2段话概括技能的核心价值和能力

**模板**：
```markdown
## Overview

This skill empowers Claude to [核心能力描述]. It leverages [关键技术/方法] to [具体功能], enabling [最终价值/结果].
```

### 3. How It Works（工作原理）

**目的**：详细说明技能的执行步骤和内部机制

**模板**：
```markdown
## How It Works

1. **[步骤1名称]**: [具体描述]
2. **[步骤2名称]**: [具体描述]
3. **[步骤3名称]**: [具体描述]
4. **[步骤N名称]**: [具体描述]
```

### 4. When to Use This Skill（使用场景）

**目的**：明确技能的激活条件和适用场景

**模板**：
```markdown
## When to Use This Skill

This skill activates when you need to:
- [使用场景1]
- [使用场景2]
- [使用场景3]
- [使用场景N]
```

### 5. Examples（示例）

**目的**：通过具体示例展示技能的实际应用

**模板**：
```markdown
## Examples

### Example 1: [示例标题]

User request: "[具体的用户请求]"

The skill will:
1. [技能执行的具体步骤1]
2. [技能执行的具体步骤2]
3. [技能执行的具体步骤3]

### Example 2: [示例标题]

User request: "[具体的用户请求]"

The skill will:
1. [技能执行的具体步骤1]
2. [技能执行的具体步骤2]
3. [技能执行的具体步骤3]
```

### 6. Best Practices（最佳实践）- 可选

**模板**：
```markdown
## Best Practices

- **[实践要点1]**: [具体建议]
- **[实践要点2]**: [具体建议]
- **[实践要点3]**: [具体建议]
```

### 7. Integration（集成说明）- 可选

**模板**：
```markdown
## Integration

This skill integrates seamlessly with [相关技术/插件], allowing you to [集成价值]. It leverages [技术栈] for [技术优势].
```

## 完整示例模板

```markdown
---
name: example-skill
description: |
  简洁的技能描述，说明核心功能。
  触发条件："当用户需要...", "用于..."
allowed-tools: ["Read", "Write", "Edit"]
license: MIT
---

## Overview

This skill empowers Claude to [核心能力]. It leverages [技术方法] to [具体功能], enabling [最终价值].

## How It Works

1. **[步骤1]**: [描述]
2. **[步骤2]**: [描述]
3. **[步骤3]**: [描述]

## When to Use This Skill

This skill activates when you need to:
- [场景1]
- [场景2]
- [场景3]

## Examples

### Example 1: [标题]

User request: "[用户请求]"

The skill will:
1. [执行步骤1]
2. [执行步骤2]
3. [执行步骤3]

### Example 2: [标题]

User request: "[用户请求]"

The skill will:
1. [执行步骤1]
2. [执行步骤2]
3. [执行步骤3]

## Best Practices

- **[要点1]**: [建议]
- **[要点2]**: [建议]

## Integration

This skill integrates with [相关技术], enabling [集成价值].
```

## 关键要求总结

### ✅ 必须包含的部分
1. **Frontmatter** - 技能元数据
2. **Overview** - 核心价值概述
3. **How It Works** - 工作原理
4. **When to Use This Skill** - 使用场景
5. **Examples** - 具体示例（至少2个）

### 🔄 可选的部分
1. **Best Practices** - 最佳实践建议
2. **Integration** - 集成说明

### 📝 写作要求
- **简洁明了**：每个部分都要言简意赅
- **具体可操作**：示例要具体，步骤要清晰
- **用户导向**：从用户使用角度组织内容
- **一致性**：所有技能文档遵循相同结构