# Claude Code 插件市场

一个用于发现、安装、管理和发布 Claude Code 插件的中心化仓库。这个插件市场是 Claude Code 扩展和工具的官方分发平台。

## 🎯 这是什么？

**Claude Code 插件市场** 既是一个代码仓库，也是一个分发平台：

- **开发者** 可以发现和安装插件来扩展 Claude Code 功能
- **插件作者** 可以发布和分享他们的 Claude Code 插件给社区
- **组织机构** 可以管理和分发内部 Claude Code 工具

**核心概念**：仓库本身就是市场 - `plugins/` 目录中的每个插件都是一个完整、独立的 Claude Code 插件，可以直接安装使用。

## 🚀 可用功能

| 插件                | 功能特性                                                 | 描述                                                                                 |
| ------------------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------ |
| **AI 文档驱动开发** | CLAUDE.md 强制执行、文档分析、模式提取、智能文档生成     | 建立文档优先的开发工作流并维护项目文档标准                                           |
| **JS 框架分析器**   | 微前端隔离分析 ✅、AI 平台架构分析 🚧、响应式系统分析 ✅ | 通过探索式代码分析理解 JavaScript 框架核心实现机制，支持中英文双语报告和 PlantUML 图 |

## 📦 插件详情

### AI 文档驱动开发

**位置**: `plugins/ai-doc-driven-dev/`

**目的**: 通过 AI 辅助将任何项目转换为文档驱动的开发工作流

**核心能力**:

- **🔧 CLAUDE.md 强制执行**: 自动确保 CLAUDE.md 包含必需的文档驱动开发工作流
- **📊 文档分析**: 全面评估项目文档完整性
- **🎯 模式提取**: 自动提取项目特定的编码模式和约定
- **📝 智能生成**: 基于项目分析和模板创建标准化文档

**包含技能**: claude-md-enforcer, doc-detector, pattern-extractor, doc-generator

### JS 框架分析器

**位置**: `plugins/js-framework-analyzer/`

**目的**: 通过探索式代码分析理解 JavaScript 框架源码的核心实现机制

**核心能力**:

- **🔍 微前端隔离分析**: 深入分析微前端框架的 JS 和 CSS 隔离机制（qiankun、wujie、single-spa、emp） ✅
- **🏗️ AI 平台架构分析**: 全面分析 AI 应用平台的架构和核心功能（Coze、Dify、FastGPT） _TODO_
- **⚡ 响应式系统分析**: 详细分析前端框架的响应式系统（Vue、React、SolidJS、Svelte） ✅
- **🌐 双语报告**: 所有分析报告均生成中英文双语版本，内容完全对应 ✅
- **📊 PlantUML 图**: 可视化结构图展示报告组织和组件关系 ✅

**包含技能**:

- ✅ microfrontend-isolation-analyzer
- 🚧 ai-platform-analyzer _(即将推出)_
- ✅ reactivity-system-analyzer
- ✅ structure-explainer

**报告特性**:

- 全面分析核心实现机制
- 带详细注释的关键代码片段
- 权衡与设计决策分析
- 总结与洞察，包含最佳实践建议
- PlantUML 结构图，直观展示报告结构
- 双语输出（英文/中文），保持内容一致

**实现状态**:

- ✅ 微前端隔离分析：已完全实现并文档化
- 🚧 AI 平台架构分析：设计完成，实现中
- ✅ 响应式系统分析：已完全实现并文档化

_更多插件即将推出..._

## 🔧 快速开始

### 插件用户

1. **浏览可用插件**

   ```bash
   # 进入市场目录
   cd claude-code-plugins
   ls plugins/
   ```

2. **安装插件**

   ```bash
   # 将插件复制到你的 Claude Code 插件目录
   cp -r plugins/ai-doc-driven-dev ~/.claude-code/plugins/
   ```

3. **使用插件**
   - 重启 Claude Code
   - 插件的技能和命令将自动可用

### 插件开发者

1. **创建新插件**

   ```bash
   # 使用插件模板（即将推出）
   ./scripts/scaffold.sh my-awesome-plugin
   ```

2. **遵循插件结构**

   ```
   plugins/my-awesome-plugin/
   ├── .claude-plugin/
   │   └── plugin.json          # 插件元数据
   ├── skills/                  # 技能定义
   ├── commands/               # 命令定义
   ├── agents/                 # 代理定义
   ├── knowledge/              # 知识库
   └── README.md               # 插件文档
   ```

3. **测试和验证**

   ```bash
   # 验证你的插件结构
   ./scripts/validate.sh plugins/my-awesome-plugin
   ```

4. **发布到市场**

   ```bash
   # 提交你的插件进行审核
   ./scripts/publish.sh my-awesome-plugin
   ```

## 📚 文档

### 用户文档

- [插件安装指南](docs/user-guide/installation.md) _（即将推出）_
- [插件管理](docs/user-guide/management.md) _（即将推出）_

### 开发者文档

- [插件开发指南](docs/developer-guide/getting-started.md) _（即将推出）_
- [技能文档模板](docs/standards/skill-documentation-template.md)
- [插件结构参考](docs/design/directory-structure.md)

### 架构与设计

- [市场架构](docs/design/architecture.md) _（即将推出）_
- [插件标准](docs/standards/)
- [开发工作流](docs/design/workflow.md) _（即将推出）_

## 🏗️ 项目结构

```
claude-code-plugins/
├── README.md                    # 英文版本
├── README-zh.md                 # 中文版本（本文件）
├── plugins/                     # 插件集合（市场库存）
│   └── ai-doc-driven-dev/      # 示例插件
├── docs/                        # 文档和设计规范
│   ├── design/                  # 架构和设计文档
│   ├── standards/               # 开发标准和模板
│   └── requirements/            # 项目需求
└── scripts/                     # 管理和自动化脚本
```

## 🤝 参与贡献

我们欢迎社区贡献！你可以这样帮助我们：

1. **提交插件**: 与社区分享你的 Claude Code 插件
2. **改进文档**: 帮助我们让市场更易于使用
3. **报告问题**: 发现了 bug？在 issues 区告诉我们
4. **功能建议**: 建议新的市场功能

### 贡献指南

- 所有插件必须包含中英文双语文档
- 遵循既定的插件结构和命名约定
- 包含全面的测试和示例
- 遵守行为准则

## 📄 许可证

本项目采用 MIT 许可证 - 各个插件的具体许可条款请查看其独立许可证文件。

## 🌐 社区

- **问题反馈**: [GitHub Issues](https://github.com/ZHOUKAILIAN/claude-code-plugins/issues)
- **讨论交流**: [GitHub Discussions](https://github.com/ZHOUKAILIAN/claude-code-plugins/discussions)
- **参与贡献**: 查看 [CONTRIBUTING.md](CONTRIBUTING.md) _（即将推出）_

---

**[中文版本](README-zh.md) | [English Version](README.md)**

_最后更新: 2026-01-13_
