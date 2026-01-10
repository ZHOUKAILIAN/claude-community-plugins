# 需求文档 002: AI文档驱动开发插件 - Agents和Commands扩展

## 文档信息

- **编号**: REQ-002
- **标题**: AI文档驱动开发插件 - Agents和Commands扩展
- **版本**: 1.0.0
- **创建日期**: 2026-01-10
- **状态**: 方案确认中
- **依赖**: REQ-001 (AI文档驱动开发插件基础功能)

## 1. 需求概述

### 1.1 背景

在REQ-001的基础上，需要为AI文档驱动开发插件补充完整的Claude Code Plugin架构组件。原始实现只包含Skills，但一个完整的插件应该包含Agents（智能代理）和Commands（用户命令）来提供更丰富的交互方式和专业化功能。

### 1.2 目标

- 添加专业化的AI代理来处理复杂的分析和设计任务
- 提供用户友好的命令接口来执行常见的文档驱动开发操作
- 完善插件架构，使其符合Claude Code Plugin最佳实践

### 1.3 核心问题

- **单一交互方式**: 仅通过Skills提供功能，缺乏专业化的AI代理支持
- **用户体验不足**: 没有简单易用的命令接口
- **架构不完整**: 缺少Agents和Commands组件

## 2. 功能需求

### 2.1 智能代理 (Agents)

#### 2.1.1 AI流程初始化代理 (doc-flow-initializer)

**功能描述**: 为缺乏AI文档驱动开发流程的仓库建立完整基础设施的专业AI代理

**核心能力**:

- 项目类型和技术栈自动识别
- CLAUDE.md文件创建或更新，集成AI协作规范
- 智能docs/目录结构处理：
  - 检测现有docs结构
  - 分析与标准结构的差异
  - 提供整理建议并征求用户确认
  - 按用户选择进行结构调整或保持现状
- 项目特定的文档模板生成
- 文档驱动开发工作流程建立

**使用场景**:

- 新项目的AI文档驱动化初始化
- 现有项目缺少AI协作文件时的补充
- 已有docs但结构不标准时的智能整理
- 建立标准化的文档驱动开发流程

**特殊处理逻辑**:

- **无docs目录**: 直接创建标准结构 (requirements, design, standards, analysis)
- **有docs但结构不同**: 分析现有结构，提供整理方案，征求用户意见
- **有docs且部分匹配**: 补充缺失的标准目录，保留现有内容

#### 2.1.2 代码风格分析代理 (codebase-style-analyzer)

**功能描述**: 深度分析仓库代码风格和通用模式，为AI后续开发提供一致性指导的专业AI代理

**核心能力**:

- 代码库全面扫描和模式识别
- 命名约定、格式化规则、代码组织方式提取
- 架构模式和设计模式识别
- 重复使用的代码模式和最佳实践发现
- 项目特定开发规范文档生成

**使用场景**:

- 为AI后续开发建立代码风格参考
- 项目代码规范的自动化提取和文档化
- 确保团队开发的一致性标准

### 2.2 用户命令 (Commands)

#### 2.2.1 初始化AI文档驱动流程 (init-ai-doc-flow)

**功能描述**: 调用doc-flow-initializer代理，智能为项目建立AI文档驱动开发基础设施

**核心功能**:

- 自动识别项目类型和技术栈
- 创建或更新CLAUDE.md文件
- 智能处理docs/目录结构：
  - 检测现有docs并分析结构差异
  - 提供整理建议并征求用户确认
  - 按用户需求调整或保持现有结构
- 生成项目特定文档模板

**交互特性**:
- 发现现有docs结构与标准不符时，会暂停并询问用户处理方式
- 提供多种选项：保持现状、整理为标准结构、或混合方案
- 确保不会意外覆盖用户重要的现有文档

**快捷键**: `iadf`

#### 2.2.2 分析代码风格 (analyze-codebase-style)

**功能描述**: 调用codebase-style-analyzer代理，深度分析项目代码风格和通用模式

**核心功能**:

- 扫描代码库识别模式
- 提取命名约定和代码风格
- 识别架构模式和最佳实践
- 生成项目开发规范文档

**快捷键**: `acs`

## 3. 技术规范

### 3.1 文件结构

```text
plugins/ai-doc-driven-dev/
├── agents/
│   ├── doc-flow-initializer.md
│   └── codebase-style-analyzer.md
├── commands/
│   ├── init-ai-doc-flow.md
│   └── analyze-codebase-style.md
└── .claude-plugin/
    └── plugin.json (更新contributes部分)
```

