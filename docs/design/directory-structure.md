# Claude Code Plugin 市场 - 目录结构设计

## 1. 项目概述

**项目名称**: Claude Code Plugin Marketplace
**项目定位**: Plugin 市场（Marketplace），用于发现、安装、管理和发布 Plugin
**项目类型**: 多 Plugin 集合项目（纯文档驱动）
**设计原则**: 文档先行、代码跟随，参考 customplugin/plugins 实现风格

**核心概念**:

- **Marketplace**: 整个仓库就是市场，提供 Plugin 发现、安装、管理、发布能力
- **Plugins**: 市场中的商品，每个 Plugin 都是独立的 Claude Code Plugin

---

## 2. 根目录结构

```text
claude-code-plugins/           # 整个仓库就是 Marketplace（市场）
├── plugins/                 # Plugin 集合（市场中的商品）
│   ├── plugin-a/            # Plugin A
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── .mcp.json
│   │   ├── commands/
│   │   ├── skills/
│   │   ├── agents/
│   │   └── knowledge/
│   ├── plugin-b/            # Plugin B
│   │   └── ...
│   └── ...
├── docs/                    # Marketplace 设计文档
│   ├── design/              # 架构设计文档
│   ├── requirements/        # 需求文档
│   ├── conventions/         # 约定规范
│   └── reference/          # 参考文档
├── examples/                # 示例 Plugin
├── scripts/                 # 文档管理工具脚本
├── .gitignore
└── README.md
```

---

## 3. 详细目录说明

### 3.1 `plugins/` - Plugin 集合目录（市场中的商品）

每个 Plugin 都是独立的 Claude Code Plugin，包含完整的 Plugin 结构。

```text
plugins/
├── plugin-a/               # Plugin A 示例
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── .mcp.json
│   ├── commands/
│   ├── skills/
│   ├── agents/
│   └── knowledge/
├── plugin-b/               # Plugin B 示例
│   └── ...
└── plugin-c/               # Plugin C 示例
    └── ...
```

---

### 3.2 单个 Plugin 结构

以 `plugin-a` 为例：

#### 3.2.1 `plugins/plugin-a/.claude-plugin/` - Plugin 元数据

**对齐参考**: `customplugin/plugins/code-review/.claude-plugin/`

```text
plugins/plugin-a/.claude-plugin/
└── plugin.json           # Plugin 清单文件
```

**plugin.json 结构**:

```json
{
  "name": "plugin-a",
  "version": "1.0.0",
  "description": "Plugin description",
  "author": {
    "name": "author-name",
    "email": "author@example.com"
  },
  "keywords": ["keyword1", "keyword2"]
}
```

---

#### 3.2.2 `plugins/plugin-a/.mcp.json` - MCP 配置

```text
plugins/plugin-a/.mcp.json
```

**配置示例**:

```json
{
  "mcpServers": {
    "plugin-a-server": {
      "command": "npx",
      "args": ["@scope/plugin-a-server"]
    }
  }
}
```

---

#### 3.2.3 `plugins/plugin-a/commands/` - 命令定义

**对齐参考**: `customplugin/plugins/code-review/commands/`

```text
plugins/plugin-a/commands/
├── plugin-a.md         # 主命令
├── plugin-a-action.md   # 子命令
└── ...
```

**命令 frontmatter 模板**:

```markdown
---
description: [命令描述]
argument-hint: [参数提示]
allowed-tools: ["Read", "Write", "Bash", ...]
model: inherit
---
```

---

#### 3.2.4 `plugins/plugin-a/skills/` - 技能定义

**对齐参考**: `customplugin/plugins/code-review/skills/`

```text
plugins/plugin-a/skills/
├── plugin-a/           # 主技能
│   └── SKILL.md
└── plugin-a-action/    # 子技能
    └── SKILL.md
```

**技能 frontmatter 模板**:

```markdown
---
name: [技能名称]
description: |
  [技能描述]
  <example>[示例1]</example>
  <example>[示例2]</example>
allowed-tools: [允许的工具列表]
license: MIT
---
```

---

#### 3.2.5 `plugins/plugin-a/agents/` - Agent 定义

