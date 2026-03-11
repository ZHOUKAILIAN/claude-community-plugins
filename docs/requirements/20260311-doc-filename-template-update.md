# REQ-20260311: ai-doc-driven-dev 文件命名规范更新（序号制 → 日期制）

## 文档信息

- **编号**: REQ-20260311
- **标题**: ai-doc-driven-dev 插件文件命名规范更新
- **版本**: 1.0.0
- **创建日期**: 2026-03-11
- **状态**: 草案
- **依赖**: REQ-20260203 (文档编号系统)

## 1. 需求背景

### 1.1 问题现状

当前 `ai-doc-driven-dev` 插件及本仓库采用 `NNN-feature-name.md` 的三位序号命名规范（由 REQ-20260203 建立）。在实际使用中，该规范暴露出以下问题：

**序号冲突问题**：
- 当多个需求/任务并行推进时，不同的人或 AI 实例会同时扫描现有最大序号，分别分配相同的下一个序号（如都认为下一个是 `010`），导致序号冲突
- 序号冲突后需要人工介入重新编号，破坏文档历史连续性
- AI 创建文档时无法可靠地保证全局唯一性

**序号管理开销**：
- 每次创建新文档都需要先 `ls docs/requirements/` 扫描最大编号
- 序号一旦冲突，修复成本高（需要同步更新文件名、标题、交叉引用）

**工具耦合问题（Claude Code 偏置）**：
- 现有文档和能力命名中存在明显的 Claude Code 绑定（如历史名 `claude-md-enforcer`）
- 对 Codex 等其他 coding agent 缺少等价入口和统一说明
- 实际效果是“规范可复用，但执行入口不可复用”，导致跨代理协作成本高
- 典型入口文件存在运行时差异：Claude Code 侧依赖 `CLAUDE.md`，Codex 侧依赖 `AGENTS.md`

### 1.2 解决方案

将文件命名规范从**序号制**改为**日期制**：

| 文档类型 | 旧格式 | 新格式 |
|---------|--------|--------|
| 需求文档 | `NNN-feature-name.md` | `YYYYMMDD-feature-name.md` |
| 技术方案 | `NNN-feature-name-technical-design.md` | `YYYYMMDD-feature-name-technical-design.md` |

**日期制优势**：
- **天然唯一性**：同一天内同一需求名不会重复，跨天不会冲突
- **无需扫描**：AI 直接使用当天日期，无需先扫描现有文件
- **时序可读**：文件按时间排序，文档演进历史一目了然
- **并行安全**：多任务并行时各自使用当天日期，只要需求名不同即无冲突

### 1.3 目标用户

- 使用 `ai-doc-driven-dev` 插件初始化项目的开发者
- 执行 `init-doc-driven-dev`、`doc-generator` skill 的 AI
- 使用 Codex 等非 Claude Code 运行时的 AI 代理

### 1.4 核心价值

- **消除冲突**：日期+需求名的组合天然全局唯一
- **降低开销**：AI 无需扫描现有编号，直接生成文件名
- **提升可读性**：文件名包含创建日期，文档时序清晰

### 1.5 “文档驱动”定义（本需求语境）

本需求中的“文档驱动”指：

- 先文档后实现：先完成需求/技术方案，再进入代码实现
- 文档即约束：命名规范、流程规则、验收标准以文档为准
- 入口可不同、语义需一致：Claude Code 读取 `CLAUDE.md`，Codex 读取 `AGENTS.md`，但核心规则保持一致

## 2. 功能需求

### 2.1 文件命名规范变更

#### 2.1.1 新命名格式

```
需求文档：  YYYYMMDD-feature-name.md
技术方案：  YYYYMMDD-feature-name-technical-design.md
```

**示例**（今天 2026-03-11 创建）：
```
docs/requirements/20260311-doc-filename-template-update.md
docs/design/20260311-doc-filename-template-update-technical-design.md
```

#### 2.1.2 日期格式规则

- 格式：`YYYYMMDD`（8位，无分隔符）
- 值：文档**创建当天**的日期
- 同一天同一需求名只创建一次；若同天需要第二个同名文档，追加后缀 `-v2`

#### 2.1.3 文档内部标识变更

文档标题中的编号前缀同步调整：

| 旧格式 | 新格式 |
|--------|--------|
| `# REQ-NNN: 标题` | `# REQ-YYYYMMDD: 标题` |
| `# TECH-NNN: 标题` | `# TECH-YYYYMMDD: 标题` |

### 2.2 插件模板文件更新

