# 需求文档 004: Git Ops Helper - Git 操作 Skill

## 文档信息

- **编号**: REQ-004
- **标题**: Git Ops Helper - Git 操作 Skill
- **版本**: 1.0.0
- **创建日期**: 2026-01-16
- **状态**: 草案
- **依赖**: 无

## 1. 需求概述

### 1.1 背景

当前团队缺乏一个可复用的 Git 提交与专家操作能力，尤其在提交总结、冲突解决、rebase 指导等场景中需要稳定、可靠的流程化支持。

### 1.2 目标

- 提供提交总结与提交信息生成能力
- 提供 Git 专家级指导（冲突解决、rebase、cherry-pick 等）
- 对高风险操作提供安全提示与二次确认

### 1.3 核心问题

- **提交能力不足**：无法快速形成准确的变更总结与提交信息
- **复杂操作易失误**：rebase 与冲突处理缺少规范流程
- **风险缺少约束**：reset/revert 等高风险操作缺少保护与确认

## 2. 功能需求

### 2.1 基础操作

- 查看状态：status/branch/log
- 对比差异：diff（含已暂存、未暂存、与指定 commit 对比）
- 变更管理：add/rm/mv/restore
- 分支管理：branch/checkout/switch/merge
- 临时存放：stash/save/apply/pop
- 进阶操作：rebase/cherry-pick/merge 策略选择

### 2.2 提交总结与提交辅助

- 根据 git diff 与 git status 生成简要变更总结（中英文可选，默认跟随用户语言）
- 识别已暂存与未暂存改动，必要时分别总结
- 总结前需对改动进行代码检查
- 若检查发现问题，先提示用户并确认是否继续，再进行提交总结
- 生成建议的 commit message（默认 Conventional Commits，支持自定义）
- 若当前分支为 main/master，提交前询问是否切出新分支
- 提交前校验：确保有变更、说明包含范围与影响
- 提交后输出简短回顾（commit hash + summary）

### 2.3 冲突解决与 rebase 指导

- 冲突处理指导：展示冲突定位、解决、验证与继续流程
- 提供 rebase 典型流程（squash/reorder）与回退方案
- 在涉及强制推送时提示风险并确认

### 2.4 回滚与重置

- 支持 revert 指定 commit（含合并提交处理提示）
- 支持 reset（soft/mixed/hard）并明确风险说明
- 在执行高风险命令前必须二次确认
- 提供安全替代方案（优先 revert）

### 2.5 命令支持

- 提供一个命令：
  - `summarize-commit`：总结当前改动并生成提交建议（含代码检查）

### 2.6 典型使用场景示例

- “帮我总结这次改动并生成提交信息”
- “rebase 时遇到冲突，帮我解决并继续”
- “我要撤销上一次提交但保留代码”
- “回滚某个 commit 并提交新的 revert”
- “帮我把当前改动拆成两个 commit”

## 3. 非功能需求

### 3.1 安全与可控性

- 默认避免破坏性操作
- 必须在高风险操作前输出风险说明
- 所有 git 操作必须二次确认后执行
- 明确显示将执行的 git 命令并等待用户确认

### 3.2 可用性

- 输出简洁、可复制的命令
- 兼容常见 Git 版本（2.x）

## 4. 约束与范围

### 4.1 技术约束

- 仅使用本地 git CLI，不依赖网络
- 面向单仓库工作流

### 4.2 业务范围

- 覆盖常见开发流程与进阶 Git 操作
- 不覆盖复杂 CI/CD 或多仓库管理

## 5. 交付物与结构

### 5.1 技术交付物

- Git 操作 Skill（暂定名：git-ops-helper）
- 一个命令：`summarize-commit`

### 5.2 目录建议（待定）

```
plugins/git-ops-helper/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   └── git-ops-helper/
│       └── SKILL.md
└── commands/
    └── summarize-commit.md
```

## 6. 验收标准

### 6.1 功能验收

- 能正确读取 git status/diff/log 并生成变更总结
- 能生成可执行的 commit 建议与命令
- 能在 revert/reset 前输出风险提示并等待确认
- 能给出可执行的冲突解决与 rebase 指导

### 6.2 质量验收

- 指令清晰、步骤可复用
- 不出现未经确认的破坏性操作

## 7. 待确认事项

- Skill 名称与存放位置
- commit message 模板偏好（默认与自定义规则）
- rebase/merge 冲突处理的偏好流程与策略
- TODO: 评估后续如何结合 /review 或更完善的代码审查机制
