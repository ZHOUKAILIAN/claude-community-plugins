# TECH-20260311: ai-doc-driven-dev 文件命名规范更新 - 技术方案设计

## 文档信息

- **编号**: TECH-20260311
- **标题**: ai-doc-driven-dev 插件文件命名规范更新（序号制 → 日期制）
- **版本**: 1.0.0
- **创建日期**: 2026-03-11
- **状态**: 待实现
- **依赖**: REQ-20260311 (文件命名规范更新), TECH-20260203 (文档编号系统)

## 1. 技术架构概述

### 1.1 整体设计思路

本次变更是**规范性变更**，不涉及新功能开发，主要工作是：

1. 重命名 2 个插件模板文件
2. 更新模板内容（标题、frontmatter）
3. 更新所有引用旧命名规范的文档
4. 更新 `analyze-docs` 的命名规范合规检查项
5. 降低 Claude 专有命名偏置（`claude-*` 能力的中性职责说明）
6. 增强 Codex 可执行入口（`AGENTS.md` + 使用说明）
7. 更新 `CLAUDE.md` 项目规范

### 1.2 新旧命名对比

| 维度 | 旧规范（序号制） | 新规范（日期制） |
|------|----------------|----------------|
| 需求文档 | `NNN-feature-name.md` | `YYYYMMDD-feature-name.md` |
| 技术方案 | `NNN-feature-name-technical-design.md` | `YYYYMMDD-feature-name-technical-design.md` |
| 文档标题 | `# REQ-NNN: 标题` | `# REQ-YYYYMMDD: 标题` |
| 唯一性机制 | 扫描最大序号 +1 | 使用创建当天日期 |
| 冲突风险 | 并行创建时序号冲突 | 仅同天同名时冲突（追加 -v2） |

### 1.3 变更文件清单

```
plugins/ai-doc-driven-dev/
├── knowledge/templates/
│   ├── requirements-template.md              → 重命名 + 内容更新
│   │   → YYYYMMDD-feature-name.md
│   └── technical-design-template.md          → 重命名 + 内容更新
│       → YYYYMMDD-feature-name-technical-design.md
├── skills/doc-generator/SKILL.md             → 更新命名规范说明和路径引用
├── skills/doc-workflow-enforcer/SKILL.md        → 更新 CLAUDE.md 模板中的文档规范
├── commands/init-doc-driven-dev.md           → 更新文档创建说明
├── commands/analyze-docs.md                  → 增加命名规范合规检查说明
├── README.md                                 → 增加 Codex 使用说明
└── AGENTS.md                                 → 新增 Codex 工作流入口

docs/standards/
├── requirements-template.md                  → 更新标题格式
└── technical-design-template.md              → 更新标题格式

docs/requirements/                            → 现有序号制文档迁移重命名（001-010）
docs/design/                                  → 现有序号制文档迁移重命名（001-010）

CLAUDE.md                                     → 更新文档命名规范章节
```

## 2. 详细实现方案

### 2.1 模板文件重命名 + 内容更新

#### 2.1.1 操作步骤

```bash
git mv plugins/ai-doc-driven-dev/knowledge/templates/requirements-template.md \
       plugins/ai-doc-driven-dev/knowledge/templates/YYYYMMDD-feature-name.md

git mv plugins/ai-doc-driven-dev/knowledge/templates/technical-design-template.md \
       plugins/ai-doc-driven-dev/knowledge/templates/YYYYMMDD-feature-name-technical-design.md
```

#### 2.1.2 `YYYYMMDD-feature-name.md` 内容变更

**frontmatter**：

```yaml
---
type: "requirement"
version: "1.0.0"
date: "{{DATE}}"           # 新增 date 字段
lastUpdated: "{{DATE}}"
author: "{{AUTHOR}}"
status: "draft"
relatedFiles: []
---
```

**标题**：

```markdown
# 变更前
# {{PROJECT_NAME}} - 需求文档

# 变更后
# REQ-{{DATE}}: {{FEATURE_NAME}} - 需求文档
```

#### 2.1.3 `YYYYMMDD-feature-name-technical-design.md` 内容变更

**frontmatter**：

```yaml
---
type: "design"
version: "1.0.0"
date: "{{DATE}}"           # 新增 date 字段
lastUpdated: "{{DATE}}"
author: "{{AUTHOR}}"
status: "draft"
dependsOn: "REQ-{{DATE}}"  # 关联需求
relatedFiles: []
---
```

**标题**：