### 3.2 Agent规范

#### 3.2.1 前置元数据模板

```yaml
---
name: agent-name
description: |
  Agent description
system_prompt: |
  Detailed system prompt defining agent capabilities and behavior
allowed-tools: ["Read", "Glob", "Grep", "LSP"]
license: MIT
---
```

#### 3.2.2 Agent系统提示规范

- 明确定义代理的专业领域和职责
- 详细说明核心能力和工作原则
- 指定允许使用的工具集合
- 包含使用场景和最佳实践指导

### 3.3 Command规范

#### 3.3.1 前置元数据模板

```yaml
---
name: command-name
description: Command description
category: setup|analysis|generation
shortcut: "xx"
---
```

#### 3.3.2 Command文档结构

- **Description**: 详细功能描述
- **Usage**: 使用语法和选项
- **Options**: 可用参数说明
- **Examples**: 实际使用示例
- **Output**: 预期输出格式
- **Related Commands**: 相关命令链接

### 3.4 Plugin Manifest更新

#### 3.4.1 contributes部分扩展

```json
{
  "contributes": {
    "skills": [...],
    "agents": [
      {
        "name": "doc-flow-initializer",
        "description": "Expert agent for initializing AI documentation-driven development infrastructure"
      },
      {
        "name": "codebase-style-analyzer",
        "description": "Expert agent for analyzing codebase style and extracting development patterns"
      }
    ],
    "commands": [
      {
        "name": "init-ai-doc-flow",
        "description": "Initialize AI documentation-driven development workflow",
        "shortcut": "iadf"
      },
      {
        "name": "analyze-codebase-style",
        "description": "Analyze codebase style and extract development patterns",
        "shortcut": "acs"
      }
    ]
  }
}
```

## 4. 实现细节

### 4.1 Agent实现要点

#### 4.1.1 doc-flow-initializer

- **工具权限**: Read, Write, Edit, Glob, Grep
- **专业领域**: AI文档驱动开发基础设施建立、项目初始化
- **核心算法**: 项目类型识别、CLAUDE.md生成、docs结构创建
- **输出格式**: CLAUDE.md文件、标准docs目录结构、项目文档模板

#### 4.1.2 codebase-style-analyzer

- **工具权限**: Read, Write, Glob, Grep, LSP
- **专业领域**: 代码风格分析、模式提取、开发规范生成
- **核心算法**: 代码扫描、模式识别、风格归纳、规范文档生成
- **输出格式**: 代码风格指南、架构模式文档、开发规范更新

### 4.2 Command实现要点

#### 4.2.1 交互设计

- 支持命令行选项和参数
- 提供进度反馈和状态信息
- 错误处理和用户友好的错误消息
- 与现有Skills的集成和协调

#### 4.2.2 输出标准化

- 统一的文档生成格式
- 一致的目录结构创建
- 标准化的报告模板
- 可配置的输出选项

## 5. 验收标准

### 5.1 功能验收

- [ ] 创建2个专业化Agent，具备明确的专业领域定义
- [ ] 创建2个用户友好的Command，支持快捷键操作
- [ ] 更新plugin.json manifest，正确声明所有组件
- [ ] 所有组件遵循标准化的前置元数据格式

### 5.2 质量验收

- [x] Agent系统提示详细且专业
- [x] Command文档完整且易于理解
- [x] 文件命名遵循kebab-case约定
- [x] 所有markdown文件通过linting检查

### 5.3 集成验收

- [x] 与现有Skills无冲突
- [x] 插件manifest正确注册所有组件
- [x] 文档结构符合Claude Code Plugin标准

## 6. 风险和限制

### 6.1 技术风险

- **工具权限**: Agent工具权限需要谨慎设计，避免安全风险
- **性能影响**: 复杂的分析操作可能影响响应时间
- **兼容性**: 需要确保与不同项目类型的兼容性

### 6.2 使用限制

- **项目依赖**: 需要Git仓库环境
- **文档标准**: 依赖于标准化的文档结构
- **语言支持**: 主要针对常见编程语言设计

## 7. 后续规划

### 7.1 功能扩展

- 添加更多专业化Agent（如security-auditor、performance-analyst）
- 扩展Command支持更多项目类型和场景
- 集成外部工具和服务

### 7.2 优化改进

- 基于用户反馈优化Agent行为
- 改进Command的用户体验
- 增强错误处理和恢复能力

---

**文档状态**: 🔄 方案确认中
**最后更新**: 2026-01-10
**目标版本**: ai-doc-driven-dev v1.1.0
