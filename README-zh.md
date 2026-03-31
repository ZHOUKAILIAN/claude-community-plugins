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
| **AI 文档驱动开发** | 工作流指令强制执行（`CLAUDE.md` / `AGENTS.md`）、文档分析、模式提取、智能文档生成     | 建立文档优先的开发工作流并维护项目文档标准                                           |
| **Git 操作助手**     | 提交摘要、消息起草、冲突解决、变基工作流             | 提供安全、可重复的 Git 工作流，包含清晰的命令、变更摘要和专家指导                               |
| **OpenClaw 运维工具** | 远程诊断 ✅、Token 同步 ✅ | 通过 SSH 诊断和维护 OpenClaw Telegram bot gateway 服务器 |
| **JS 框架分析器**   | 微前端隔离分析 ✅、AI 平台架构分析 🚧、响应式系统分析 ✅ | 通过探索式代码分析理解 JavaScript 框架核心实现机制，支持中英文双语报告和 PlantUML 图 |

## 📦 插件详情

### AI 文档驱动开发

**位置**: `plugins/ai-doc-driven-dev/`

**目的**: 通过 AI 辅助将任何项目转换为文档驱动的开发工作流

**核心能力**:

- **🔧 工作流指令强制执行**: 自动确保 `CLAUDE.md` 或 `AGENTS.md` 包含必需的文档驱动开发工作流
- **📊 文档分析**: 全面评估项目文档完整性
- **🎯 模式提取**: 自动提取项目特定的编码模式和约定
- **📝 智能生成**: 基于项目分析和模板创建标准化文档

**包含技能**: doc-workflow-enforcer, doc-detector, pattern-extractor, doc-generator

### Git 操作助手

**位置**: `plugins/git-ops-helper/`

**目的**: 提供安全、可重复的 Git 工作流，包含清晰的命令、变更摘要和专家指导

**核心能力**:

- **📝 提交摘要**: 自动清晰摘要 git 变更
- **✉️ 消息起草**: 按标准约定起草提交消息
- **🔀 冲突解决**: 为解决合并冲突提供专家指导
- **🔄 变基工作流**: 为 rebase、cherry-pick 和合并操作提供安全指导
- **🛡️ 安全规则**: 从不未经用户确认运行 Git 命令

**包含技能**: git-ops-helper

**包含命令**: summarize-commit

**安全特性**:

- 在请求确认前始终显示确切命令
- 在 main/master 上提交前建议创建新分支
- 为重置 --hard 等风险操作提供清晰警告

### OpenClaw 运维工具

**位置**: `plugins/openclaw-ops/`

**目的**: 诊断并维护 OpenClaw Telegram bot gateway 服务

**核心能力**:

- **🔍 远程诊断**: 通过 SSH 检查服务状态、Token 过期时间、日志、内存占用和端口监听
- **🔄 Token 同步**: 上传本地认证文件、更新远程配置、重启服务并校验结果
- **🛡️ 运维说明**: 将环境变量要求和故障排查信息与命令文档保持在一起

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
   # 克隆仓库
   git clone git@github.com:ZHOUKAILIAN/claude-community-plugins.git
   cd claude-community-plugins

   # 将目标插件目录复制到你的 Claude 插件目录
   cp -R plugins/ai-doc-driven-dev <你的-Claude-插件目录>/ai-doc-driven-dev
   ```

3. **使用插件**
   - 复制后重启或重新加载 Claude Code
   - 具体命令、技能和环境变量要求以各插件自己的 `README.md` 为准

### Codex 用户

Codex 通常采用“意图驱动”交互，而不是 `claude <command>` 命令格式。

1. **进入目标插件目录**
   - 示例：`plugins/ai-doc-driven-dev/`
2. **使用意图式请求**
   - 示例：
     - “为当前项目初始化文档优先工作流”
     - “分析文档缺口和命名规范一致性”
     - “根据模板生成需求与技术方案文档”
3. **把插件文档作为执行规范**
   - 阅读插件下的 `README.md`、`commands/`、`skills/` 文档
4. **保持一致的流程门禁**
   - 遵循 docs-before-code、需求/技术方案配对、完成前验证

### 插件开发者

1. **创建新插件**

   ```bash
   # 在 plugins/ 下手动创建插件目录
   mkdir -p plugins/my-awesome-plugin
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
   # 对照现有插件结构和目录设计文档进行检查
   ls plugins/my-awesome-plugin
   ```

4. **发布到市场**

   ```bash
   # 通过 Pull Request 提交插件和文档
   git status
   ```

## 📚 文档

### 用户文档

- 优先阅读根级 `README.md` 与各插件自己的 `README.md`
- 可直接浏览 `plugins/` 目录查看当前库存

### 开发者文档

- [技能文档模板](docs/standards/skill-documentation-template.md)
- [需求文档模板](docs/standards/requirements-template.md)
- [技术方案模板](docs/standards/technical-design-template.md)
- [插件结构参考](docs/design/directory-structure.md)

### 架构与设计

- 参考 `docs/design/` 下的技术方案文档
- 参考 `docs/requirements/` 下的需求文档
- 参考 `docs/standards/` 下的共享规范与模板

## 🏗️ 项目结构

```
claude-code-plugins/
├── README.md                    # 英文版本
├── README-zh.md                 # 中文版本（本文件）
├── plugins/                     # 插件集合（市场库存）
│   ├── ai-doc-driven-dev/
│   ├── git-ops-helper/
│   ├── js-framework-analyzer/
│   └── openclaw-ops/
├── docs/                        # 文档和设计规范
│   ├── design/                  # 架构和设计文档
│   ├── standards/               # 开发标准和模板
│   └── requirements/            # 项目需求
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

_最后更新: 2026-01-16_