```text
plugins/plugin-a/agents/
└── plugin-a-helper.md   # Plugin A 辅助 Agent
```

**Agent frontmatter 模板**:

```markdown
---
name: plugin-a-helper
description: |
  [Agent 描述]
whenToUse: |
  - [使用场景1]
  - [使用场景2]
model: sonnet
color: blue
tools: [工具列表]
---
```

---

#### 3.2.6 `plugins/plugin-a/knowledge/` - 知识库

**对齐参考**: `customplugin/plugins/code-review/knowledge/`

```text
plugins/plugin-a/knowledge/
├── guide.md           # 使用指南
├── troubleshooting.md  # 故障排查
└── best-practices.md   # 最佳实践
```

---

### 3.3 `docs/design/` - Marketplace 设计文档目录

```text
docs/design/
├── directory-structure.md    # 目录结构（本文档）
├── architecture.md          # Marketplace 架构设计
├── workflow.md             # 工作流设计
├── capability-list.md       # Marketplace 能力清单
└── interaction-protocol.md  # 交互协议
```

---

### 3.4 `docs/requirements/` - Marketplace 需求文档目录

```text
docs/requirements/
├── overview.md             # 需求概览
├── functional.md           # 功能需求
├── non-functional.md       # 非功能需求
├── user-stories.md         # 用户故事
└── acceptance-criteria.md # 验收标准
```

---

### 3.5 `docs/conventions/` - 约定规范目录

```text
docs/conventions/
├── lint.md      # Markdown Lint 规则
├── format.md    # 格式化约定
├── structure.md # Plugin 结构约定
└── naming.md    # 命名约定
```

---

### 3.6 `docs/reference/` - 参考文档目录

```text
docs/reference/
├── plugin-structure.md    # Plugin 结构参考
├── frontmatter-guide.md  # Frontmatter 指南
├── tool-reference.md     # 工具参考
└── api-reference.md      # API 参考
```

---

### 3.7 `examples/` - 示例 Plugin 目录

```text
examples/
├── minimal-plugin/        # 最小 Plugin 示例
│   ├── .claude-plugin/
│   │   └── plugin.json
│   └── README.md
├── standard-plugin/       # 标准 Plugin 示例
│   ├── .claude-plugin/
│   │   └── plugin.json
│   ├── commands/
│   ├── skills/
│   ├── agents/
│   └── README.md
└── advanced-plugin/       # 高级 Plugin 示例
    ├── .claude-plugin/
    │   └── plugin.json
    ├── .mcp.json
    ├── commands/
    ├── skills/
    ├── agents/
    ├── knowledge/
    └── README.md
```

---

### 3.8 `scripts/` - 文档管理工具脚本目录

```text
scripts/
├── validate.sh           # Plugin 文档验证脚本
├── format.sh             # 格式化脚本
├── lint.sh               # Lint 脚本
├── scaffold.sh           # Plugin 脚手架脚本
├── sync.sh               # 同步脚本
└── publish.sh            # 发布脚本
```

---

## 4. 配置文件

### 4.1 `.gitignore` - Git 忽略文件

```text
# 系统文件
.DS_Store
Thumbs.db

# 编辑器
.vscode/
.idea/
*.swp
*.swo

# 临时文件
*.tmp
*.log
```

---

### 4.2 `README.md` - 项目说明

```markdown
# Claude Code Plugin Marketplace

Claude Code Plugin 市场 - 用于发现、安装、管理和发布 Plugin。

## 项目结构
```

claude-code-plugins/
├── plugins/ # Plugin 集合（市场中的商品）
├── docs/ # Marketplace 设计文档
├── examples/ # 示例 Plugin
└── scripts/ # 工具脚本

```

## Plugins

- [Plugin A](plugins/plugin-a/) - Plugin A 描述
- [Plugin B](plugins/plugin-b/) - Plugin B 描述
- [Plugin C](plugins/plugin-c/) - Plugin C 描述

## 快速开始

详见各 Plugin 的使用指南。
```

---

## 5. 约定与规范

### 5.1 文件命名约定

