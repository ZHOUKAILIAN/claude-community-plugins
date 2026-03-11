# TECH-20260203: 文档编号系统 - 技术设计

## 1. 技术架构概述

### 1.1 整体设计思路

本设计在“编号系统 + 文档与插件规范化工具链”两条主线上推进，采用**轻量级、自动化、AI 驱动**的设计理念：

1. **无数据库依赖**：通过文件系统扫描获取编号信息，无需额外存储
2. **AI 自动化**：利用 Claude Code 的 AI 能力自动执行编号分配逻辑
3. **规范嵌入**：将编号规范嵌入 CLAUDE.md 和模板中，确保 AI 自动遵循
4. **工具链标准化**：通过模板/脚手架/校验/测试/迁移工具统一 Commands/Skills 质量
5. **向后兼容**：支持现有项目平滑迁移，不破坏已有文档结构

### 1.2 架构设计

```
┌─────────────────────────────────────────────────────────┐
│                    AI (Claude Code)                      │
│  - 读取 CLAUDE.md 中的编号规范                             │
│  - 自动扫描 docs/requirements/ 获取最大编号                │
│  - 分配新编号并创建配对文档                                │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────┐
│              文档编号规范 (CLAUDE.md)                      │
│  - 编号格式定义                                           │
│  - 配对关系说明                                           │
│  - 自动化流程指导                                         │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────┐
│                  文档模板系统                             │
│  requirements-template.md                                │
│  technical-design-template.md                            │
│  (包含编号占位符 {{DOC_NUMBER}} 和使用说明)                │
└─────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────┐
│                 init-doc-driven-dev                      │
│  - 创建初始编号文档 (001-xxx.md)                          │
│  - 生成包含编号规范的 CLAUDE.md                           │
│  - 建立文档结构                                           │
└─────────────────────────────────────────────────────────┘
```

## 2. 技术栈选择

### 2.1 核心技术

| 技术 | 用途 | 理由 |
|------|------|------|
| Bash | 文件扫描、编号提取 | Claude Code 原生支持，高效简洁 |
| Glob | 文件模式匹配 | 快速定位编号文档 |
| Grep | 编号格式验证 | 正则表达式支持 |
| Markdown | 文档格式 | 项目标准格式 |

### 2.2 不使用的技术

- ❌ 数据库：增加复杂度，违背轻量级原则
- ❌ 配置文件：编号信息可从文件系统直接获取
> 说明：本设计会新增脚手架、校验、迁移等脚本以满足 REQ-20260203 合并范围的工具链要求。

## 3. 详细设计

### 3.1 编号分配算法

#### 3.1.1 扫描逻辑

```bash
# AI 自动执行的命令
ls docs/requirements/ | grep -E '^[0-9]{3}-' | sort -r | head -1
```

**输出示例**：`20260203-commands-skills-optimization.md`

#### 3.1.2 编号提取

```bash
# 提取编号部分
echo "20260203-commands-skills-optimization.md" | cut -d'-' -f1
# 输出: 008
```

#### 3.1.3 下一个编号计算

```bash
# 转换为整数并加 1
next_num=$((10#008 + 1))
# 格式化为三位数
printf "%03d" $next_num
# 输出: 009
```

#### 3.1.4 AI 自动化流程

AI 在创建新文档前自动执行：

```
1. 扫描 docs/requirements/ 目录
2. 提取最大编号（如 008）
3. 计算下一个编号（009）
4. 创建配对文档：
   - 文件名：009-feature-name.md
   - 标题：# REQ-20260203: 功能名称
```

### 3.2 CLAUDE.md 编号规范模板

在生成的 CLAUDE.md 中添加以下章节：

```markdown
## 文档编号规范

### 编号格式

所有需求文档和技术设计文档必须使用统一的编号格式：

**文件名格式**：
- 需求文档：`docs/requirements/NNN-feature-name.md`
- 技术设计文档：`docs/design/NNN-feature-name-technical-design.md`
- 编号格式：三位数字（001-999），前导零不可省略

**文档标题格式**：
- 需求文档：`# REQ-NNN: 功能名称`
- 技术设计文档：`# DESIGN-NNN: 功能名称 - 技术设计`

### 编号配对

每个需求文档必须有对应的技术设计文档，使用相同编号：

**示例**：
```
文件名：
docs/requirements/20260203-document-numbering-system.md
docs/design/20260203-document-numbering-system-technical-design.md

文档标题：
# REQ-20260203: 文档编号系统
# TECH-20260203: 文档编号系统 - 技术设计
```

### 编号分配流程

**AI 自动化流程**（无需人工干预）：

1. **扫描现有编号**：
   ```bash
   ls docs/requirements/ | grep -E '^[0-9]{3}-' | sort -r | head -1
   ```

2. **提取最大编号**：
   ```bash
   echo "008-xxx.md" | cut -d'-' -f1  # 输出: 008
   ```

3. **计算下一个编号**：
   ```bash
   next_num=$((10#008 + 1))
   printf "%03d" $next_num  # 输出: 009
   ```

4. **创建配对文档**：
   - 文件名：`009-new-feature.md` 和 `009-new-feature-technical-design.md`
   - 标题：`# REQ-20260203: 新功能` 和 `# TECH-20260203: 新功能 - 技术设计`

### 编号规则

- ✅ 编号必须连续递增（001, 002, 003...）
- ✅ 需求文档和技术设计文档必须使用相同编号
- ✅ 文件名和文档标题中的编号必须一致
- ✅ 编号一旦分配，不应更改（保持历史一致性）
- ❌ 禁止跳号或重复编号
- ❌ 禁止手动指定编号（由 AI 自动分配）

### 初始化项目

