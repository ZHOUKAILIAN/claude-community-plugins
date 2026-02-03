# REQ-009: 文档编号系统

## 1. 需求概述

### 1.1 需求背景

当前 `ai-doc-driven-dev` 插件的 `init-doc-driven-dev` 命令能够初始化文档驱动开发工作流，但在其他项目中使用时，创建的文档缺少统一的编号规范。本仓库使用的文档编号系统（如 `001-feature-name.md`）是手动维护的，这导致：

1. 其他项目无法自动获得编号规范
2. 新文档编号需要手动查找和分配
3. 文档配对关系（需求 ↔ 技术设计）不够清晰
4. 缺少自动化的编号管理机制

### 1.2 目标用户

- 使用 `ai-doc-driven-dev` 插件初始化新项目的开发者
- 需要维护文档驱动开发流程的团队
- 使用 Claude Code 进行项目开发的 AI 辅助开发者

### 1.3 核心价值

通过自动化文档编号系统，实现：
- **一致性**：所有使用该插件的项目都遵循统一的文档编号规范
- **可追溯性**：需求文档和技术设计文档通过编号清晰配对
- **自动化**：AI 自动扫描现有编号并分配新编号，无需人工干预
- **可维护性**：编号系统使文档历史和演进过程清晰可见

### 1.4 扩展需求：Commands 和 Skills 质量提升

基于官方 Claude Code 插件最佳实践分析（参考：`claude-plugins-official/official-patterns-analysis.md`），当前插件的 Commands 和 Skills 存在以下质量问题：

**Commands 质量问题**：
1. 缺少 Bash 内联执行收集上下文（如 `!`git status``）
2. 缺少明确的工作流阶段划分和停止点
3. 缺少详细的使用示例和参数说明
4. 指令不够精确，缺少"DO NOT"约束
5. 缺少条件处理逻辑（If-Then）

**Skills 质量问题**：
1. Description 字段未使用引号包裹触发短语
2. 缺少明确的 "When This Skill Applies" 章节
3. 工作流阶段不够清晰，缺少 Phase 划分
4. 缺少表格组织复杂信息
5. 缺少量化评估和评分系统
6. 缺少明确的输出格式模板

**期望改进**：
- 所有 Commands 和 Skills 遵循官方最佳实践
- 提升 AI 理解和执行的准确性
- 改善用户体验和文档可读性

### 1.5 需求合并说明

本需求已合并原 `REQ-008: Commands 和 Skills 优化`，统一管理以下范围：

**核心范围**：
1. **文档编号系统**：编号分配、配对、模板、CLAUDE.md 规范
2. **Commands/Skills 质量优化**：结构优化、官方最佳实践应用
3. **工具链与标准化**：脚手架、校验、测试、迁移工具

**合并理由**：
- 编号系统和文档规范密切相关，统一管理更高效
- 工具链可同时服务于编号系统和文档质量提升
- 避免需求文档碎片化，便于整体实施

### 1.6 写作规范要求

Commands 和 Skills 应遵循"说做什么，不说怎么做"的简洁原则：

**核心原则**：
- ✅ **简洁明了**：用简短的指令说明要做什么
- ✅ **指令式**：使用动词开头（Scan, Create, Verify）
- ✅ **突出重点**：关键步骤用粗体强调
- ❌ **避免啰嗦**：不要详细描述每个步骤的具体实现
- ❌ **避免教学式**：不要写"The skill will..."这样的描述

**对比示例**：

| 啰嗦版本 ❌ | 简洁版本 ✅ |
|-----------|-----------|
| "Create docs/ directory with requirements/, design/, standards/, and analysis/ subdirectories" | "Create docs/ structure" |
| "The skill will analyze existing codebase to understand API architecture and patterns" | "Analyze API architecture" |
| "Generate project-specific requirements documentation based on existing code analysis" | "Generate requirements from code analysis" |

**长度要求**：
- Commands：每个 Phase 的 Actions 不超过 5 个步骤
- Skills：每个 Phase 的 Actions 不超过 4 个步骤
- 每个步骤描述不超过 10 个单词（中文不超过 15 字）

## 2. 功能需求

### 2.1 核心功能

#### 2.1.1 自动编号分配

**功能描述**：
- AI 在创建新文档前自动扫描 `docs/requirements/` 目录
- 识别最大编号（如 `008`），自动分配下一个编号（`009`）
- 支持三位数编号格式：`001`, `002`, ..., `999`

**适用场景**：
- 执行 `init-doc-driven-dev` 命令初始化项目
- 创建新的需求文档
- 创建新的技术设计文档

#### 2.1.2 文档配对规范