```markdown
# 变更前
# {{PROJECT_NAME}} - 技术方案设计

# 变更后
# TECH-{{DATE}}: {{FEATURE_NAME}} - 技术方案设计
```

### 2.2 规范文档更新

#### 2.2.1 `doc-generator/SKILL.md` 更新要点

- 命名规范说明：`YYYYMMDD-feature-name.md`（替换 `NNN-feature-name.md`）
- 模板路径引用：更新为新文件名
- 文件名生成逻辑：说明使用当天日期，无需扫描现有编号
- 同天冲突处理：追加 `-v2`

#### 2.2.2 `init-doc-driven-dev.md` 更新要点

- 初始化时创建示例文档：`{{TODAY}}-project-initial-requirements.md`（替换 `001-project-initial-requirements.md`）
- 文档命名说明：更新为日期制格式

#### 2.2.3 `doc-workflow-enforcer/SKILL.md` 更新要点

- 生成的 CLAUDE.md 模板中，文档命名规范章节替换为日期制说明

#### 2.2.4 `docs/standards/` 模板更新

- `requirements-template.md` 标题格式：`# 需求文档 YYYYMMDD: <项目名> - <简要说明>`
- `technical-design-template.md` 标题格式：`# 技术方案 YYYYMMDD: <项目名> - 技术设计`
- 文档信息中编号字段：`REQ-YYYYMMDD` / `TECH-YYYYMMDD`

#### 2.2.5 `CLAUDE.md` 更新要点

**文档命名规范章节**（原内容）：
```
- 需求文档：docs/requirements/NNN-feature-name.md
- 技术方案：docs/design/NNN-feature-name-technical-design.md
- AI 创建文档前需扫描 docs/requirements/ 确定下一个编号
```

**替换为**：
```
- 需求文档：docs/requirements/YYYYMMDD-feature-name.md
- 技术方案：docs/design/YYYYMMDD-feature-name-technical-design.md
- AI 创建文档时直接使用当天日期，无需扫描现有编号
- 同天同名冲突：追加 -v2、-v3 后缀
```

#### 2.2.6 `analyze-docs.md` 更新要点

- 在分析范围中增加“文档命名规范合规性”检查
- 明确检测 `NNN-` 旧格式残留和编号-文件名不一致问题
- 在输出报告中增加命名规范整改建议

#### 2.2.7 Codex 支持文档更新要点

- 增加入口映射说明：Claude Code 使用 `CLAUDE.md`，Codex 使用 `AGENTS.md`
- 新增插件级 `AGENTS.md`，定义 Codex 下的文档驱动工作流
- 在插件 `README.md` 增加“Codex 使用方式”章节，说明通过任务意图触发工作流
- 将日期制命名规范写入 Codex 可读取入口，避免继续生成序号制文件

#### 2.2.8 Claude 偏置兼容更新要点

- 对 `doc-workflow-enforcer`（历史名 `claude-md-enforcer`）增加“历史命名/通用职责”说明，避免被理解为 Claude-only
- 在相关文档中使用中性术语（如 documentation workflow enforcer）描述职责
- 对所有执行说明增加“Codex 可通过等价步骤执行”的兼容描述
- 定义“代理无关规范层”：`CLAUDE.md` 与 `AGENTS.md` 的规则语义必须一致，仅入口文件名不同

### 2.3 分支策略与缺陷判定流程

#### 2.3.1 分支可回溯要求

- 每个需求实现应在独立分支进行，分支名包含需求标识（推荐：`req-YYYYMMDD-feature-name`）
- 需求内 bug 修复优先在原需求分支继续提交，确保“需求-提交-文档”链路可回溯
- 若原分支已合并或不可用，再创建修复分支（推荐：`bugfix/req-YYYYMMDD-feature-name-<short-desc>`），并在文档中回链原需求

#### 2.3.2 同分支场景的用户确认

当检测到当前分支与既有需求分支一致时，执行前置确认：

1. 向用户确认该任务是否属于“原需求内 bug 修复”
2. 若用户确认是 bug：回补原需求/技术方案文档，不新建需求编号
3. 若用户确认不是 bug：按新需求流程处理（新需求文档 + 新分支）

### 2.4 本仓库现有文档迁移

本仓库 `docs/requirements/` 和 `docs/design/` 下现有 001-010 共 19 个序号制文档，需一并迁移到日期制。

#### 2.4.1 迁移映射表