执行 `init-doc-driven-dev` 时自动创建：
- 文件：`docs/requirements/001-project-initial-requirements.md`
- 标题：`# REQ-20260110: 项目初始化需求`
- 文件：`docs/design/001-project-initial-technical-design.md`
- 标题：`# DESIGN-001: 项目初始化需求 - 技术设计`
```

### 3.3 模板文件更新

#### 3.3.1 requirements-template.md 设计

**完整模板内容**：

```markdown
<!--
📋 文档编号说明
================
此模板用于创建需求文档，AI 会自动处理编号分配。

编号分配流程：
1. AI 扫描 docs/requirements/ 目录
2. 提取最大编号（如 008）
3. 自动分配下一个编号（如 009）
4. 创建文件：009-feature-name.md
5. 创建配对的技术设计文档：009-feature-name-technical-design.md

占位符说明：
- {{DOC_NUMBER}}：文档编号（如 "009"）
- {{FEATURE_NAME}}：功能名称 kebab-case（如 "document-numbering-system"）
- {{FEATURE_NAME_TITLE}}：功能标题（如 "文档编号系统"）
- {{DATE}}：当前日期（YYYY-MM-DD）
- {{AUTHOR}}：作者信息（从 git config 获取）

示例：
- 文件名：docs/requirements/20260203-document-numbering-system.md
- 标题：# REQ-20260203: 文档编号系统
- 配对文档：docs/design/20260203-document-numbering-system-technical-design.md
-->

---
type: "requirement"
document_number: "{{DOC_NUMBER}}"
version: "1.0.0"
lastUpdated: "{{DATE}}"
author: "{{AUTHOR}}"
status: "draft"
paired_design_doc: "docs/design/{{DOC_NUMBER}}-{{FEATURE_NAME}}-technical-design.md"
---

# REQ-{{DOC_NUMBER}}: {{FEATURE_NAME_TITLE}}

## 1. 需求概述

### 1.1 需求背景
<!-- 描述项目的背景和动机 -->

### 1.2 目标用户
<!-- 描述目标用户群体 -->

### 1.3 核心价值
<!-- 描述项目要解决的核心问题和价值 -->

## 2. 功能需求

### 2.1 核心功能
<!-- 列出主要功能需求 -->

### 2.2 辅助功能
<!-- 列出辅助功能需求 -->

## 3. 非功能需求

### 3.1 性能要求
<!-- 性能相关需求 -->

### 3.2 可用性要求
<!-- 可用性相关需求 -->

### 3.3 兼容性要求
<!-- 兼容性相关需求 -->

## 4. 约束条件

### 4.1 技术约束
<!-- 技术相关约束 -->

### 4.2 业务约束
<!-- 业务相关约束 -->

## 5. 验收标准

### 5.1 功能验收
<!-- 功能验收标准 -->

### 5.2 质量验收
<!-- 质量验收标准 -->

## 6. 用户故事
<!-- 可选：添加用户故事 -->

## 7. 相关文档

- `docs/design/{{DOC_NUMBER}}-{{FEATURE_NAME}}-technical-design.md` - 配对的技术设计文档

## 8. 变更历史

| 版本 | 日期 | 作者 | 变更说明 |
|------|------|------|----------|
| 1.0.0 | {{DATE}} | {{AUTHOR}} | 初始版本 |

---

*此文档将作为项目开发的指导性文档，所有实现都应基于此需求进行。*
```

**关键设计点**：
1. ✅ 文件名包含编号：`009-feature-name.md`
2. ✅ 标题包含编号：`# REQ-{{DOC_NUMBER}}: {{FEATURE_NAME_TITLE}}`
3. ✅ Frontmatter 包含 `document_number` 字段
4. ✅ 包含详细的编号说明注释
5. ✅ 明确配对关系

#### 3.3.2 technical-design-template.md 设计

**完整模板内容**：

```markdown
<!--
🔧 技术设计文档编号说明
========================
此模板用于创建技术设计文档，必须与需求文档使用相同编号。

编号配对规则：
- 需求文档文件名：NNN-feature-name.md
- 技术设计文件名：NNN-feature-name-technical-design.md
- 需求文档标题：# REQ-NNN: 功能名称
- 技术设计标题：# DESIGN-NNN: 功能名称 - 技术设计
- 编号 NNN 必须完全一致

AI 自动处理：
1. 与需求文档同时创建
2. 自动使用相同的 {{DOC_NUMBER}}
3. 确保文件名和标题中的编号一致

占位符说明：
- {{DOC_NUMBER}}：文档编号（与需求文档相同，如 "009"）
- {{FEATURE_NAME}}：功能名称 kebab-case（与需求文档相同）
- {{FEATURE_NAME_TITLE}}：功能标题（与需求文档相同）
- {{DATE}}：当前日期
- {{AUTHOR}}：作者信息

示例：
- 文件名：docs/design/20260203-document-numbering-system-technical-design.md
- 标题：# TECH-20260203: 文档编号系统 - 技术设计
- 配对文档：docs/requirements/20260203-document-numbering-system.md
-->

---
type: "design"
document_number: "{{DOC_NUMBER}}"
version: "1.0.0"
lastUpdated: "{{DATE}}"
author: "{{AUTHOR}}"
status: "draft"
paired_requirement_doc: "docs/requirements/{{DOC_NUMBER}}-{{FEATURE_NAME}}.md"
---

# DESIGN-{{DOC_NUMBER}}: {{FEATURE_NAME_TITLE}} - 技术设计

## 1. 技术架构概述

### 1.1 整体设计思路
<!-- 描述整体的技术设计思路和理念 -->

### 1.2 架构设计
<!-- 描述系统架构设计 -->

## 2. 技术栈选择

### 2.1 前端技术栈（如适用）
<!-- 前端技术选择和理由 -->

### 2.2 后端技术栈（如适用）
<!-- 后端技术选择和理由 -->

### 2.3 数据库设计（如适用）
<!-- 数据库技术选择和设计 -->

## 3. 详细设计

### 3.1 模块设计
<!-- 各个模块的详细设计 -->

### 3.2 接口设计（如适用）
<!-- API接口设计 -->

### 3.3 数据流设计
<!-- 数据流向和处理逻辑 -->

## 4. 关键技术实现

### 4.1 核心算法
<!-- 核心算法和实现思路 -->

### 4.2 性能优化
<!-- 性能优化策略 -->

### 4.3 安全考虑
<!-- 安全相关的技术实现 -->

## 5. 部署和运维

### 5.1 部署架构
<!-- 部署相关设计 -->

### 5.2 监控和日志
<!-- 监控和日志策略 -->

## 6. 风险评估

### 6.1 技术风险
<!-- 技术实现风险 -->

### 6.2 缓解措施
<!-- 风险缓解措施 -->

## 7. 测试策略
<!-- 测试方法和策略 -->

## 8. 实施计划
<!-- 实施步骤和优先级 -->

## 9. 相关文档

- `docs/requirements/{{DOC_NUMBER}}-{{FEATURE_NAME}}.md` - 配对的需求文档

## 10. 变更历史

| 版本 | 日期 | 作者 | 变更说明 |
|------|------|------|----------|
| 1.0.0 | {{DATE}} | {{AUTHOR}} | 初始版本 |

---

*此技术方案将指导具体的开发实现，确保技术选择的合理性和可行性。*
```