**功能描述**：
- 需求文档格式：`NNN-feature-name.md`
- 技术设计文档格式：`NNN-feature-name-technical-design.md`
- 使用相同编号 `NNN` 确保配对关系

**示例**：
```
docs/requirements/009-document-numbering-system.md
docs/design/009-document-numbering-system-technical-design.md
```

#### 2.1.3 初始化模板更新

**功能描述**：
- 更新 `init-doc-driven-dev` 命令输出说明，体现编号规范
- 初始化项目时创建带编号的初始文档（`001-project-initial-requirements.md`）
- 在生成的 CLAUDE.md 中说明文档编号规范

#### 2.1.4 编号规范文档化

**功能描述**：
- 在 CLAUDE.md 模板中添加文档编号规范说明
- 在模板文件中添加编号使用说明
- 提供编号分配的自动化指导

### 2.2 辅助功能

#### 2.2.1 编号冲突检测

**功能描述**：
- 检测是否存在重复编号
- 检测编号序列是否有跳号（如 001, 002, 004，缺少 003）
- 提供警告和修复建议

#### 2.2.2 编号重新分配

**功能描述**：
- 支持批量重新编号（可选功能）
- 保持需求文档和技术设计文档的编号一致性

#### 2.2.3 文档索引生成

**功能描述**：
- 自动生成文档索引，列出所有编号文档
- 显示配对关系（需求 ↔ 技术设计）
- 标识缺失的配对文档

### 2.3 Commands 优化需求

基于官方最佳实践，对 4 个 Commands 进行优化：

#### 2.3.1 init-doc-driven-dev 优化

**当前问题**：
- 缺少 Context 章节收集项目信息
- 缺少明确的阶段划分
- 步骤描述过于详细啰嗦

**改进需求**：
1. 添加 Context 章节（Bash 内联执行）
2. 使用 Phase 结构（4 个阶段）
3. 简化 Actions 描述（每个步骤 ≤10 词）
4. 添加使用示例和输出格式

**示例**（简洁版）：
```markdown
## Phase 2: Directory Structure

**Goal**: Create standard documentation hierarchy

**Actions**:
1. Create docs/ structure
2. Verify creation

**DO NOT proceed until directories exist.**
```

#### 2.3.2 enforce-doc-workflow 优化

**当前问题**：
- 工作流描述不够清晰
- 缺少条件处理逻辑
- 步骤描述过于详细

**改进需求**：
1. 使用 Goal-Actions 结构
2. 添加条件逻辑（If-Then）
3. 添加停止点（WAIT/DO NOT）
4. 简化步骤描述

#### 2.3.3 analyze-docs 优化

**当前问题**：
- 缺少明确的分析步骤
- 缺少输出格式模板
- 缺少评分系统

**改进需求**：
1. 添加工作流步骤（7 步，每步 ≤10 词）
2. 添加评分系统（A-F）
3. 添加输出格式模板
4. 使用表格组织信息

#### 2.3.4 extract-patterns 优化

**当前问题**：
- 缺少具体的提取步骤
- 缺少模式优先级说明
- 缺少 LSP 工具使用说明

**改进需求**：
1. 添加提取工作流（简洁步骤）
2. 添加模式优先级排序
3. 添加 LSP 工具使用说明
4. 添加条件逻辑（基于项目类型）

### 2.4 Skills 优化需求

对 4 个 Skills 进行优化，遵循官方最佳实践：

#### 2.4.1 claude-md-enforcer 优化

**当前问题**：
- Description 未使用引号包裹触发短语
- 缺少 "When This Skill Applies" 章节
- 工作流阶段不够清晰

**改进需求**：
1. 优化 description（引号包裹触发短语）
2. 添加 "When This Skill Applies" 章节
3. 使用 Phase 结构（4 个阶段，简洁步骤）
4. 添加编号规范生成说明

#### 2.4.2 doc-detector 优化

**当前问题**：
- 缺少表格组织检查项
- 缺少评分系统
- 缺少编号完整性检查

**改进需求**：
1. 使用表格组织检查维度
2. 添加编号完整性检查
3. 添加评分系统（A-F）
4. 添加输出格式模板

#### 2.4.3 doc-generator 优化

**当前问题**：
- 缺少编号分配流程说明
- 缺少占位符说明
- 缺少验证步骤

**改进需求**：
1. 添加编号分配流程（简洁步骤）
2. 添加占位符表格
3. 添加验证和反馈章节
4. 保持步骤简洁（每步 ≤10 词）

#### 2.4.4 pattern-extractor 优化

**当前问题**：
- 缺少 LSP 工具使用说明
- 缺少模式优先级排序
- 缺少条件逻辑

**改进需求**：
1. 添加 LSP 工具使用说明
2. 添加模式优先级排序
3. 添加条件逻辑（基于项目类型）
4. 保持描述简洁