| 类型          | 约定          | 示例                 |
| ------------- | ------------- | -------------------- |
| Plugin 目录   | kebab-case    | `plugin-a/`          |
| Markdown 文档 | kebab-case.md | `architecture.md`    |
| 命令文件      | kebab-case.md | `plugin-a-action.md` |
| 技能目录      | kebab-case/   | `plugin-a-action/`   |
| 技能文件      | SKILL.md      | `SKILL.md`           |

### 5.2 目录命名约定

| 类型        | 约定       | 示例               |
| ----------- | ---------- | ------------------ |
| Plugin 目录 | kebab-case | `plugin-a/`        |
| 文档目录    | kebab-case | `design/`          |
| 技能目录    | kebab-case | `plugin-a-action/` |

### 5.3 文档风格约定

- **Frontmatter**: 统一格式，参考 customplugin
- **Markdown**: 使用标准 Markdown 语法
- **代码块**: 指定语言类型
- **标题层级**: 使用清晰的层级结构

---

## 6. Marketplace 核心能力

| 能力        | 说明                     | 实现方式                  |
| ----------- | ------------------------ | ------------------------- |
| Plugin 发现 | 搜索和浏览可用 Plugin    | `docs/design/workflow.md` |
| Plugin 安装 | 从市场安装 Plugin 到本地 | `scripts/scaffold.sh`     |
| Plugin 管理 | 列出、更新、卸载 Plugin  | `scripts/` 脚本集合       |
| Plugin 发布 | 将新 Plugin 发布到市场   | `scripts/publish.sh`      |

---

## 7. 与 customplugin/plugins 对齐点

| 项目          | customplugin/plugins         | 本项目                                         |
| ------------- | ---------------------------- | ---------------------------------------------- |
| Plugin 元数据 | `.claude-plugin/plugin.json` | ✅ `plugins/{name}/.claude-plugin/plugin.json` |
| MCP 配置      | `.mcp.json`                  | ✅ `plugins/{name}/.mcp.json`                  |
| 命令定义      | `commands/*.md`              | ✅ `plugins/{name}/commands/*.md`              |
| 技能定义      | `skills/*/SKILL.md`          | ✅ `plugins/{name}/skills/*/SKILL.md`          |
| Agent 定义    | `agents/*.md`                | ✅ `plugins/{name}/agents/*.md`                |
| 知识库        | `knowledge/*.md`             | ✅ `plugins/{name}/knowledge/*.md`             |
| Frontmatter   | 统一格式                     | ✅ 保持一致                                    |

---

## 8. 目录结构对比

| 单 Plugin 项目    | Marketplace 项目                 | 说明                 |
| ----------------- | -------------------------------- | -------------------- |
| `.claude-plugin/` | `plugins/{name}/.claude-plugin/` | 每个 Plugin 独立     |
| `.mcp.json`       | `plugins/{name}/.mcp.json`       | 每个 Plugin 独立     |
| `commands/`       | `plugins/{name}/commands/`       | 每个 Plugin 独立     |
| `skills/`         | `plugins/{name}/skills/`         | 每个 Plugin 独立     |
| `agents/`         | `plugins/{name}/agents/`         | 每个 Plugin 独立     |
| `knowledge/`      | `plugins/{name}/knowledge/`      | 每个 Plugin 独立     |
| `docs/`           | `docs/`                          | Marketplace 设计文档 |

---

## 9. 下一步工作

1. **完善 Marketplace 设计文档**:

   - `architecture.md` - Marketplace 架构设计
   - `workflow.md` - 工作流设计
   - `capability-list.md` - 能力清单
   - `interaction-protocol.md` - 交互协议

2. **编写 Marketplace 需求文档**:

   - `overview.md` - 需求概览
   - `functional.md` - 功能需求
   - `non-functional.md` - 非功能需求

3. **编写约定文档**:

   - `lint.md` - Markdown Lint 规则
   - `format.md` - 格式化约定
   - `structure.md` - Plugin 结构约定

4. **创建目录结构**:
   - 初始化所有目录
   - 生成配置文件
   - 编写示例 Plugin

---

_文档版本: 4.0.0_
_最后更新: 2026-01-10_
_变更记录: 明确整个仓库是 Marketplace，plugins 是市场中的商品_
