# 需求文档 007: CLAUDE.md 优化 - AI 开发指南与代码风格分离

## 文档信息
- **编号**: REQ-007
- **标题**: CLAUDE.md 优化 - AI 开发指南与代码风格分离
- **版本**: 1.0.0
- **创建日期**: 2026-01-26
- **状态**: 草案

## 1. 需求背景

### 1.1 问题现状

当前 `init-doc-driven-dev` 命令在初始化项目时，会将大量代码风格相关的内容写入 `CLAUDE.md` 文件中。这导致了以下问题：

1. **职责混淆**: `CLAUDE.md` 应该专注于 AI 开发指南和工作流程，而不是详细的代码风格规范
2. **内容冗余**: 代码风格信息在 `docs/standards/coding-standards.md` 中已有详细文档，在 `CLAUDE.md` 中重复书写导致维护困难
3. **可读性下降**: `CLAUDE.md` 文件因包含过多代码风格细节而变得冗长，核心的 AI 协作指南被淹没
4. **维护成本高**: 代码风格变更需要同时更新多个文件，容易出现不一致
5. **关注点不清晰**: 开发者和 AI 需要在大量代码风格细节中寻找真正重要的 AI 协作流程

### 1.2 目标用户

- **主要用户**: 使用 Claude Code CLI 进行开发的开发者
- **次要用户**: 项目维护者和团队协作者
- **受益方**: 所有使用 `ai-doc-driven-dev` 插件的项目

## 2. 功能需求

### 2.1 核心功能

**F1: CLAUDE.md 内容精简**
- `CLAUDE.md` 应专注于以下核心内容：
  - 项目概述和架构说明
  - AI 开发工作流程（文档优先原则）
  - AI 协作指南和使用规范
  - 文档结构和模板引用
  - 开发流程和审批门控
- 移除或最小化以下内容：
  - 详细的代码风格规范（命名、缩进、注释等）
  - 具体的编码约定细节
  - 技术栈特定的实现规范

**F2: 引用机制建立**
- 在 `CLAUDE.md` 中添加对 `docs/standards/` 文档的引用
- 使用简洁的引用语句，例如：
  ```markdown
  ## 代码风格规范

  详细的代码风格规范请参考：
  - [编码标准](docs/standards/coding-standards.md)
  - [项目约定](docs/standards/project-conventions.md)
  ```
- 保留关键的高层次原则，避免细节展开

**F3: 代码风格文档独立管理**
- 确保 `docs/standards/coding-standards.md` 包含完整的代码风格信息
- 代码风格文档应由 `extract-patterns` 命令或 `codebase-style-analyzer` 代理生成和维护
- `CLAUDE.md` 仅通过引用方式链接到这些文档

### 2.2 辅助功能

**F4: 向后兼容性**
- 对于已存在的 `CLAUDE.md` 文件，提供迁移指南
- 支持渐进式优化，不强制立即重写现有文件

**F5: 模板更新**
- 更新 `doc-flow-initializer` 代理使用的 CLAUDE.md 模板
- 更新 `claude-md-enforcer` 技能的内容生成逻辑

## 3. 技术需求

### 3.1 架构设计

**分离原则**:
```
CLAUDE.md (AI 开发指南层)
    ↓ 引用
docs/standards/ (代码规范层)
    ├── coding-standards.md      # 详细代码风格
    ├── project-conventions.md   # 项目约定
    └── architecture-patterns.md # 架构模式
```

**职责划分**:
- **CLAUDE.md**:
  - AI 如何与项目交互
  - 开发工作流程和审批流程
  - 文档结构和模板位置
  - 高层次开发原则