### 2.5 文档标准化与工具链

#### 2.5.1 文档模板与 Frontmatter 规范

- **Command 文档模板**：新增标准化模板（中/英文）
- **Skill 文档模板**：增强现有模板（中/英文）
- **Frontmatter 规范**：统一字段要求（版本、作者、依赖、兼容性等）
- **错误代码规范**：统一错误码与多语言提示格式

#### 2.5.2 脚手架工具

- 提供 `scaffold-command.sh` / `scaffold-skill.sh`
- 交互式收集必填字段，自动生成文档与示例
- 可选中英文双语输出

#### 2.5.3 验证与质量检查工具

- 提供 `validate-commands.sh` / `validate-skills.sh`
- 校验 frontmatter、必填字段、结构章节、依赖项、命名规范
- 支持 CI/CD 集成与详细错误报告

#### 2.5.4 测试框架

- 提供 commands/skills 的测试模板与 fixtures
- 支持单元测试、集成测试、覆盖率报告

#### 2.5.5 迁移与示例库

- 提供迁移工具，将现有文档迁移到新规范
- 提供最小/标准/高级示例库

## 3. 非功能需求

### 3.1 性能要求

- 编号扫描操作应在 1 秒内完成（对于 1000 个文档以内的项目）
- 不影响 `init-doc-driven-dev` 命令的整体执行时间

### 3.2 可用性要求

- 编号分配过程对用户透明，无需手动干预
- 提供清晰的编号规范说明文档
- AI 能够自动理解和应用编号规范

### 3.3 兼容性要求

- 兼容现有的文档结构和命名规范
- 不破坏已有项目的文档组织
- 支持从无编号系统平滑迁移到编号系统

### 3.4 可维护性要求

- 工具脚本应模块化、可复用、易于扩展
- 模板更新不应破坏已有文档结构
- 允许渐进式采用（旧文档可选迁移）

## 4. 约束条件

### 4.1 技术约束

- 使用 Bash、Glob、Grep 等工具进行文件扫描
- 编号格式固定为三位数字（`001`-`999`）
- 文档必须位于 `docs/requirements/` 和 `docs/design/` 目录

### 4.2 业务约束

- 编号一旦分配，不应随意更改（保持历史一致性）
- 需求文档和技术设计文档必须使用相同编号
- 编号应按时间顺序递增

## 5. 验收标准

### 5.1 功能验收 - 编号系统

- [ ] 在新项目执行 `init-doc-driven-dev` 时，自动创建 `001-project-initial-requirements.md` 和 `001-project-initial-technical-design.md`
- [ ] 文档标题包含编号：`# REQ-001: 项目初始化需求`
- [ ] AI 创建新文档前自动扫描并分配正确的下一个编号
- [ ] 生成的 CLAUDE.md 包含文档编号规范说明
- [ ] 模板文件包含编号使用指导和占位符
- [ ] `init-doc-driven-dev.md` 命令文档更新，反映编号系统

### 5.2 功能验收 - Commands 优化

- [ ] **init-doc-driven-dev**：
  - 包含 Context 章节（Bash 内联执行）
  - 使用 Phase 结构划分阶段
  - 包含详细使用示例
  - 包含输出格式模板

- [ ] **enforce-doc-workflow**：
  - 使用 Goal-Actions 结构
  - 包含条件处理逻辑（If-Then）
  - 包含明确停止点（WAIT/DO NOT）
  - 包含工作流集成建议

- [ ] **analyze-docs**：
  - 包含清晰的工作流步骤（1-7）
  - 包含评分系统（A-F）
  - 包含输出格式模板
  - 使用表格组织分析维度

- [ ] **extract-patterns**：
  - 包含明确的提取工作流
  - 包含模式优先级排序
  - 包含 LSP 工具使用说明
  - 包含条件逻辑

### 5.3 功能验收 - Skills 优化

- [ ] **claude-md-enforcer**：
  - Description 使用引号包裹触发短语
  - 包含 "When This Skill Applies" 章节
  - 使用 Phase 结构划分工作流
  - 包含编号规范生成说明

- [ ] **doc-detector**：
  - 使用表格组织检查维度
  - 包含评分系统（A-F）
  - 包含编号完整性检查
  - 包含输出格式模板

- [ ] **doc-generator**：
  - 包含详细的编号分配流程（6 步）
  - 包含占位符表格说明
  - 包含验证和反馈章节
  - 包含交互式生成说明

- [ ] **pattern-extractor**：
  - 包含 LSP 工具使用章节
  - 包含模式优先级分析
  - 包含条件逻辑
  - 包含增量更新说明

### 5.4 质量验收