**关键设计点**：
1. ✅ 文件名包含编号：`009-feature-name-technical-design.md`
2. ✅ 标题包含编号：`# DESIGN-{{DOC_NUMBER}}: {{FEATURE_NAME_TITLE}} - 技术设计`
3. ✅ Frontmatter 包含 `document_number` 字段
4. ✅ 强调与需求文档的编号一致性
5. ✅ 包含配对文档链接

#### 3.3.3 占位符列表

| 占位符 | 说明 | 示例值 | 使用位置 |
|--------|------|--------|---------|
| `{{DOC_NUMBER}}` | 三位数编号 | `"009"` | 文件名、标题、frontmatter |
| `{{FEATURE_NAME}}` | 功能名称（kebab-case） | `"document-numbering-system"` | 文件名、链接 |
| `{{FEATURE_NAME_TITLE}}` | 功能标题（中文） | `"文档编号系统"` | 标题 |
| `{{DATE}}` | 当前日期 | `"2026-01-31"` | frontmatter |
| `{{AUTHOR}}` | 作者信息 | `"AI"` 或 git config user.name | frontmatter |

**编号在文档中的使用**：

1. **文件名**：`{{DOC_NUMBER}}-{{FEATURE_NAME}}.md` → `20260203-document-numbering-system.md`
2. **标题**：`# REQ-{{DOC_NUMBER}}: {{FEATURE_NAME_TITLE}}` → `# REQ-20260203: 文档编号系统`
3. **Frontmatter**：`document_number: "{{DOC_NUMBER}}"` → `document_number: "009"`

### 3.4 init-doc-driven-dev 命令更新

#### 3.4.1 命令文档更新

更新 `plugins/ai-doc-driven-dev/commands/init-doc-driven-dev.md`：

```markdown
## Output

The command creates the following structure with automatic document numbering:

```
project-root/
├── CLAUDE.md                    # Updated with doc-driven workflow and numbering rules
├── docs/
│   ├── requirements/
│   │   └── 001-project-initial-requirements.md      # Auto-numbered initial doc
│   │       Title: # REQ-20260110: 项目初始化需求
│   ├── design/
│   │   └── 001-project-initial-technical-design.md  # Paired with same number
│   │       Title: # DESIGN-001: 项目初始化需求 - 技术设计
│   ├── standards/
│   │   ├── coding-standards.md
│   │   └── project-conventions.md
│   └── analysis/
│       └── project-analysis.md
└── [existing project files]
```

**Document Numbering System**:
- **File names**: Initial documents start with `001-project-initial-requirements.md`
- **Document titles**: Include number prefix (e.g., `# REQ-20260110: 项目初始化需求`)
- **Auto-assignment**: AI automatically assigns next available number for new documents
- **Paired documents**: Requirements and technical design use matching numbers
  - File: `009-feature.md` ↔ `009-feature-technical-design.md`
  - Title: `# REQ-20260203: 功能` ↔ `# TECH-20260203: 功能 - 技术设计`
- **Embedded rules**: Numbering rules and automation workflow in generated CLAUDE.md
- **Template placeholders**: `{{DOC_NUMBER}}` for automatic number injection in both filename and title
```

#### 3.4.2 初始化逻辑

AI 在执行 `init-doc-driven-dev` 时的逻辑：

```
1. 创建 docs/ 目录结构：
   - docs/requirements/
   - docs/design/
   - docs/standards/
   - docs/analysis/

2. 生成 CLAUDE.md（包含完整的编号规范章节）

3. 创建初始文档（使用模板并替换占位符）：
   文件：docs/requirements/001-project-initial-requirements.md
   标题：# REQ-20260110: 项目初始化需求

   文件：docs/design/001-project-initial-technical-design.md
   标题：# DESIGN-001: 项目初始化需求 - 技术设计

4. 占位符替换：
   - {{DOC_NUMBER}} → "001"（文件名和标题都要替换）
   - {{FEATURE_NAME}} → "project-initial"
   - {{FEATURE_NAME_TITLE}} → "项目初始化需求"
   - {{DATE}} → 当前日期（如 "2026-01-31"）
   - {{AUTHOR}} → 从 git config user.name 获取，或默认 "AI"

