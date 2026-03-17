# 需求文档 20260317: simplify-commands-and-add-update - 精简命令集并新增 Update 命令

## 文档信息
- **编号**: REQ-20260317
- **标题**: simplify-commands-and-add-update
- **版本**: 1.0.0
- **创建日期**: 2026-03-17
- **状态**: 草案

## 1. 需求背景

### 1.1 问题现状

目前 `ai-doc-driven-dev` 插件包含了过多的独立命令（如 `analyze-docs`，`enforce-doc-workflow`，`extract-patterns`），使得插件的边界和核心工作流不够清晰。用户只需要极简的初始化和更新机制。

同时，用户在通过 `init` 命令（A版本）生成初始开发文档后，往往由于项目迭代或文档内容规范调整，会修改其使用的后台 skill（如将其优化为 B版本）。当前缺乏一种直接的机制，能够应用新版本（B版本）的 skill 去更新和覆写已有根据旧版本（A版本）生成的开发库文档，而不需要重新从头破坏性初始化。

### 1.2 目标用户

使用 `ai-doc-driven-dev` 插件管理其项目 AI 文档生命周期的开发者。

## 2. 功能需求

### 2.1 核心功能

**F1: 移除冗余的命令集**
- 删除以下三个命令及其可能对应仅为其服务的孤立 Agent/Skill（若无其他共用）：
  - `analyze-docs.md`
  - `enforce-doc-workflow.md`
  - `extract-patterns.md`
- 保留核心初始化命令 `init` (`init-doc-driven-dev.md`)。

**F2: 新增 `update` (更名或新建) 命令**
- 增加 `update-doc-driven-dev` 命令（或者简称 `update` 概念的命令）。
- 当用户执行该命令时，系统将通过最新修改后的 Skill（B版）读取代码库现状与现有文档（A版），并将其更新（覆写/重构）到与当前 Skill 版本（B版）要求相对应的新状态。

### 2.2 辅助功能

- 更新插件的 `README.md` 及 `README-zh.md`，反映只有 `init` 和 `update` 两大核心命令的新形态。

## 3. 技术需求

### 3.1 架构设计

整体命令层进一步收拢，用户仅通过：
1. `init-doc-driven-dev` - 初次全量搭建 AI 文档工作流骨架。
2. `update-doc-driven-dev` - 当后台 Prompt/Skill 演进后，重放执行使得现存文档同步升级。

### 3.2 技术实现大纲

1. 物理删除 `plugins/ai-doc-driven-dev/commands/` 目录下的三个废弃 `.md` 文件。
2. 创建 `plugins/ai-doc-driven-dev/commands/update-doc-driven-dev.md`（或 `update-docs.md`），设置执行逻辑为对现有文档的扫描和重新生成。
3. 如果需要，为 `update` 提供相应的 Agent 配置文件。如果可以复用 `doc-flow-initializer` 进行增量/覆写更新部分，可以直接指向现有 Agent，或为其创建专属 `doc-updater.md` Agent。

## 4. 风险评估

### 4.1 技术风险

- `update` 过程中可能意外覆盖用户手动在文档中添加的有价值特定细节内容。需在提示词中建议 AI 采用"读取现有内容并在新格式下进行合并融合"的策略，而非粗暴抹除。