- **docs/standards/**:
  - 具体的代码风格规范
  - 命名约定和格式要求
  - 技术栈特定的实现细节
  - 项目特有的编码模式

### 3.2 技术实现大纲

**阶段 1: 模板优化**
1. 修改 `doc-flow-initializer.md` 中的 CLAUDE.md 模板结构
2. 精简代码风格相关章节，添加引用语句
3. 强化 AI 协作流程和文档优先原则的表述

**阶段 2: 技能逻辑更新**
1. 更新 `claude-md-enforcer` 技能的内容生成逻辑
2. 修改生成 CLAUDE.md 时的内容策略：
   - 仅插入核心 AI 开发指南
   - 添加对 `docs/standards/` 的引用
   - 移除详细代码风格内容的生成

**阶段 3: 文档生成协调**
1. 确保 `extract-patterns` 命令生成的代码风格文档位于 `docs/standards/`
2. 确保 `init-doc-driven-dev` 命令协调生成：
   - 精简的 `CLAUDE.md`（AI 指南）
   - 完整的 `docs/standards/coding-standards.md`（代码风格）

### 3.3 CLAUDE.md 新结构示例

```markdown
# CLAUDE.md

## 项目概述
[项目基本信息、架构说明]

## AI 开发工作流程

### 1. 强制性文档优先原则
❌ **禁止**: 未经文档和审批直接修改代码
✅ **要求**: 所有开发必须遵循以下流程

### 2. 开发步骤（严格按顺序执行）
1. 需求文档编写 → 2. 技术设计文档 → 3. 用户审批 → 4. 代码实现

### 3. AI 使用规范
[AI 如何与项目交互的指南]

### 4. 文档结构
docs/
├── requirements/     # 需求文档
├── design/          # 技术设计
└── standards/       # 开发标准

## 开发标准引用

详细的开发标准和代码风格规范请参考：
- [编码标准](docs/standards/coding-standards.md) - 代码风格、命名约定、格式规范
- [项目约定](docs/standards/project-conventions.md) - 项目特定规则和模式
- [架构模式](docs/standards/architecture-patterns.md) - 架构设计和最佳实践

**核心原则**（从代码标准中提取的关键点）：
- [仅列出 3-5 条最重要的高层次原则]
- [避免具体细节，保持简洁]
```

### 3.4 影响的组件

需要修改的文件：
1. `plugins/ai-doc-driven-dev/agents/doc-flow-initializer.md` - 更新 CLAUDE.md 模板
2. `plugins/ai-doc-driven-dev/skills/claude-md-enforcer/SKILL.md` - 更新内容生成策略
3. `plugins/ai-doc-driven-dev/commands/init-doc-driven-dev.md` - 更新命令描述（如需要）
4. 可能需要添加新的示例模板文件

## 4. 验收标准

### 4.1 功能验收

- [ ] 新生成的 `CLAUDE.md` 文件长度减少至少 50%
- [ ] `CLAUDE.md` 包含对 `docs/standards/` 文档的明确引用
- [ ] `CLAUDE.md` 专注于 AI 开发流程，不包含详细代码风格规范
- [ ] `docs/standards/coding-standards.md` 包含完整的代码风格信息
- [ ] 引用链接可正确跳转到对应文档

### 4.2 质量验收

- [ ] `CLAUDE.md` 可读性显著提升，核心流程清晰可见
- [ ] 代码风格信息集中管理，便于维护
- [ ] 职责划分清晰，AI 指南与代码规范分离
- [ ] 现有项目可平滑升级（提供迁移指南）

### 4.3 文档验收

- [ ] 更新 `ai-doc-driven-dev` 插件的 README，说明新的内容组织方式
- [ ] 提供 CLAUDE.md 优化前后的对比示例
- [ ] 编写迁移指南，帮助现有项目升级

## 5. 风险评估

### 5.1 技术风险

**风险 1: 引用断裂**
- **描述**: 如果 `docs/standards/` 文件不存在，引用将失效
- **影响**: 中等
- **缓解措施**:
  - 在生成 CLAUDE.md 前确保 `docs/standards/` 结构已创建
  - 添加文件存在性检查

**风险 2: 现有项目兼容性**
- **描述**: 已使用旧版本初始化的项目可能需要手动迁移
- **影响**: 低
- **缓解措施**:
  - 提供详细的迁移指南
  - 考虑添加 `--upgrade` 选项自动迁移

### 5.2 用户体验风险

**风险 3: 用户习惯改变**
- **描述**: 用户可能习惯在 CLAUDE.md 中查找所有信息
- **影响**: 低
- **缓解措施**:
  - 在 CLAUDE.md 中提供清晰的引用导航
  - 在插件文档中说明新的组织方式
  - 引用语句使用醒目的格式

## 6. 实施计划

### 6.1 开发阶段

1. **阶段 1**: 模板和技能更新（预计 2 小时）
   - 更新 CLAUDE.md 模板
   - 修改 `claude-md-enforcer` 技能逻辑

2. **阶段 2**: 测试和验证（预计 1 小时）
   - 在测试项目中验证新生成的文件
   - 检查引用链接的正确性

3. **阶段 3**: 文档和示例（预计 1 小时）
   - 更新插件 README
   - 编写迁移指南
   - 创建对比示例

### 6.2 发布计划

- 版本号: `1.0.0-alpha.3` (ai-doc-driven-dev 插件)
- 发布说明: 强调 CLAUDE.md 优化和职责分离
- 迁移指南: 提供给现有用户

## 7. 成功指标

- 用户反馈: CLAUDE.md 更易读，核心流程更清晰
- 维护效率: 代码风格变更只需修改 `docs/standards/` 文件
- 文件大小: CLAUDE.md 平均大小减少 50% 以上
- 采用率: 新项目默认使用优化后的结构