迁移时使用各文档的**原始创建日期**（从 git 历史获取），而非当前日期，以保留真实时序。

**获取各文件创建日期**：

```bash
git log --diff-filter=A --follow --format="%ad" --date=format:"%Y%m%d" -- <文件路径> | tail -1
```

**需求文档迁移**：

| 旧文件名 | 迁移后文件名 |
|---------|------------|
| `001-ai-doc-driven-dev-base-features.md` | `{创建日期}-ai-doc-driven-dev-base-features.md` |
| `002-ai-doc-driven-dev-agents-commands.md` | `{创建日期}-ai-doc-driven-dev-agents-commands.md` |
| `003-js-framework-repository-analyzer.md` | `{创建日期}-js-framework-repository-analyzer.md` |
| `004-git-ops-skill.md` | `{创建日期}-git-ops-skill.md` |
| `005-enforce-doc-workflow-command.md` | `{创建日期}-enforce-doc-workflow-command.md` |
| `006-enforce-doc-workflow-scan-optimization.md` | `{创建日期}-enforce-doc-workflow-scan-optimization.md` |
| `007-claude-md-optimization-separation.md` | `{创建日期}-claude-md-optimization-separation.md` |
| `008-commands-skills-optimization.md` | `{创建日期}-commands-skills-optimization.md` |
| `009-document-numbering-system.md` | `{创建日期}-document-numbering-system.md` |
| `20260311-doc-filename-template-update.md` | `20260311-doc-filename-template-update.md` |

**技术方案文档迁移**：

| 旧文件名 | 迁移后文件名 |
|---------|------------|
| `001-ai-doc-driven-dev-technical-design.md` | `{创建日期}-ai-doc-driven-dev-technical-design.md` |
| `002-ai-doc-driven-dev-agents-commands-technical-design.md` | `{创建日期}-ai-doc-driven-dev-agents-commands-technical-design.md` |
| `003-js-framework-repository-analyzer-technical-design.md` | `{创建日期}-js-framework-repository-analyzer-technical-design.md` |
| `004-git-ops-skill-technical-design.md` | `{创建日期}-git-ops-skill-technical-design.md` |
| `005-enforce-doc-workflow-command-technical-design.md` | `{创建日期}-enforce-doc-workflow-command-technical-design.md` |
| `006-enforce-doc-workflow-scan-optimization-technical-design.md` | `{创建日期}-enforce-doc-workflow-scan-optimization-technical-design.md` |
| `007-claude-md-optimization-separation-technical-design.md` | `{创建日期}-claude-md-optimization-separation-technical-design.md` |
| `009-document-numbering-system-technical-design.md` | `{创建日期}-document-numbering-system-technical-design.md` |
| `20260311-doc-filename-template-update-technical-design.md` | `20260311-doc-filename-template-update-technical-design.md` |

> 注：`008-commands-skills-optimization` 无对应技术方案文件（已合并入 009），无需处理。

#### 2.4.2 迁移操作

```bash
# 示例：批量用 git mv 迁移（实际执行时以真实创建日期替换占位符）
git mv docs/requirements/001-ai-doc-driven-dev-base-features.md \
       docs/requirements/20XXXXXX-ai-doc-driven-dev-base-features.md
# ... 以此类推
```

#### 2.4.3 文档内容更新

迁移后同步更新各文档内部的 `**编号**` 字段：
- `REQ-20260110` → `REQ-20XXXXXX`
- `TECH-20260110` → `TECH-20XXXXXX`

以及 `**依赖**` 字段中引用其他文档的编号。

#### 2.4.4 交叉引用更新

迁移后需更新所有文档中的相互引用路径（如 `docs/requirements/009-xxx.md` → `docs/requirements/20XXXXXX-xxx.md`）：

```bash
# 扫描所有交叉引用
grep -r "00[0-9]-\|010-" docs/ --include="*.md" -l
```

## 3. 实现步骤