#### 2.2.1 `knowledge/templates/` 模板文件重命名

| 当前文件名 | 新文件名 |
|-----------|---------|
| `requirements-template.md` | `YYYYMMDD-feature-name.md` |
| `technical-design-template.md` | `YYYYMMDD-feature-name-technical-design.md` |

> 说明：新文件名直接以命名规范模式作为文件名，使用者看到文件名即理解目标文档的命名格式。

#### 2.2.2 模板内容更新

同步更新模板内部内容：

- 标题格式：`# REQ-YYYYMMDD: {{FEATURE_NAME}} - 需求文档`
- 标题格式：`# TECH-YYYYMMDD: {{FEATURE_NAME}} - 技术方案设计`
- frontmatter `type` 字段：`requirement` / `design`
- frontmatter 新增 `date` 字段：`"{{DATE}}"`

### 2.3 规范文档更新

以下位置引用了旧命名规范，需同步更新：

1. `plugins/ai-doc-driven-dev/skills/doc-generator/SKILL.md` - 模板路径和命名说明
2. `plugins/ai-doc-driven-dev/commands/init-doc-driven-dev.md` - 文档创建说明
3. `plugins/ai-doc-driven-dev/commands/analyze-docs.md` - 文档分析项中增加命名规范合规检查
4. `plugins/ai-doc-driven-dev/skills/doc-workflow-enforcer/SKILL.md` - CLAUDE.md 模板中的文档规范说明
5. `docs/standards/requirements-template.md` - 仓库级模板（标题格式）
6. `docs/standards/technical-design-template.md` - 仓库级模板（标题格式）
7. `CLAUDE.md` - 项目文档规范章节

### 2.4 analyze-docs 规则联动

`analyze-docs` 命令需显式识别并报告命名规范问题，避免仓库长期混用新旧格式：

- 检测 `docs/requirements/`、`docs/design/` 下是否残留 `NNN-` 前缀文件
- 检测文档内部标题/编号是否与文件名前缀一致（`REQ/TECH-YYYYMMDD`）
- 在分析报告中增加“命名规范合规”结果与整改建议

### 2.5 Codex 支持增强

当前插件文档主要围绕 Claude Code CLI 指令，Codex 用户缺少可直接执行的入口。需补充以下支持：

- 在规范中明确入口映射：
  - Claude Code：`CLAUDE.md`
  - Codex：`AGENTS.md`
- 在插件目录提供 `AGENTS.md`，明确 Codex 下的文档驱动工作流与执行顺序
- 在插件说明文档中补充 Codex 使用方式（以任务意图触发流程，而非 `claude <command>`）
- 将日期制命名规范写入 Codex 可读取的规范入口，确保其生成文档时不再沿用序号制

### 2.6 Claude 偏置能力的兼容要求

对于现有历史命名能力（如 `claude-md-enforcer`，当前统一为 `doc-workflow-enforcer`），需要提供 Codex 友好兼容策略：

- 对外说明使用“文档工作流强制执行器（workflow enforcer）”的中性概念，而非仅强调 Claude 专有能力
- 在文档中声明：`claude-md-enforcer` 为历史命名，`doc-workflow-enforcer` 为当前命名，Codex 可通过等价流程执行相同职责
- 避免在规范描述中将 `claude <command>` 作为唯一执行方式
- 在需求文档中增加“代理无关规范层”要求：规则语义在 `CLAUDE.md` 与 `AGENTS.md` 两种入口中保持一致

### 2.7 现有文档迁移

本仓库 `docs/requirements/` 和 `docs/design/` 下现有 001-010 共 19 个序号制文档，**需一并迁移**到日期制，以保持仓库内命名规范统一。

迁移原则：
- 使用各文档的**原始 git 创建日期**作为日期前缀（非当前日期），保留真实时序
- 同步更新文档内部标题和编号字段
- 同步修复文档间的交叉引用路径

## 3. 非功能需求

### 3.1 向后兼容

- 现有序号制文档**一并迁移**到日期制，不保留旧格式文件
- 迁移使用原始 git 创建日期，保持文档时序真实性

### 3.2 唯一性保障

- 同天同名文档通过追加 `-v2`、`-v3` 后缀解决
- AI 在创建文档前仍需检查当天是否已有同名文档

## 4. 约束条件

### 4.1 技术约束

- 日期部分固定为 `YYYYMMDD` 8位格式
- 需求名部分使用 kebab-case，全小写
- 完整文件名示例：`20260311-doc-filename-template-update.md`

