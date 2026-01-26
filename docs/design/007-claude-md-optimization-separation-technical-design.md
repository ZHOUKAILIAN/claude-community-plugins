# 技术方案 007: CLAUDE.md 优化 - AI 开发指南与代码风格分离 - 技术设计

## 文档信息

- **编号**: TECH-007
- **标题**: CLAUDE.md 优化 - AI 开发指南与代码风格分离
- **版本**: 1.0.0
- **创建日期**: 2026-01-26
- **状态**: 待实现
- **依赖**: REQ-007 (CLAUDE.md 优化 - AI 开发指南与代码风格分离需求)

## 1. 技术架构概述

### 1.1 整体设计思路

**核心理念**: 职责分离 (Separation of Concerns)

- **CLAUDE.md**: AI 交互层 - 专注于告诉 AI "如何工作"
- **docs/standards/**: 规范层 - 专注于定义"什么是好代码"

**技术路线**:

1. 重构 CLAUDE.md 模板，移除代码风格细节
2. 修改内容生成逻辑，使用引用替代嵌入
3. 确保 `docs/standards/` 文件完整性
4. 建立引用验证机制

### 1.2 架构设计

```text
ai-doc-driven-dev/
├── agents/
│   ├── doc-flow-initializer.md          [修改] 更新 CLAUDE.md 模板
│   └── codebase-style-analyzer.md        [保持] 继续生成 coding-standards.md
├── skills/
│   ├── claude-md-enforcer/
│   │   └── SKILL.md                      [修改] 更新内容生成策略
│   ├── pattern-extractor/
│   │   └── SKILL.md                      [保持] 继续提取代码模式
│   └── doc-generator/
│       └── SKILL.md                      [可能修改] 协调文档生成
└── commands/
    └── init-doc-driven-dev.md            [文档更新] 说明新行为
```

**文件关系**:

```text
init-doc-driven-dev 命令
    ↓
doc-flow-initializer 代理
    ↓
├─→ claude-md-enforcer 技能 → 生成精简的 CLAUDE.md (引用模式)
└─→ codebase-style-analyzer 代理 → 生成完整的 docs/standards/coding-standards.md
```

## 2. 核心组件详细设计

### 2.1 CLAUDE.md 模板重构 (doc-flow-initializer.md)

**功能职责**：

- 定义新的 CLAUDE.md 结构模板
- 移除详细代码风格章节
- 添加引用章节模板

**实现思路**：

修改 `doc-flow-initializer.md` 中的 "Enhanced CLAUDE.md Sections" 部分：

```markdown
## Enhanced CLAUDE.md Sections (NEW)
```markdown
# Project Overview (from /init)
  [项目基本信息、技术栈、架构概述]

# AI Development Workflow
  ## Documentation-First Process
    ### 1. Mandatory Documentation-First Principle
    ### 2. Development Steps (Strict Order)
    ### 3. AI Usage Guidelines
    ### 4. Documentation Structure

# Development Standards Reference
  ## Code Style and Conventions
  详细的代码风格规范请参考：
  - [Coding Standards](docs/standards/coding-standards.md)
  - [Project Conventions](docs/standards/project-conventions.md)
  - [Architecture Patterns](docs/standards/architecture-patterns.md)

  **Core Principles** (High-level only):
  - [Principle 1]
  - [Principle 2]
  - [Principle 3]

# AI Collaboration Guidelines
  [AI 如何与项目交互的详细指南]
```

**规则/约束**：

- CLAUDE.md 中的"Core Principles"不超过 5 条
- 每条原则不超过一行描述
- 必须包含引用章节
- 引用链接使用相对路径

### 2.2 claude-md-enforcer 技能更新

**功能职责**：

- 生成或更新 CLAUDE.md 时应用新模板
- 确保引用章节存在
- 验证引用文件的存在性

**实现思路**：

更新 `claude-md-enforcer/SKILL.md` 的描述和工作流程：

```markdown
## How It Works (UPDATED)

Workflow steps:

1. **CLAUDE.md Detection**: Scans the project root for existing CLAUDE.md files
2. **Content Analysis**: Analyzes current content to identify missing documentation workflow sections
3. **Template Injection**: Inserts or updates documentation-driven development standards
   - **NEW**: Uses reference-based approach for code style standards
   - **NEW**: Embeds only high-level principles (max 5 items)
4. **Reference Validation**: (NEW) Ensures referenced files in docs/standards/ exist
5. **Standards Synchronization**: (Optional) Syncs high-level principles only
6. **Workflow Enforcement**: Establishes mandatory "docs-first, code-second" development process
7. **Prohibition Insertion**: Adds explicit prohibitions against direct code implementation
8. **Approval Gate Setup**: Creates mandatory documentation review and approval gates

## Content Generation Strategy (NEW)

When generating CLAUDE.md content:

**INCLUDE** (AI Interaction Layer):
- Project overview and architecture summary
- AI development workflow and approval gates
- Documentation structure and template locations
- AI collaboration guidelines
- Development process enforcement rules

**EXCLUDE** (Move to docs/standards/):
- Detailed code style rules (indentation, naming conventions, etc.)
- Specific coding patterns and implementation details
- Technology-specific style guides
- Linting and formatting configurations

**REFERENCE** (Link to docs/standards/):
- Add "Development Standards Reference" section
- Link to coding-standards.md, project-conventions.md, etc.
- Extract and list 3-5 high-level principles only
- Use relative paths for all references
```

**规则/约束**：

- 生成 CLAUDE.md 前必须确保 `docs/standards/` 目录存在
- 如果引用的文件不存在，应创建占位符或警告用户
- 保留现有 CLAUDE.md 中的项目特定内容

### 2.3 引用验证机制

**功能职责**：

- 验证 CLAUDE.md 中引用的文件是否存在
- 如果文件缺失，创建基础模板或发出警告

**实现思路**：

在 `claude-md-enforcer` 技能中添加引用验证逻辑：

```markdown
## Reference Validation Logic

Before finalizing CLAUDE.md:

1. **Scan References**: Parse CLAUDE.md to extract all file references
2. **Check Existence**: Verify each referenced file exists
3. **Handle Missing Files**:
   - Option A: Create placeholder file with TODO comment
   - Option B: Warn user and suggest running extract-patterns command
   - Option C: Remove reference and add inline note
4. **Report**: Inform user of validation results
```

**规则/约束**：

- 优先选择创建占位符文件，避免断链
- 占位符文件应包含明确的 TODO 标记
- 验证应在写入 CLAUDE.md 之前完成

## 3. 工作流程设计

### 3.1 init-doc-driven-dev 命令执行流程

```text
用户执行: claude init-doc-driven-dev
    ↓
1. 检测项目类型和现有文档结构
    ↓
2. 创建 docs/ 目录结构（如不存在）
   - docs/requirements/
   - docs/design/
   - docs/standards/
   - docs/analysis/
    ↓
3. 调用 codebase-style-analyzer 代理
   → 分析代码模式
   → 生成 docs/standards/coding-standards.md (完整版)
    ↓
4. 调用 claude-md-enforcer 技能
   → 读取现有 CLAUDE.md（如存在）
   → 应用新模板（精简版 + 引用）
   → 验证引用文件存在性
   → 生成/更新 CLAUDE.md
    ↓
5. 输出报告
   - CLAUDE.md: [Created/Updated]
   - docs/standards/coding-standards.md: [Created]
   - References validated: [OK/Warning]
```

### 3.2 技能调用策略

**并行调用**：

- `codebase-style-analyzer` 和 CLAUDE.md 模板准备可以并行执行
- 引用验证必须在 CLAUDE.md 写入前完成

**顺序依赖**：

1. `docs/standards/` 目录创建 → 2. 代码风格分析 → 3. CLAUDE.md 生成 → 4. 引用验证

## 4. 数据流设计

### 4.1 技能间数据传递

```text
codebase-style-analyzer
    ↓ (输出)
docs/standards/coding-standards.md
    ↓ (读取)
claude-md-enforcer
    ↓ (提取高层次原则)
CLAUDE.md (Core Principles 章节)
    ↓ (引用链接)
docs/standards/coding-standards.md (完整详情)
```

### 4.2 文件系统交互

**读取操作**：

- 现有 CLAUDE.md（如存在）
- 现有 docs/standards/ 文件（如存在）
- 项目代码文件（用于模式提取）

**写入操作**：

- `CLAUDE.md` - 精简版，包含引用
- `docs/standards/coding-standards.md` - 完整代码风格规范
- `docs/standards/project-conventions.md` - 项目约定（可选）
- `docs/standards/architecture-patterns.md` - 架构模式（可选）

**验证操作**：

- 检查引用文件是否存在
- 验证引用路径的正确性

## 5. 模板设计

### 5.1 精简版 CLAUDE.md 模板

```markdown
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

[项目名称]
[简要描述]
[技术栈概述]
[架构概述]

## AI Development Workflow

### 1. Mandatory Documentation-First Principle

❌ **PROHIBITED**: Direct code implementation without prior documentation and approval
✅ **REQUIRED**: All development MUST follow the workflow below

### 2. Development Steps (Strict Order)

1. **Requirements Documentation** → Write detailed requirements in `docs/requirements/`
2. **Technical Design** → Create technical design document in `docs/design/`
3. **User Review & Approval** → Wait for user approval before implementation
4. **Code Implementation** → Implement based on approved documentation

### 3. AI Usage Guidelines

- AI must reference approved documentation when making changes
- AI must not deviate from approved technical designs
- AI must ask for clarification if requirements are ambiguous
- AI must update documentation when implementation differs from design

### 4. Documentation Structure

```

docs/
├── requirements/     # Functional requirements
├── design/          # Technical design documents
├── standards/       # Development standards and conventions
└── analysis/        # Project analysis reports
\```

## Development Standards Reference

Detailed development standards and code style specifications are documented in:

- **[Coding Standards](docs/standards/coding-standards.md)** - Code style, naming conventions, formatting rules
- **[Project Conventions](docs/standards/project-conventions.md)** - Project-specific rules and patterns
- **[Architecture Patterns](docs/standards/architecture-patterns.md)** - Architectural design and best practices

**Core Principles** (High-level guidelines):

- [Principle 1: e.g., Prefer composition over inheritance]
- [Principle 2: e.g., Follow single responsibility principle]
- [Principle 3: e.g., Write self-documenting code]
- [Principle 4: e.g., Avoid premature optimization]
- [Principle 5: e.g., Keep functions small and focused]

*For detailed rules and examples, please refer to the documents above.*

## AI Collaboration Guidelines

### Code Review Process

- AI should explain significant changes before implementation
- AI should highlight potential risks or trade-offs
- AI should suggest alternatives when appropriate

### Communication Style

- Be concise and clear in explanations
- Use technical terms appropriately
- Provide code examples when helpful

### Error Handling

- AI must report errors encountered during implementation
- AI must suggest fixes or alternatives
- AI must not silently ignore errors

---

**Last Updated**: [Date]
**Version**: 1.0.0
\```

### 5.2 docs/standards/coding-standards.md 模板

```markdown
# Coding Standards

This document defines the code style and formatting conventions for this project.

## Table of Contents
1. [General Principles](#general-principles)
2. [Naming Conventions](#naming-conventions)
3. [Code Formatting](#code-formatting)
4. [Comments and Documentation](#comments-and-documentation)
5. [Best Practices](#best-practices)
6. [Technology-Specific Guidelines](#technology-specific-guidelines)

## General Principles

[详细的代码原则]

## Naming Conventions

### Variables
[详细的变量命名规则]

### Functions
[详细的函数命名规则]

### Classes
[详细的类命名规则]

### Files
[详细的文件命名规则]

## Code Formatting

### Indentation
[详细的缩进规则]

### Line Length
[详细的行长度规则]

### Whitespace
[详细的空格使用规则]

## Comments and Documentation

[详细的注释规范]

## Best Practices

[详细的最佳实践]

## Technology-Specific Guidelines

### [Technology 1]
[技术栈特定规则]

### [Technology 2]
[技术栈特定规则]

---

**Note**: This document is automatically generated by the `extract-patterns` command and should be kept in sync with actual codebase patterns.
```

## 6. 实施步骤

### 6.1 阶段 1: 模板和文档更新

**修改文件**：

1. `plugins/ai-doc-driven-dev/agents/doc-flow-initializer.md`
   - 更新 "Enhanced CLAUDE.md Sections" 部分
   - 添加引用章节说明

2. `plugins/ai-doc-driven-dev/skills/claude-md-enforcer/SKILL.md`
   - 更新 "How It Works" 部分
   - 添加 "Content Generation Strategy" 章节
   - 添加 "Reference Validation Logic" 章节

**验证**：

- 文档语法正确
- frontmatter 格式正确
- 描述清晰明确

### 6.2 阶段 2: 模板文件创建

**创建新文件**：

1. `plugins/ai-doc-driven-dev/templates/claude-md-slim.template.md` (可选)
   - 精简版 CLAUDE.md 模板
   - 可供代理直接引用

2. `plugins/ai-doc-driven-dev/templates/coding-standards.template.md` (可选)
   - coding-standards.md 的基础模板

**验证**：

- 模板结构完整
- 占位符清晰标记
- 易于代理理解和使用

### 6.3 阶段 3: 集成测试

**测试场景**：

1. **全新项目初始化**

   ```bash
   cd /tmp/test-project
   claude init-doc-driven-dev
   ```

   - 验证 CLAUDE.md 精简且包含引用
   - 验证 docs/standards/coding-standards.md 完整

2. **现有项目升级**

   ```bash
   cd /existing-project
   claude init-doc-driven-dev --force
   ```

   - 验证保留现有内容
   - 验证添加引用章节
   - 验证代码风格迁移到 docs/standards/

3. **引用验证**
   - 手动删除 docs/standards/coding-standards.md
   - 运行 init-doc-driven-dev
   - 验证是否创建占位符或发出警告

**验收标准**：

- CLAUDE.md 长度减少至少 50%
- 引用链接可正确跳转
- 代码风格信息完整保存在 docs/standards/
- 无断链或错误引用

### 6.4 阶段 4: 文档和示例

**更新文档**：

1. `plugins/ai-doc-driven-dev/README.md`
   - 添加"CLAUDE.md 优化"章节
   - 说明新的内容组织方式
   - 提供对比示例

2. `plugins/ai-doc-driven-dev/README-zh.md`
   - 同步中文版本

3. 创建迁移指南
   - `plugins/ai-doc-driven-dev/docs/migration-guide-v1.0.0-alpha.3.md`
   - 说明如何从旧版本升级

**创建示例**：

- `examples/claude-md-before.md` - 优化前示例
- `examples/claude-md-after.md` - 优化后示例
- `examples/coding-standards-example.md` - 代码风格文档示例

## 7. 质量保证

### 7.1 测试策略

**单元测试**（概念层面，由 AI 执行）：

- 模板解析正确性
- 引用提取准确性
- 文件存在性验证逻辑

**集成测试**：

- 在 3 种不同类型项目中测试（前端、后端、全栈）
- 在有/无现有 CLAUDE.md 的项目中测试
- 在有/无现有 docs/standards/ 的项目中测试

**用户验收测试**：

- 邀请用户试用新版本
- 收集反馈关于可读性和可用性

### 7.2 质量指标

**定量指标**：

- CLAUDE.md 平均长度减少 ≥ 50%
- 引用验证成功率 = 100%
- 模板生成成功率 = 100%

**定性指标**：

- CLAUDE.md 可读性显著提升（用户反馈）
- 职责划分清晰（代码审查）
- 维护成本降低（实际使用体验）

## 8. 风险缓解措施

### 8.1 引用断裂风险

**缓解措施**：

- 在生成 CLAUDE.md 前创建完整的 docs/standards/ 结构
- 添加引用验证步骤
- 如果文件不存在，创建带 TODO 标记的占位符

**实现**：

```markdown
## Reference Validation in claude-md-enforcer

After generating CLAUDE.md content:

1. Parse all markdown links in "Development Standards Reference" section
2. For each link:
   - Check if file exists using Read tool
   - If missing:
     - Create placeholder file with TODO header
     - Log warning to user
3. Report validation results
```

### 8.2 向后兼容性风险

**缓解措施**：

- 保留现有 CLAUDE.md 的项目特定内容
- 仅添加/更新引用章节
- 提供 `--force` 选项用于完全重写
- 提供迁移指南

**实现**：

```markdown
## Backward Compatibility Strategy

When updating existing CLAUDE.md:

1. **Preserve Mode** (default):
   - Read existing CLAUDE.md
   - Identify and preserve custom sections
   - Add "Development Standards Reference" section if missing
   - Suggest moving code style details to docs/standards/

2. **Force Mode** (--force flag):
   - Backup existing CLAUDE.md to CLAUDE.md.backup
   - Generate new CLAUDE.md from template
   - Inform user about backup location
```

### 8.3 用户习惯改变风险

**缓解措施**：

- 在 CLAUDE.md 顶部添加导航提示
- 使用醒目的格式标记引用章节
- 在插件 README 中详细说明新组织方式

**实现**：

```markdown
## Navigation Hint in CLAUDE.md

Add at the beginning of "Development Standards Reference" section:

> 📚 **Note**: Detailed code style rules have been moved to dedicated documents for better organization and maintainability. This section provides quick reference links and high-level principles only.
```

## 9. 发布计划

### 9.1 版本号

- **插件版本**: `1.0.0-alpha.3`
- **变更类型**: Minor (功能优化，向后兼容)

### 9.2 发布说明

```markdown
## ai-doc-driven-dev v1.0.0-alpha.3

### 🎯 主要改进

- **CLAUDE.md 优化**: 精简 AI 开发指南，专注于工作流程和 AI 协作
- **职责分离**: 代码风格规范迁移至 `docs/standards/` 目录
- **引用机制**: CLAUDE.md 通过引用链接到详细规范文档
- **可读性提升**: CLAUDE.md 平均长度减少 50% 以上

### 🔧 技术变更

- 更新 `doc-flow-initializer` 代理的 CLAUDE.md 模板
- 优化 `claude-md-enforcer` 技能的内容生成策略
- 添加引用验证机制

### 📚 文档更新

- 新增迁移指南（针对现有用户）
- 更新 README 说明新的文档组织方式
- 添加优化前后对比示例

### ⚠️ 破坏性变更

无。现有项目可继续使用旧版 CLAUDE.md，新项目将自动使用优化后的结构。

### 🚀 升级指南

详见 [Migration Guide](docs/migration-guide-v1.0.0-alpha.3.md)
```

### 9.3 发布检查清单

- [ ] 所有代码修改已完成并测试
- [ ] README 已更新（英文和中文）
- [ ] 迁移指南已编写
- [ ] 示例文件已创建
- [ ] 版本号已更新（plugin.json）
- [ ] 发布说明已准备
- [ ] 在测试项目中验证功能
- [ ] Git tag 已创建

## 10. 后续优化方向

### 10.1 短期优化（v1.0.0-alpha.4）

- 添加 `--upgrade` 选项，自动迁移旧版 CLAUDE.md
- 支持自定义引用章节模板
- 添加引用健康检查命令

### 10.2 中期优化（v1.1.0）

- 支持多语言 CLAUDE.md（中英文切换）
- 添加 CLAUDE.md 可视化编辑器（CLI 交互式）
- 集成 linter 验证 CLAUDE.md 格式

### 10.3 长期优化（v2.0.0）

- 支持自定义章节顺序和内容
- AI 自动检测 CLAUDE.md 冗余内容并建议优化
- 与 IDE 插件集成，提供悬浮提示和快速跳转