5. 复制模板文件到 docs/standards/：
   - requirements-template.md（包含编号说明）
   - technical-design-template.md（包含编号说明）
```

### 3.5 Skills 集成

#### 3.5.1 doc-generator 技能更新

**技能描述更新**（添加编号分配指导）：

在 `SKILL.md` 的 "How It Works" 章节添加：

```markdown
## 编号分配流程

在生成新文档前，doc-generator 技能必须执行以下步骤：

### 步骤 1：扫描现有编号
```bash
ls docs/requirements/ | grep -E '^[0-9]{3}-' | sort -r | head -1
```

### 步骤 2：提取最大编号
```bash
# 假设扫描结果为 "008-xxx.md"
echo "008-xxx.md" | cut -d'-' -f1  # 输出: 008
```

### 步骤 3：计算下一个编号
```bash
next_num=$((10#008 + 1))
printf "%03d" $next_num  # 输出: 009
```

### 步骤 4：创建配对文档
- 需求文档文件名：`docs/requirements/009-feature-name.md`
- 需求文档标题：`# REQ-20260203: 功能名称`
- 技术设计文件名：`docs/design/009-feature-name-technical-design.md`
- 技术设计标题：`# TECH-20260203: 功能名称 - 技术设计`

### 步骤 5：替换模板占位符
读取模板文件并替换所有占位符：
- {{DOC_NUMBER}} → "009"（文件名和标题都要替换）
- {{FEATURE_NAME}} → "feature-name"
- {{FEATURE_NAME_TITLE}} → "功能名称"
- {{DATE}} → 当前日期
- {{AUTHOR}} → 作者信息

## 占位符替换规则

| 占位符 | 获取方式 | 替换位置 |
|--------|----------|---------|
| {{DOC_NUMBER}} | 从编号分配流程获取 | 文件名、标题、frontmatter |
| {{FEATURE_NAME}} | 从用户输入或文件名提取 | 文件名、链接 |
| {{FEATURE_NAME_TITLE}} | 从用户输入或自动生成 | 标题 |
| {{DATE}} | 当前日期（YYYY-MM-DD） | frontmatter |
| {{AUTHOR}} | git config user.name 或 "AI" | frontmatter |

## 编号一致性检查

创建文档后，验证：
1. ✅ 文件名中的编号与标题中的编号一致
2. ✅ frontmatter 中的 document_number 与文件名一致
3. ✅ 需求文档和技术设计文档使用相同编号
```

#### 3.5.2 doc-workflow-enforcer 技能更新

**SKILL.md 更新要点**：

在 "How It Works" 章节添加：

```markdown
## 编号规范生成

在生成或更新 CLAUDE.md 时，必须包含完整的"文档编号规范"章节，内容包括：

1. **编号格式说明**：
   - 文件名格式（NNN-feature-name.md）
   - 标题格式（# REQ-NNN: 功能名称）
   - 三位数编号规则

2. **编号配对规则**：
   - 需求文档和技术设计文档的配对关系
   - 文件名和标题的对应关系

3. **AI 自动化流程**：
   - 完整的编号扫描命令
   - 编号计算方法
   - 占位符替换说明

4. **编号规则清单**：
   - ✅ 允许的操作
   - ❌ 禁止的操作

此章节应位于"开发流程要求"之后，确保 AI 在创建任何文档前都能读取并遵循编号规范。
```

### 3.6 工具链与标准化设计（合并 REQ-20260203）

#### 3.6.1 模板与规范

- **Command 模板**：新增 `docs/standards/command-documentation-template.md`（中/英双语）
- **Skill 模板**：增强现有模板并补充中/英文版本
- **Frontmatter 规范**：集中管理必填字段、依赖、兼容性与版本
- **错误代码规范**：统一错误码、提示格式与多语言输出

#### 3.6.2 脚手架与校验

**脚手架脚本**：
- `scripts/scaffold-command.sh`
- `scripts/scaffold-skill.sh`
- 交互式输入必填字段，生成双语模板与示例

**校验脚本**：
- `scripts/validate-commands.sh`
- `scripts/validate-skills.sh`
- 校验 frontmatter、章节结构、命名规则、依赖引用

#### 3.6.3 测试与迁移

**测试框架**：
- `tests/commands/`, `tests/skills/`, `tests/lib/`
- 统一测试工具与 fixtures，支持覆盖率报告

**迁移工具**：
- `scripts/migrate-to-new-standard.sh`
- 自动补充缺失字段、对齐模板结构并生成迁移报告

#### 3.6.4 示例库与文档生成

- `examples/commands/`（minimal/standard/advanced）
- `examples/skills/`（minimal/standard/advanced）
- `scripts/generate-docs.sh` 生成索引、README 与依赖关系图

## 4. 关键技术实现

### 4.1 编号冲突检测

```bash
# 检测重复编号
duplicates=$(ls docs/requirements/ | grep -E '^[0-9]{3}-' | cut -d'-' -f1 | sort | uniq -d)
if [ -n "$duplicates" ]; then
  echo "⚠️  发现重复编号: $duplicates"