### 4.2 业务约束

- 现有序号制文档需全部迁移，不允许新旧格式长期混用
- 所有新文档一律遵循日期制

### 4.3 本次需求对齐范围边界

- 本次仅对齐 `docs/` 目录下的需求/技术方案文档内容
- 不修改 `plugins/`、根目录说明文档或其他目录的实现与配置
- 其他目录改动作为后续实现阶段工作，不属于本次“需求对齐”范围

### 4.4 需求缺陷修复文档规则

- 若某问题被判定为“已有需求范围内的 bug”，应在原需求/技术方案文档中补充修复说明
- 不为同一需求下的 bug 单独新建需求文档编号
- 仅当问题超出原需求边界、形成新的独立能力时，才允许新建需求文档

## 5. 验收标准

### 5.1 模板文件验收

- [ ] `knowledge/templates/YYYYMMDD-feature-name.md` 存在
- [ ] `knowledge/templates/YYYYMMDD-feature-name-technical-design.md` 存在
- [ ] 旧模板文件 `requirements-template.md`、`technical-design-template.md` 已删除或重命名

### 5.2 模板内容验收

- [ ] 需求模板标题格式为 `# REQ-YYYYMMDD: {{FEATURE_NAME}} - 需求文档`
- [ ] 技术方案模板标题格式为 `# TECH-YYYYMMDD: {{FEATURE_NAME}} - 技术方案设计`
- [ ] frontmatter 包含 `date: "{{DATE}}"` 字段

### 5.3 现有文档迁移验收

- [ ] `docs/requirements/` 下不再有 `001-` 至 `010-` 前缀文件
- [ ] `docs/design/` 下不再有 `001-` 至 `010-` 前缀文件（`directory-structure.md` 除外）
- [ ] 所有迁移后文档的内部编号字段已同步更新
- [ ] 文档间交叉引用路径无残留旧文件名

### 5.4 规范文档验收

- [ ] `doc-generator/SKILL.md` 中命名规范已更新为日期制
- [ ] `init-doc-driven-dev.md` 中文档创建说明已更新
- [ ] `analyze-docs.md` 已增加命名规范合规检查说明
- [ ] `doc-workflow-enforcer/SKILL.md` 中 CLAUDE.md 模板已更新
- [ ] `CLAUDE.md` 文档命名规范章节已更新

### 5.5 可用性验收

- [ ] AI 执行 `doc-generator` 时无需扫描现有编号，直接使用当天日期生成文件名
- [ ] 文档说明同天同名冲突的处理方式（追加 `-v2`）

### 5.6 Codex 支持验收

- [ ] 插件目录存在 `AGENTS.md`，包含文档驱动工作流与日期制命名规范
- [ ] 插件文档已提供 Codex 下的使用指引
- [ ] Codex 根据仓库规范创建文档时默认使用 `YYYYMMDD` 命名
- [ ] 需求中已明确 `CLAUDE.md`（CC）与 `AGENTS.md`（Codex）入口映射

### 5.7 Claude 偏置兼容验收

- [ ] 文档中已声明 `doc-workflow-enforcer` 的通用职责和 Codex 等价执行方式
- [ ] 规范描述中不存在将 `claude <command>` 作为唯一入口的强绑定表述
- [ ] `CLAUDE.md` 与 `AGENTS.md` 承载同一套核心规范语义，无冲突

### 5.8 缺陷修复流程验收

- [ ] 文档中已明确“已有需求的 bug 回补原需求文档，不新开需求编号”
- [ ] 同分支继续开发场景下，流程要求先与用户确认“是否为原需求 bug”

## 6. 相关文档

- `docs/requirements/20260203-document-numbering-system.md` - 旧编号系统需求（本需求部分替代之）
- `docs/design/20260311-doc-filename-template-update-technical-design.md` - 本需求技术方案
- `plugins/ai-doc-driven-dev/knowledge/templates/` - 待修改模板目录
- `plugins/ai-doc-driven-dev/commands/analyze-docs.md` - 文档分析命令（需新增命名合规检查）
- `plugins/ai-doc-driven-dev/AGENTS.md` - Codex 工作流入口（新增）
- `CLAUDE.md` - 项目文档规范（需同步更新）

## 7. 变更历史

| 版本 | 日期 | 作者 | 变更说明 |
|------|------|------|----------|
| 1.0.0 | 2026-03-11 | AI | 初始版本，需求改为日期制命名 |

---

*此文档将作为项目开发的指导性文档，所有实现都应基于此需求进行。*
