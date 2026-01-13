# JS框架源码分析器

一个用于分析JavaScript框架源码仓库的Claude Code插件，帮助理解核心实现机制。

## 功能

此插件为三种类型的JavaScript框架提供专门的分析能力：

### 微前端框架分析
分析微前端框架中的JavaScript和CSS隔离机制：
- qiankun（基于single-spa）
- wujie（基于WebComponent + iframe）
- single-spa（微前端基础框架）
- emp（基于Webpack 5 Module Federation）

### AI平台分析
分析AI应用平台的架构和核心功能：
- Coze（字节跳动的AI平台）
- Dify（开源LLM平台）
- FastGPT（基于知识库的问答平台）

### 前端框架响应式分析
分析前端框架中的响应式系统实现：
- Vue（渐进式框架）
- React（UI库）
- SolidJS（细粒度响应式）
- Svelte（编译时框架）

## 安装

此插件是Claude Code插件市场的一部分。安装方法：

```bash
# 进入你的项目目录
cd your-project

# 安装插件（当市场可用时）
claude plugin install js-framework-analyzer
```

## 使用

### 命令

#### 分析微前端隔离机制
```bash
claude analyze-mf-isolation
claude analyze-mf-isolation --focus js
claude analyze-mf-isolation --detailed --save report.md
```

#### 分析AI平台架构
```bash
claude analyze-ai-platform
claude analyze-ai-platform --module chat
claude analyze-ai-platform --detailed --save report.md
```

#### 分析响应式系统
```bash
claude analyze-reactivity
claude analyze-reactivity --detailed --save report.md
```

### 技能

插件包含四个专门的技能：

1. **microfrontend-isolation-analyzer** - 分析微前端中的JS和CSS隔离
2. **ai-platform-analyzer** - 分析AI平台架构
3. **reactivity-system-analyzer** - 分析框架中的响应式系统
4. **structure-explainer** - 解释代码库结构和组织

## 分析方法

此插件采用探索式分析方法：

1. **仓库识别**：通过package.json和目录结构识别框架类型
2. **关键词搜索**：搜索相关关键词以定位核心实现
3. **核心文件识别**：定位包含目标机制的文件
4. **代码关系分析**：映射依赖和调用关系
5. **机制文档化**：用清晰的描述总结发现的实现

## 输出格式

分析报告包括：

- 框架/平台信息（名称、版本、技术栈）
- 核心文件及其用途
- 实现机制说明
- 带注释的关键代码片段
- 权衡和设计决策

## 插件结构

```
js-framework-analyzer/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   ├── microfrontend-isolation-analyzer/
│   │   └── SKILL.md
│   ├── ai-platform-analyzer/
│   │   └── SKILL.md
│   ├── reactivity-system-analyzer/
│   │   └── SKILL.md
│   └── structure-explainer/
│       └── SKILL.md
├── commands/
│   ├── analyze-mf-isolation.md
│   ├── analyze-ai-platform.md
│   └── analyze-reactivity.md
├── README.md
└── README-zh.md
```

## 许可证

MIT

---

**[中文版本](README-zh.md) | [English Version](README.md)**
