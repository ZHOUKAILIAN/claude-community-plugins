# 需求文档 20260316: update-standards-optimization - 更新标准命令优化

## 文档信息
- **编号**: REQ-20260316-2
- **标题**: update-standards-optimization
- **版本**: 1.0.0
- **创建日期**: 2026-03-16
- **状态**: 草案

## 1. 需求背景

### 1.1 问题现状

在之前优化了 `init-doc-driven-dev` 命令与工作流之后，我们建立了一个全新的核心原则：`CLAUDE.md` 应该只作为“轻量级的工作流入口和文档指针中枢”，而关于项目架构、编码规范和测试准则等详细大段的文本应该被拆分放入 `docs/` 目录下。同时，引入了 `AGENTS.md` 以专门管理 AI 智能体的行为。

然而，在使用 `update-standards` 命令检查现存旧项目时，AI 助手依旧会将庞大臃肿且充满详细编码规范的 `CLAUDE.md` 视为“完善的、良好的标准”进行表扬，而忽略了“文档应该被拆分引用”这一最新规范。这意味着 `update-standards` 以及负责检查的技能（如 `doc-workflow-enforcer`）没能同步继承最新的轻量化与解耦标准。

### 1.2 目标用户

希望使用 `update-standards` 来升级原有单体巨石 `CLAUDE.md` 到现代指针化标准结构框架的开发者。

## 2. 功能需求

### 2.1 核心功能

**F1: 对臃肿型 CLAUDE.md 提出重构建议**
- 当执行 `update-standards` 和相关标准校验步骤时，必须自动检查 `CLAUDE.md` 的体积和内容。
- 识别出 `CLAUDE.md` 内部存在的详细“项目结构 (Project Structure)”、“编码规范 (Coding Standards)” 或是“测试准则 (Testing)”的段落。
- 明确指出这属于旧模式（反模式），并建议将其内容迁移到 `docs/analysis/` 或 `docs/standards/` 对应的专门文档中。

**F2: 检查 CLAUDE.md 与 AGENTS.md 的职责分离**
- 检查指导性文档是否实现了职责解耦：`CLAUDE.md` 负责开发工作流与文档指针关联，`AGENTS.md` 负责 AI 智能体的规则。
- 若只存在一个混合了智能体提示词与项目规范的 `CLAUDE.md` 文件，则提示需要拆分。

### 2.2 辅助功能

- 将这套最新的 “轻量级、指引化指令文件” 规范直接更新至 `commands/update-standards.md` 中说明和 `skills/doc-workflow-enforcer/SKILL.md` 的检查/执行逻辑中。

## 3. 技术需求

### 3.1 架构设计

在 `plugins/ai-doc-driven-dev/` 内部，更新现有的命令指引与前置技能文档，将“指令文件拆分解耦”明确升格为一条检查指标：
1. `commands/update-standards.md` 增加关于“检查 `CLAUDE.md` 轻量化与指针化程度”和“检查 `AGENTS.md` 对 AI 的配置”的行为描述。
2. `skills/doc-workflow-enforcer/SKILL.md` 在其工作流的 Phase 1 和 Phase 4 之中，加入识别及提取分离臃肿内容的动作，并修改附加的规则集。

### 3.2 技术实现大纲

1. 将“指令解耦检查 (Instruction Decoupling Check)”添加到 `update-standards.md`。
2. 在 `skills/doc-workflow-enforcer/SKILL.md` 中强化 "Document Decoupling" 的概念与原则配置。