- [ ] 编号分配无冲突、无重复
- [ ] 需求文档和技术设计文档编号正确配对
- [ ] 文件名编号与标题编号一致
- [ ] 文档编号规范清晰、易于理解
- [ ] AI 能够自动理解和执行编号规范
- [ ] 所有 Commands 遵循官方最佳实践
- [ ] 所有 Skills 遵循官方最佳实践
- [ ] 文档可读性和用户体验显著提升

### 5.5 工具链验收

- [ ] 提供标准化 Command/Skill 模板（中/英文）
- [ ] 脚手架工具可生成完整文档结构与示例
- [ ] 校验工具可检测规范违规并输出修复建议
- [ ] 测试框架可运行基本测试并生成报告
- [ ] 迁移工具可无损迁移现有文档

## 6. 用户故事

### 故事 1：新项目初始化
**作为** 开发者
**我想要** 在新项目执行 `init-doc-driven-dev` 时自动获得编号规范
**以便** 后续文档创建都遵循统一的编号系统

**验收标准**：
- 初始化后生成 `001-project-initial-requirements.md`
- CLAUDE.md 包含编号规范说明
- 后续创建文档时 AI 自动分配 `002`, `003` 等编号

### 故事 2：创建新需求文档
**作为** AI 助手
**我想要** 自动扫描现有文档编号并分配新编号
**以便** 无需用户手动指定编号

**验收标准**：
- AI 自动执行 `ls docs/requirements/ | grep -E '^[0-9]{3}-'` 查找最大编号
- 自动分配下一个编号（如最大为 `008`，则分配 `009`）
- 同时创建配对的需求文档和技术设计文档

### 故事 3：文档编号规范理解
**作为** 新团队成员
**我想要** 在 CLAUDE.md 中看到清晰的文档编号规范
**以便** 理解项目的文档组织方式

**验收标准**：
- CLAUDE.md 包含编号格式说明（`NNN-feature-name.md`）
- 包含需求文档和技术设计文档的配对关系说明
- 包含编号分配的自动化流程说明

## 7. 相关文档

### 7.1 需求和设计文档

- `docs/requirements/008-commands-skills-optimization.md` - 命令和技能优化需求（已合并到本文档）
- `docs/requirements/007-claude-md-optimization-separation.md` - CLAUDE.md 优化需求
- `docs/design/009-document-numbering-system-technical-design.md` - 本需求的技术设计
- `docs/analysis/skills-optimization-analysis.md` - Skills 优化分析报告

### 7.2 参考文档和标准

- `/Users/zhoukailian/Desktop/mySelf/claude-plugins-official/official-patterns-analysis.md` - 官方最佳实践分析
- `docs/standards/command-writing-guide.md` - Command 写作指南
- `docs/standards/skill-writing-guide.md` - Skill 写作指南

### 7.3 当前实现文件

**Commands**（4 个）：
- `plugins/ai-doc-driven-dev/commands/init-doc-driven-dev.md`
- `plugins/ai-doc-driven-dev/commands/enforce-doc-workflow.md`
- `plugins/ai-doc-driven-dev/commands/analyze-docs.md`
- `plugins/ai-doc-driven-dev/commands/extract-patterns.md`

**Skills**（4 个）：
- `plugins/ai-doc-driven-dev/skills/claude-md-enforcer/SKILL.md`
- `plugins/ai-doc-driven-dev/skills/doc-detector/SKILL.md`
- `plugins/ai-doc-driven-dev/skills/doc-generator/SKILL.md`
- `plugins/ai-doc-driven-dev/skills/pattern-extractor/SKILL.md`

**Templates**：
- `plugins/ai-doc-driven-dev/knowledge/templates/requirements-template.md`
- `plugins/ai-doc-driven-dev/knowledge/templates/technical-design-template.md`

### 7.4 待创建的工具链文件

**脚手架工具**：
- `scripts/scaffold-command.sh`
- `scripts/scaffold-skill.sh`

**校验工具**：
- `scripts/validate-commands.sh`
- `scripts/validate-skills.sh`

**测试和迁移**：
- `scripts/migrate-to-new-standard.sh`
- `scripts/generate-docs.sh`
- `tests/commands/`
- `tests/skills/`

**标准和示例**：
- `docs/standards/command-documentation-template.md`
- `docs/standards/skill-documentation-template.md`
- `docs/standards/frontmatter-specification.md`
- `docs/standards/error-codes.md`
- `examples/commands/`
- `examples/skills/`

## 8. 变更历史

| 版本 | 日期 | 作者 | 变更说明 |
|------|------|------|----------|
| 1.0.0 | 2026-01-31 | AI | 初始版本 |

---

*此文档将作为项目开发的指导性文档，所有实现都应基于此需求进行。*