fi
```

### 4.2 编号序列完整性检查

```bash
# 检测跳号
numbers=$(ls docs/requirements/ | grep -E '^[0-9]{3}-' | cut -d'-' -f1 | sort -n)
expected=1
for num in $numbers; do
  if [ $((10#$num)) -ne $expected ]; then
    echo "⚠️  缺少编号: $(printf '%03d' $expected)"
  fi
  expected=$((10#$num + 1))
done
```

### 4.3 配对关系验证

```bash
# 验证每个需求文档都有对应的技术设计文档
for req in docs/requirements/[0-9][0-9][0-9]-*.md; do
  num=$(basename "$req" | cut -d'-' -f1)
  name=$(basename "$req" | sed "s/^$num-//" | sed 's/\.md$//')
  design="docs/design/${num}-${name}-technical-design.md"
  if [ ! -f "$design" ]; then
    echo "⚠️  缺少技术设计文档: $design"
  fi
done
```

### 4.4 标题编号一致性检查

```bash
# 检查文件名编号与标题编号是否一致
for doc in docs/requirements/[0-9][0-9][0-9]-*.md; do
  file_num=$(basename "$doc" | cut -d'-' -f1)
  title_num=$(grep -E '^# REQ-[0-9]{3}:' "$doc" | sed 's/# REQ-//' | cut -d':' -f1)
  if [ "$file_num" != "$title_num" ]; then
    echo "⚠️  编号不一致: 文件 $file_num vs 标题 $title_num in $doc"
  fi
done
```

### 4.5 AI 自动化实现关键点

**CLAUDE.md 中的 AI 指令**（完整版）：

```markdown
## AI 文档创建流程（自动执行）

当创建新的需求文档或技术设计文档时，AI 必须遵循以下步骤：

### 步骤 1：扫描现有编号
```bash
ls docs/requirements/ | grep -E '^[0-9]{3}-' | sort -r | head -1
```

### 步骤 2：计算下一个编号
```bash
# 假设步骤 1 输出为 "008-xxx.md"
last_num=$(echo "008-xxx.md" | cut -d'-' -f1)
next_num=$((10#$last_num + 1))
doc_number=$(printf "%03d" $next_num)
# doc_number = "009"
```

### 步骤 3：准备文档信息
- 编号：${doc_number}（如 "009"）
- 功能名称（kebab-case）：从用户输入获取（如 "document-numbering-system"）
- 功能标题：从用户输入获取（如 "文档编号系统"）

### 步骤 4：创建配对文档
**需求文档**：
- 文件名：`docs/requirements/${doc_number}-${feature_name}.md`
- 标题：`# REQ-${doc_number}: ${feature_title}`

**技术设计文档**：
- 文件名：`docs/design/${doc_number}-${feature_name}-technical-design.md`
- 标题：`# DESIGN-${doc_number}: ${feature_title} - 技术设计`

### 步骤 5：替换模板占位符
读取模板文件并替换：
- {{DOC_NUMBER}} → ${doc_number}（在文件名、标题、frontmatter 中）
- {{FEATURE_NAME}} → ${feature_name}
- {{FEATURE_NAME_TITLE}} → ${feature_title}
- {{DATE}} → 当前日期
- {{AUTHOR}}→ 作者信息

### 步骤 6：验证编号一致性
创建文档后检查：
1. 文件名中的编号 = 标题中的编号
2. frontmatter 中的 document_number = 文件名编号
3. 需求文档编号 = 技术设计文档编号

### 错误处理
- 如果 docs/requirements/ 不存在或为空，使用 "001" 作为初始编号
- 如果扫描失败，提示用户检查目录结构
- 如果编号不一致，立即修正
```

## 5. 部署和运维

### 5.1 部署架构

**无需部署**：
- 编号系统完全基于文件系统和 AI 自动化
- 无需服务器、数据库或后台进程
- 通过 CLAUDE.md 规范、模板文件和技能描述实现

### 5.2 维护和监控

**维护方式**：
- 定期检查编号序列完整性（可选）
- 验证配对关系（可选）
- 验证文件名和标题编号一致性（可选）
- 更新 CLAUDE.md 中的编号规范（如有变化）

**监控指标**：
- 编号冲突数量（应为 0）
- 缺失配对文档数量（应为 0）
- 编号序列跳号数量（应为 0）
- 文件名与标题编号不一致数量（应为 0）

## 6. 风险评估

### 6.1 技术风险

| 风险 | 影响 | 概率 | 缓解措施 |
|------|------|------|----------|
| AI 未正确执行编号扫描 | 中 | 低 | CLAUDE.md 中使用明确指令；模板中添加详细注释 |
| 编号冲突 | 低 | 极低 | 自动化分配机制；提供冲突检测命令 |
| 文件名与标题编号不一致 | 中 | 低 | AI 验证步骤；提供一致性检查命令 |
| 文件系统扫描失败 | 低 | 低 | 默认使用 001；提示用户检查目录 |
| 模板占位符未正确替换 | 中 | 低 | 模板中添加详细说明；AI 验证替换结果 |

### 6.2 缓解措施

1. **清晰的 AI 指令**：
   - CLAUDE.md 中使用明确的步骤说明
   - 包含完整的命令示例和输出示例
   - 强调"必须"执行的步骤
   - 明确文件名和标题都要包含编号

2. **模板注释**：
   - 在模板文件顶部添加详细的使用说明
   - 列出所有占位符及其使用位置
   - 提供完整的示例（文件名 + 标题）

3. **一致性验证**：
   - AI 创建文档后自动验证编号一致性
   - 提供手动检查命令

4. **冲突检测**：
   - 提供编号冲突检测命令
   - AI 在分配编号后验证唯一性

5. **文档化**：
   - 在插件 README 中说明编号系统
   - 提供故障排查指南

## 7. 测试策略

### 7.1 单元测试

```bash
# 测试编号提取
test_extract_number() {
  result=$(echo "008-test.md" | cut -d'-' -f1)
  [ "$result" = "008" ] && echo "✅ PASS" || echo "❌ FAIL"
}

# 测试编号计算
test_next_number() {
  result=$(printf "%03d" $((10#008 + 1)))
  [ "$result" = "009" ] && echo "✅ PASS" || echo "❌ FAIL"
}

# 测试文件名占位符替换
test_filename_placeholder() {
  template="{{DOC_NUMBER}}-{{FEATURE_NAME}}.md"
  result=$(echo "$template" | sed "s/{{DOC_NUMBER}}/009/g" | sed "s/{{FEATURE_NAME}}/test-feature/g")
  expected="009-test-feature.md"
  [ "$result" = "$expected" ] && echo "✅ PASS" || echo "❌ FAIL"
}

# 测试标题占位符替换
test_title_placeholder() {
  template="# REQ-{{DOC_NUMBER}}: {{FEATURE_NAME_TITLE}}"
  result=$(echo "$template" | sed "s/{{DOC_NUMBER}}/009/g" | sed "s/{{FEATURE_NAME_TITLE}}/测试功能/g")
  expected="# REQ-20260203: 测试功能"
  [ "$result" = "$expected" ] && echo "✅ PASS" || echo "❌ FAIL"
}
```

### 7.2 集成测试

测试完整流程：
1. 在空项目中执行 `init-doc-driven-dev`
2. 验证生成文件：`001-project-initial-requirements.md`
3. 验证文件标题：`# REQ-20260110: 项目初始化需求`
4. 验证 frontmatter：`document_number: "001"`
5. 请求 AI 创建新需求文档
6. 验证 AI 自动分配 `002` 编号
7. 验证文件名：`002-xxx.md`
8. 验证标题：`# REQ-20260110: xxx`
9. 验证配对的技术设计文档也使用 `002`
10. 验证所有占位符都已正确替换

### 7.3 一致性测试

测试编号一致性：
1. 创建文档后检查文件名编号
2. 读取文档检查标题编号
3. 验证两者一致
4. 检查 frontmatter 中的 document_number
5. 验证三者完全一致

## 8. 实施计划

### 8.1 实施步骤

**Phase 1: 模板文件更新** ⭐ 最高优先级
- [ ] 更新 `requirements-template.md`
  - 添加编号说明注释
  - 更新标题为 `# REQ-{{DOC_NUMBER}}: {{FEATURE_NAME_TITLE}}`
  - 添加所有占位符
- [ ] 更新 `technical-design-template.md`
  - 添加编号说明注释
  - 更新标题为 `# DESIGN-{{DOC_NUMBER}}: {{FEATURE_NAME_TITLE}} - 技术设计`
  - 添加所有占位符
- [ ] 测试占位符替换逻辑

**Phase 2: 工具链与规范基础**
- [ ] 创建/补充标准化模板（Command/Skill 中英双语）
- [ ] 编写 frontmatter 规范与错误代码规范
- [ ] 搭建脚手架与校验脚本骨架
- [ ] 准备测试目录与示例库结构

**Phase 3: CLAUDE.md 规范模板创建**
- [ ] 创建完整的编号规范章节内容
  - 包含文件名和标题格式说明
  - 包含完整的 AI 自动化流程
  - 包含验证步骤
- [ ] 在 `doc-workflow-enforcer` 技能中集成编号规范
- [ ] 测试 CLAUDE.md 生成

**Phase 4: init-doc-driven-dev 命令更新**
- [ ] 更新命令文档（`init-doc-driven-dev.md`）
  - 体现文件名和标题的编号格式
- [ ] 实现初始化逻辑
  - 创建 `001-project-initial-requirements.md`
  - 标题：`# REQ-20260110: 项目初始化需求`
- [ ] 实现占位符替换逻辑（文件名 + 标题）
- [ ] 测试初始化流程

**Phase 5: doc-generator 技能更新**
- [ ] 在 `SKILL.md` 中添加编号分配流程说明
  - 强调文件名和标题都要包含编号
  - 添加一致性验证步骤
- [ ] 更新技能描述，包含占位符替换指导
- [ ] 测试文档生成和编号分配

**Phase 6: 测试和验证**
- [ ] 在测试项目中验证完整流程
- [ ] 测试编号冲突检测
- [ ] 测试配对关系验证
- [ ] 测试文件名与标题编号一致性
- [ ] 修复发现的问题

**Phase 7: 文档更新**
- [ ] 更新插件 README（添加编号系统说明）
- [ ] 创建编号系统使用指南
- [ ] 添加故障排查指南

### 8.2 实施优先级

| 任务 | 优先级 | 理由 | 预计工作量 |
|------|--------|------|-----------|
| 模板文件更新 | 🔴 最高 | 核心基础，影响文件名和标题 | 1-2 小时 |
| 工具链与规范基础 | 🔴 最高 | 统一 Commands/Skills 质量基础 | 2-4 小时 |
| CLAUDE.md 规范创建 | 🔴 最高 | AI 依赖此规范执行编号分配 | 1-2 小时 |
| init-doc-driven-dev 更新 | 🟡 高 | 新项目初始化功能 | 2-3 小时 |
| doc-generator 更新 | 🟡 高 | 现有项目文档创建 | 1-2 小时 |
| 测试和验证 | 🟢 中 | 确保功能正确性 | 2-3 小时 |
| 文档更新 | 🟢 中 | 用户指导 | 1 小时 |

## 9. 文件变更清单

### 9.1 需要修改的文件

| 文件路径 | 变更类型 | 变更内容 |
|---------|---------|---------|
| `plugins/ai-doc-driven-dev/knowledge/templates/requirements-template.md` | 修改 | 标题改为 `# REQ-{{DOC_NUMBER}}: {{FEATURE_NAME_TITLE}}`；添加编号说明 |
| `plugins/ai-doc-driven-dev/knowledge/templates/technical-design-template.md` | 修改 | 标题改为 `# DESIGN-{{DOC_NUMBER}}: {{FEATURE_NAME_TITLE}} - 技术设计`；添加编号说明 |
| `plugins/ai-doc-driven-dev/commands/init-doc-driven-dev.md` | 修改 | 更新输出说明，体现文件名和标题的编号格式 |
| `plugins/ai-doc-driven-dev/skills/doc-workflow-enforcer/SKILL.md` | 修改 | 添加编号规范生成逻辑（包含文件名和标题格式） |
| `plugins/ai-doc-driven-dev/skills/doc-generator/SKILL.md` | 修改 | 添加编号分配流程和一致性验证说明 |
| `plugins/ai-doc-driven-dev/README.md` | 修改 | 添加编号系统说明 |

### 9.2 新增文件（工具链与标准化）

- `docs/standards/command-documentation-template.md`
- `docs/standards/command-documentation-template-zh.md`
- `docs/standards/skill-documentation-template-zh.md`
- `docs/standards/frontmatter-specification.md`
- `docs/standards/error-codes.md`
- `scripts/scaffold-command.sh`
- `scripts/scaffold-skill.sh`
- `scripts/validate-commands.sh`
- `scripts/validate-skills.sh`
- `scripts/migrate-to-new-standard.sh`
- `scripts/generate-docs.sh`
- `scripts/lib/validation-lib.sh`
- `scripts/lib/template-lib.sh`
- `scripts/lib/utils.sh`
- `tests/commands/`（含模板与 fixtures）
- `tests/skills/`（含模板与 fixtures）
- `tests/lib/`
- `examples/commands/`
- `examples/skills/`

## 10. 相关文档

- `docs/requirements/20260203-document-numbering-system.md` - 需求文档
- `plugins/ai-doc-driven-dev/commands/init-doc-driven-dev.md` - 初始化命令
- `plugins/ai-doc-driven-dev/skills/doc-workflow-enforcer/SKILL.md` - CLAUDE.md 强制技能
- `plugins/ai-doc-driven-dev/skills/doc-generator/SKILL.md` - 文档生成技能
- `plugins/ai-doc-driven-dev/knowledge/templates/requirements-template.md` - 需求文档模板
- `plugins/ai-doc-driven-dev/knowledge/templates/technical-design-template.md` - 技术设计模板

## 11. Commands 和 Skills 优化设计

### 11.1 核心设计思路

基于官方最佳实践（参考：`/Users/zhoukailian/Desktop/mySelf/claude-plugins-official/official-patterns-analysis.md`），Commands 和 Skills 优化遵循以下核心思路：

**设计原则**：
1. **简洁明确**：使用官方推荐的结构模式
2. **模板驱动**：提供标准模板，AI 按模板执行
3. **自动化**：通过 CLAUDE.md 规范指导 AI 自动遵循
4. **说做什么，不说怎么做**：用简短指令代替详细描述

**优化方式**：
- Commands：添加 Context、Phase 结构、停止点、条件逻辑
- Skills：优化 Description、添加 "When This Skill Applies"、Phase 结构、表格和评分系统

**简洁写作规范**：

| 原则 | 说明 | 示例 |
|------|------|------|
| **指令式** | 使用动词开头 | "Scan existing numbers" ✅ vs "The skill will scan..." ❌ |
| **简短** | 每步 ≤10 词 | "Create docs/ structure" ✅ vs "Create docs/ directory with requirements/, design/, standards/, and analysis/ subdirectories" ❌ |
| **突出重点** | 关键步骤粗体 | "**Verify numbering**" ✅ |
| **避免啰嗦** | 不详述实现 | "Populate templates" ✅ vs "Generate project-specific requirements documentation based on existing code analysis" ❌ |

**长度限制**：
- Commands：每个 Phase 的 Actions ≤5 个步骤
- Skills：每个 Phase 的 Actions ≤4 个步骤
- 每个步骤描述 ≤10 词（中文 ≤15 字）

### 11.2 官方模板参考

所有 Commands 和 Skills 的优化应参考以下官方模板：

**参考文档**：`claude-plugins-official/official-patterns-analysis.md`

**关键模板**：
- 模板 1: 简单的单步骤 Command（如 `/commit`）
- 模板 2: 多阶段工作流 Command（如 `/feature-dev`）
- 模板 3: Agent 协作 Command（如 `/code-review`）
- 模板 4: 基础 Skill
- 模板 5: 工作流式 Skill（如 `claude-md-improver`）

**关键模式**：
- Bash 内联执行：`!`command``
- Phase 分隔：`---`
- Goal-Actions 结构
- 停止点：`**WAIT**`、`**DO NOT**`
- 条件逻辑：`If-Then`
- 表格组织信息
- 评分系统（A-F）

### 11.3 简化示例

#### 11.3.1 Command 简化示例

**啰嗦版本** ❌：
```markdown
### Example 1: Complete Documentation Setup

User request: "Generate complete documentation structure for our React TypeScript project"

The skill will:
1. Create docs/ directory with requirements/, design/, standards/, and analysis/ subdirectories
2. Generate project-specific requirements documentation based on existing code analysis
3. Create technical design documents reflecting current architecture and patterns
4. Produce coding standards documentation based on extracted project conventions
5. Add appropriate frontmatter and metadata to all generated documents
```

**简洁版本** ✅：
```markdown
## Phase 2: Document Creation

**Goal**: Generate numbered documents

**Actions**:
1. **Scan existing document numbers**
2. **Calculate next number**
3. Create paired documents
4. Populate using templates

**Critical**: Ensure filename number matches title number.
```

#### 11.3.2 Skill 简化示例

**啰嗦版本** ❌：
```markdown
description: |
  Generate standardized project documentation based on templates and project analysis.
  Use when you need to "generate project docs", "create documentation", or "setup project documentation structure".
```

**简洁版本** ✅：
```markdown
description: This skill should be used when the user asks to "generate project docs",
"create documentation", or discusses "documentation setup".
```

### 11.4 具体优化清单

#### 11.4.1 Commands 优化（4 个）

| Command | 主要优化点 | 参考模板 |
|---------|-----------|---------|
| init-doc-driven-dev | Context、Phase、简洁步骤 | 模板 2（多阶段工作流） |
| enforce-doc-workflow | Goal-Actions、条件、停止点 | 模板 2（多阶段工作流） |
| analyze-docs | 工作流、评分、简洁描述 | 模板 3（Agent 协作） |
| extract-patterns | LSP、优先级、条件逻辑 | 模板 2（多阶段工作流） |

#### 11.4.2 Skills 优化（4 个）

| Skill | 主要优化点 | 参考模板 |
|-------|-----------|---------|
| doc-workflow-enforcer | Description、When、Phase | 模板 5（工作流式） |
| doc-detector | 表格、评分、简洁步骤 | 模板 5（工作流式） |
| doc-generator | 编号流程、占位符、验证 | 模板 5（工作流式） |
| pattern-extractor | LSP、优先级、条件 | 模板 5（工作流式） |

### 11.5 实施指导

**实施流程**：
1. 阅读官方最佳实践文档
2. 选择对应的模板
3. 按模板结构重写 Commands/Skills
4. 遵循简洁写作规范（≤10 词/步骤）
5. 在 CLAUDE.md 中添加规范说明
6. 测试验证

**CLAUDE.md 规范**：
- 包含完整的编号规范
- 包含 Commands/Skills 写作规范
- 明确告知 AI 必须遵循官方模板
- 强调简洁原则：说做什么，不说怎么做

**质量检查清单**：
- [ ] 每个步骤 ≤10 词（中文 ≤15 字）
- [ ] 使用指令式（动词开头）
- [ ] 关键步骤用粗体
- [ ] 避免"The skill will..."描述
- [ ] 避免详细的实现细节


## 12. 实施计划

### 12.1 Phase 划分

**Phase 1: 模板文件更新** ⭐ 最高优先级
- 更新 requirements-template.md 和 technical-design-template.md
- 添加编号占位符和说明

**Phase 2: 工具链与规范基础** 🔴 高优先级
- 补充 Command/Skill 模板（中英双语）
- 新增 frontmatter 规范与错误代码规范
- 建立脚手架/校验/迁移脚本骨架
- 初始化测试与示例目录

**Phase 3: Commands 优化** 🔴 高优先级
- 按官方模板重写 4 个 Commands
- 参考：`claude-plugins-official/official-patterns-analysis.md`

**Phase 4: Skills 优化** 🔴 高优先级
- 按官方模板重写 4 个 Skills
- 参考：`claude-plugins-official/official-patterns-analysis.md`

**Phase 5: CLAUDE.md 规范** 🟡 中优先级
- 在 doc-workflow-enforcer 中添加编号规范生成
- 添加 Commands/Skills 写作规范

**Phase 6: 测试验证** 🟢 中优先级
- 测试编号系统
- 测试 Commands/Skills 优化效果

**Phase 7: 文档更新** 🟢 低优先级
- 更新插件 README
- 添加使用指南

### 12.2 工作量估算

| Phase | 工作量 | 优先级 |
|-------|--------|--------|
| Phase 1 | 1-2 小时 | 🔴 最高 |
| Phase 2 | 2-4 小时 | 🔴 高 |
| Phase 3 | 4-6 小时 | 🔴 高 |
| Phase 4 | 4-6 小时 | 🔴 高 |
| Phase 5 | 1-2 小时 | 🟡 中 |
| Phase 6 | 3-4 小时 | 🟢 中 |
| Phase 7 | 1-2 小时 | 🟢 低 |
| **总计** | **16-26 小时** | - |

## 13. 文件变更清单

### 13.1 模板文件

- `plugins/ai-doc-driven-dev/knowledge/templates/requirements-template.md`
- `plugins/ai-doc-driven-dev/knowledge/templates/technical-design-template.md`

### 13.2 Commands（4 个）

- `plugins/ai-doc-driven-dev/commands/init-doc-driven-dev.md`
- `plugins/ai-doc-driven-dev/commands/enforce-doc-workflow.md`
- `plugins/ai-doc-driven-dev/commands/analyze-docs.md`
- `plugins/ai-doc-driven-dev/commands/extract-patterns.md`

### 13.3 Skills（4 个）

- `plugins/ai-doc-driven-dev/skills/doc-workflow-enforcer/SKILL.md`
- `plugins/ai-doc-driven-dev/skills/doc-detector/SKILL.md`
- `plugins/ai-doc-driven-dev/skills/doc-generator/SKILL.md`
- `plugins/ai-doc-driven-dev/skills/pattern-extractor/SKILL.md`

## 14. 相关文档

- `docs/requirements/20260203-document-numbering-system.md` - 需求文档
- `docs/analysis/skills-optimization-analysis.md` - Skills 优化分析
- `/Users/zhoukailian/Desktop/mySelf/claude-plugins-official/official-patterns-analysis.md` - 官方最佳实践

## 15. 变更历史

| 版本 | 日期 | 作者 | 变更说明 |
|------|------|------|----------|
| 1.0.0 | 2026-01-31 | AI | 初始版本 - 编号系统和 Commands/Skills 优化设计 |

---

*此技术方案将指导具体的开发实现，确保技术选择的合理性和可行性。*
