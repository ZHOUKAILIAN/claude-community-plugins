# 需求文档 20260316: init-doc-driven-dev-optimization - 初始化命令优化

## 文档信息
- **编号**: REQ-20260316
- **标题**: init-doc-driven-dev-optimization
- **版本**: 1.0.0
- **创建日期**: 2026-03-16
- **状态**: 草案

## 1. 需求背景

### 1.1 问题现状

目前，基于 `init-doc-driven-dev` 命令生成的 `CLAUDE.md` 包含了过多的项目细节，例如 `## Project Structure`、`## Coding Standards`、`## Testing` 等部分，使得 `CLAUDE.md` 文件显得非常臃肿大段。合理的做法是将这些具体的项目分析和规范记录在 `docs/analysis/` 和 `docs/standards/` 目录下的专门独立文档中，并在 `CLAUDE.md` 中通过文档链接形式进行索引（如 302 跳转）。

此外，当前命令核心仅偏向生成 `CLAUDE.md`，而在实际智能体驱动的开发中，项目通常还需要并重 `AGENTS.md`，用于指导具体的 AI agents 的能力和运行规则。这两个文档必须要能够被命令同时初始化生成。

### 1.2 目标用户

使用该命令在自身项目中初始化 Claude Doc-driven 开发工作流的开发者和 AI 助手。

## 2. 功能需求

### 2.1 核心功能

**F1: 优化 CLAUDE.md 生成内容精简与外链索引**
- 将原来在 `CLAUDE.md` 中生成的 "Project Structure", "Coding Standards", "Testing" 等详细大段内容移除。
- 调整 `CLAUDE.md` 的内容聚焦方向，使其重点注重于全局**流程 (workflow)** 以及一些特别重要的核心约束。
- 原有的各种详细模块内容，要求被写入到 `docs/analysis/` 或是 `docs/standards/` 中的对应文档里，随后在 `CLAUDE.md` 中写明对应文档的 MD 引用链接即可。

**F2: 新增 AGENTS.md 同步生成**
- 规定在执行 `init-doc-driven-dev` 时，必须同时生成/初始化包含 `AGENTS.md` 和 `CLAUDE.md`。
- `AGENTS.md` 应被放置于项目根目录，作为与 `CLAUDE.md` 配套的核心基础设施文档。

### 2.2 辅助功能

- 修订 `commands/init-doc-driven-dev.md` 与 `agents/doc-flow-initializer.md`，使向终端用户暴露的命令行文档和后台作用的 AI 提示词保持最新的行为描述。

## 3. 技术需求

### 3.1 架构设计

在 `plugins/ai-doc-driven-dev/` 内部，通过更新 `agents/doc-flow-initializer.md` 中赋予大模型的 system_prompt 和相关模板指引，显式要求在第二步或处理结构时同时建立 `AGENTS.md` 文件，并在 `CLAUDE.md` 的模板中引入文件链接，不再输出长篇幅具体规则。

### 3.2 技术实现大纲

1. 修改 `agents/doc-flow-initializer.md` 中的 `Enhanced CLAUDE.md Sections`，删除具体 Coding Style 的详细产出提示，加上必须提供文档链接的要求，并新增有关并列生成 `AGENTS.md` 的 workflow 步骤。
2. 修改 `commands/init-doc-driven-dev.md` 以响应此命令的变更日志，并在示例文档目录结构中，加入对 `AGENTS.md` 的描绘，以及其作为新输出项的说明。
