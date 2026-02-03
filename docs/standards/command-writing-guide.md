# Command 写作指南

## 简洁原则

**核心理念**：说做什么，不说怎么做

## 标准模板

```markdown
---
description: One-line description
category: category
shortcut: "xx"
allowed-tools: [...]
---

# Command Name

One-line description.

## Context

- Info 1: !`command1`
- Info 2: !`command2`

## Your Task

Brief instruction.

---

## Phase 1: Name

**Goal**: One-line goal

**Actions**:
1. Step 1 (≤10 words)
2. **Critical step** (bold)
3. Step 3

**DO NOT proceed until X.**

---

## Phase 2: Name

...

---

## Usage Examples

**Basic:**
```bash
command
```

**With options:**
```bash
command --option
```

## Output

Expected output structure.
```

## 对比示例

### ❌ 啰嗦版本

```markdown
## Phase 2: Directory Structure Creation

**Goal**: Establish standard documentation hierarchy for the project

**Actions**:
1. Create docs/ directory with the following subdirectories: requirements/, design/, standards/, and analysis/
2. Verify that all directories have been created successfully
3. Check that the directory structure matches the expected layout
4. Report the created structure to the user with full details
5. Wait for user confirmation before proceeding to the next phase
```

**问题**：
- 步骤描述过长（第 1 步 >20 词）
- 包含不必要的细节（"with full details"）
- 过多的验证步骤

### ✅ 简洁版本

```markdown
## Phase 2: Directory Structure

**Goal**: Create standard documentation hierarchy

**Actions**:
1. Create docs/ structure
2. Verify creation

**DO NOT proceed until directories exist.**
```

**优点**：
- 每步 ≤5 词
- 突出关键点
- 使用停止点代替冗长说明

## 写作清单

创建 Command 时检查：

- [ ] Description 一句话说明
- [ ] Context 使用 Bash 内联执行（`!`command``）
- [ ] 使用 Phase 结构（`---` 分隔）
- [ ] 每个 Phase 有 Goal
- [ ] Actions ≤5 个步骤
- [ ] 每步 ≤10 词
- [ ] 关键步骤用粗体
- [ ] 使用停止点（WAIT/DO NOT）
- [ ] 包含使用示例
- [ ] 包含输出格式

## 常见错误

| 错误 | 示例 | 修正 |
|------|------|------|
| 教学式描述 | "The command will analyze..." | "Analyze..." |
| 步骤过长 | "Create docs/ directory with requirements/, design/, standards/, and analysis/ subdirectories" | "Create docs/ structure" |
| 缺少停止点 | "Wait for user" | "**WAIT for user confirmation**" |
| 过多细节 | "Generate project-specific requirements documentation based on existing code analysis" | "Generate requirements from code" |