1. **扫描引用**：Grep 确认所有引用 `requirements-template`、`technical-design-template`、`NNN-` 命名格式的位置
2. **获取创建日期**：用 `git log` 获取现有 001-010 各文档的原始创建日期
3. **迁移现有文档**：`git mv` 批量重命名 `docs/requirements/` 和 `docs/design/` 下的 19 个文件
4. **更新文档内部编号**：同步修改各文档的标题和 `**编号**` 字段
5. **更新交叉引用**：修复文档间的相互路径引用
6. **重命名插件模板**：`git mv` 重命名 `knowledge/templates/` 下两个模板文件
7. **更新模板内容**：修改标题格式和 frontmatter
8. **更新 skills/commands**：按 2.2 节逐一更新各文档
9. **更新 docs/standards**：更新仓库级模板标题格式
10. **补充 Codex 支持入口**：新增插件级 `AGENTS.md`，并更新插件 `README.md`
11. **补充 Claude 偏置兼容说明**：为 `claude-*` 相关能力增加中性职责与 Codex 等价执行说明
12. **更新 CLAUDE.md**：替换文档命名规范章节
13. **验证**：Grep 确认无残留旧格式引用和强绑定表述
14. **缺陷文档策略对齐**：已有需求范围内的 bug 仅回补原需求/技术方案，不新建需求编号
15. **分支策略落地**：按需求分支可回溯规则执行；同分支场景先向用户确认是否为 bug

## 4. 风险评估

| 风险 | 概率 | 影响 | 缓解措施 |
|------|------|------|----------|
| 遗漏引用更新 | 中 | 中 | 实现前后各 Grep 一次；交叉引用更新后全量验证 |
| git 历史中创建日期获取不准确 | 低 | 低 | 手动核对，重要文档可查 commit message 确认 |
| 现有文档内部编号与文件名不一致 | 低 | 低 | 更新文件名时同步更新内部编号字段 |
| 同天创建多个同名文档冲突 | 低 | 低 | 追加 -v2 后缀，文档中明确说明 |
| Codex 未读取到规范入口导致仍用旧命名 | 中 | 中 | 在插件目录新增 `AGENTS.md` 并在 README 明确入口 |
| 文档仍保留 Claude-only 强绑定表达 | 中 | 中 | 为 `claude-*` 增加中性职责说明并补充 Codex 等价执行路径 |
| `CLAUDE.md` 与 `AGENTS.md` 规范语义漂移 | 中 | 中 | 将核心规则抽象为统一规范，双入口同步维护 |
| 同分支任务误判导致错误新建需求 | 中 | 中 | 同分支场景必须先向用户确认是否为原需求 bug |

## 5. 质量保证

### 5.1 验证清单

**现有文档迁移**：
- [ ] `docs/requirements/` 下不再有 `001-` 至 `010-` 前缀文件
- [ ] `docs/design/` 下不再有 `001-` 至 `010-` 前缀文件（除 `directory-structure.md`）
- [ ] 所有迁移后的文档内部编号字段已同步更新
- [ ] Grep 确认无残留交叉引用旧文件名

**插件模板**：
- [ ] 两个新模板文件存在，旧文件已不存在
- [ ] 模板标题格式包含 `YYYYMMDD` 占位符

**规范文档**：
- [ ] Grep 确认无残留 `requirements-template`、`technical-design-template` 引用
- [ ] Grep 确认无残留 `NNN-feature-name` 格式说明（CLAUDE.md、skills、commands 中）
- [ ] `doc-generator/SKILL.md` 文件名生成逻辑已更新为日期制
- [ ] `analyze-docs.md` 已包含命名规范合规检查说明
- [ ] `CLAUDE.md` 文档命名规范章节已更新

**Codex 支持**：
- [ ] `plugins/ai-doc-driven-dev/AGENTS.md` 已创建并包含文档驱动流程
- [ ] `plugins/ai-doc-driven-dev/README.md` 已包含 Codex 使用方式
- [ ] Codex 指引中已明确日期制命名和同天冲突处理（`-v2`）
- [ ] 已明确入口映射：`CLAUDE.md`（CC）/`AGENTS.md`（Codex）

**Claude 偏置兼容**：
- [ ] `doc-workflow-enforcer`（历史名 `claude-md-enforcer`）已提供“历史命名 + 通用职责”说明
- [ ] 关键规范文档中不存在将 Claude CLI 作为唯一执行入口的描述
- [ ] `CLAUDE.md` 与 `AGENTS.md` 核心规则语义保持一致

**分支与缺陷流程**：
- [ ] 技术方案已定义需求分支可回溯命名规则
- [ ] 同分支场景已定义“先确认是否为 bug”的前置步骤
- [ ] bug 判定为“是”时，流程明确回补原需求文档且不新开需求编号

## 6. 变更历史

| 版本 | 日期 | 作者 | 变更说明 |
|------|------|------|----------|
| 1.0.0 | 2026-03-11 | AI | 初始版本 |

---

*此技术方案将指导具体的开发实现，确保技术选择的合理性和可行性。*
