# AI-Doc-Driven-Dev Plugin Skills 优化分析

**分析日期**：2026-01-31
**分析范围**：4 个核心 skills
**目的**：识别优化机会、功能gaps和改进建议

---

## 1. Skills 概览

| Skill | 主要功能 | Allowed Tools | 状态 |
|-------|---------|--------------|------|
| claude-md-enforcer | 强制执行文档驱动开发工作流 | Read, Write, Edit, Glob | ✅ 功能完整 |
| doc-detector | 检测和分析项目文档完整性 | Read, Glob, Grep | ✅ 功能完整 |
| doc-generator | 生成标准化项目文档 | Read, Write, Glob, Grep, Bash | ⚠️ 需要增强 |
| pattern-extractor | 提取代码模式和规范 | Read, Glob, Grep, LSP | ⚠️ 需要增强 |

---

## 2. 逐个 Skill 分析

### 2.1 claude-md-enforcer

**当前功能**：
- ✅ 检测和更新 CLAUDE.md
- ✅ 注入文档驱动开发工作流
- ✅ 强制执行"docs-first, code-second"流程
- ✅ 添加明确的禁止语句

**优化建议**：

#### 2.1.1 添加编号规范生成 🔴 高优先级
**问题**：当前未包含文档编号系统的规范生成
**建议**：
- 在生成 CLAUDE.md 时自动包含完整的编号规范章节
- 包含文件名和标题格式说明
- 包含 AI 自动化流程说明

**实施方式**：
```markdown
## 文档编号规范

### 编号格式
- 文件名：NNN-feature-name.md
- 标题：# REQ-NNN: 功能名称
...（完整规范）
```

#### 2.1.2 模板路径引用 🟡 中优先级
**问题**：未明确指出模板文件的位置
**建议**：
- 在 CLAUDE.md 中添加模板文件路径说明
- 指导 AI 从哪里读取模板

**示例**：
```markdown
## 文档模板

项目使用以下模板创建文档：
- 需求文档：docs/standards/requirements-template.md
- 技术设计：docs/standards/technical-design-template.md
```

#### 2.1.3 版本控制集成 🟢 低优先级
**建议**：添加 git commit 规范说明
```markdown
## 文档提交规范

文档变更的 commit 格式：
- docs(req): add REQ-009 document numbering system
- docs(design): add DESIGN-009 technical design
```

---

### 2.2 doc-detector

**当前功能**：
- ✅ 扫描 docs/ 目录结构
- ✅ 识别现有文档
- ✅ 检测缺失文档
- ✅ 非侵入式分析（只读）

**优化建议**：

#### 2.2.1 编号完整性检查 🔴 高优先级
**问题**：未检测文档编号的完整性和一致性
**建议**：添加以下检查功能
- 编号冲突检测（重复编号）
- 编号序列完整性（跳号检测）
- 配对关系验证（需求 ↔ 技术设计）
- 文件名与标题编号一致性

**实施方式**：
```markdown
## 编号完整性检查

在扫描文档时，额外执行：

1. **冲突检测**：
   ```bash
   ls docs/requirements/ | grep -E '^[0-9]{3}-' | cut -d'-' -f1 | sort | uniq -d
   ```

2. **跳号检测**：
   检查编号序列是否连续（001, 002, 003...）

3. **配对验证**：
   验证每个需求文档都有对应的技术设计文档

4. **一致性检查**：
   验证文件名编号与标题编号是否一致
```

#### 2.2.2 文档质量评分 🟡 中优先级
**建议**：添加文档质量评估功能
- 检查必填章节是否完整
- 检查 frontmatter 完整性
- 检查相关文档链接有效性

**示例输出**：
```
文档质量报告：
✅ REQ-009: 100% (所有章节完整)
⚠️  REQ-008: 80% (缺少"用户故事"章节)
❌ REQ-007: 50% (缺少多个必填章节)
```

#### 2.2.3 文档覆盖率统计 🟢 低优先级
**建议**：生成文档覆盖率报告
- 需求文档数量 vs 技术设计文档数量
- 已配对文档比例
- 文档状态分布（draft/review/approved）

---

### 2.3 doc-generator

**当前功能**：
- ✅ 选择合适的文档模板
- ✅ 基于项目分析填充模板
- ✅ 创建标准化文档结构
- ✅ 添加 frontmatter 和元数据

**优化建议**：

#### 2.3.1 编号自动分配 🔴 最高优先级
**问题**：当前未实现自动编号分配逻辑
**建议**：在 SKILL.md 中添加完整的编号分配流程

**实施方式**（在 "How It Works" 章节添加）：
```markdown
## 编号分配流程

### 步骤 1：扫描现有编号
```bash
ls docs/requirements/ | grep -E '^[0-9]{3}-' | sort -r | head -1
```

### 步骤 2：计算下一个编号
```bash
last_num=$(echo "008-xxx.md" | cut -d'-' -f1)
next_num=$((10#$last_num + 1))
doc_number=$(printf "%03d" $next_num)
```

### 步骤 3：创建配对文档
- 文件名：${doc_number}-feature-name.md
- 标题：# REQ-${doc_number}: 功能名称
```

#### 2.3.2 占位符替换引擎 🔴 高优先级
**问题**：未明确说明占位符替换逻辑
**建议**：详细说明所有占位符及其获取方式

**占位符表格**：
| 占位符 | 获取方式 | 使用位置 |
|--------|----------|---------|
| {{DOC_NUMBER}} | 编号分配流程 | 文件名、标题、frontmatter |
| {{FEATURE_NAME}} | 用户输入或提取 | 文件名、链接 |
| {{FEATURE_NAME_TITLE}} | 用户输入或生成 | 标题 |
| {{DATE}} | 系统日期 | frontmatter |
| {{AUTHOR}} | git config | frontmatter |

#### 2.3.3 交互式文档生成 🟡 中优先级
**建议**：使用 AskUserQuestion 收集文档信息
```markdown
## 交互式生成流程

1. 询问功能名称（kebab-case）
2. 询问功能标题（中文）
3. 询问文档类型（需求/技术设计/两者都要）
4. 自动分配编号
5. 生成文档
```

#### 2.3.4 验证和反馈 🟡 中优先级
**建议**：生成文档后自动验证
- 检查占位符是否全部替换
- 检查编号一致性
- 检查配对文档是否同时创建
- 提供创建成功的反馈信息

---

### 2.4 pattern-extractor

**当前功能**：
- ✅ 扫描代码库识别模式
- ✅ 提取命名规范
- ✅ 识别框架和架构模式
- ✅ 生成项目规范文档

**优化建议**：

#### 2.4.1 LSP 工具使用说明 🔴 高优先级
**问题**：Allowed tools 包含 LSP，但未说明如何使用
**建议**：在 SKILL.md 中添加 LSP 使用示例

**示例**：
```markdown
## LSP 工具使用

pattern-extractor 可以使用 LSP 工具进行深度代码分析：

### TypeScript/JavaScript 项目
- 类型定义提取
- 接口模式识别
- 导入/导出模式分析

### Python 项目
- 类和函数签名提取
- 类型注解分析
- 装饰器模式识别

### 使用方式
1. 通过 LSP 获取符号信息
2. 分析符号使用频率
3. 识别常见模式
4. 生成规范文档
```

#### 2.4.2 模式优先级排序 🟡 中优先级
**问题**：未说明如何处理多种模式共存的情况
**建议**：添加模式频率分析和优先级排序

**实施方式**：
```markdown
## 模式优先级分析

当发现多种模式时：

1. **频率统计**：统计每种模式的使用次数
2. **优先级排序**：优先推荐使用频率最高的模式
3. **一致性建议**：建议统一使用主流模式

示例输出：
- 命名规范：camelCase (85%) vs snake_case (15%) → 推荐 camelCase
- 导入方式：named imports (90%) vs default imports (10%) → 推荐 named imports
```

#### 2.4.3 增量更新支持 🟢 低优先级
**建议**：支持更新现有的规范文档
- 检测代码库变化
- 更新模式文档
- 保留历史版本

---

## 3. 跨 Skill 优化建议

### 3.1 Skill 协作流程 🔴 高优先级

**问题**：4 个 skills 之间缺少明确的协作流程说明

**建议**：在插件 README 或独立文档中说明 skills 的使用顺序

**推荐工作流**：
```
1. pattern-extractor
   ↓ 提取项目现有模式
2. doc-detector
   ↓ 检测文档完整性和编号问题
3. doc-generator
   ↓ 生成缺失的文档（自动编号）
4. claude-md-enforcer
   ↓ 更新 CLAUDE.md，强制执行规范
```

### 3.2 统一的错误处理 🟡 中优先级

**建议**：在所有 skills 中使用一致的错误处理和反馈格式

**示例**：
```
✅ 成功：文档已创建 - docs/requirements/009-xxx.md
⚠️  警告：发现编号跳号 - 缺少 005
❌ 错误：docs/requirements/ 目录不存在
💡 提示：建议先执行 init-doc-driven-dev
```

### 3.3 配置文件支持 🟢 低优先级

**建议**：添加可选的配置文件支持

**示例** (`.doc-driven-dev.json`):
```json
{
  "documentNumbering": {
    "enabled": true,
    "startNumber": 1,
    "format": "NNN"
  },
  "templates": {
    "requirements": "docs/standards/requirements-template.md",
    "design": "docs/standards/technical-design-template.md"
  },
  "validation": {
    "checkNumberingConsistency": true,
    "checkPairing": true,
    "checkQuality": false
  }
}
```

---

## 4. 新 Skill 建议

### 4.1 doc-validator Skill 🟡 中优先级

**目的**：专门用于文档验证和质量检查

**功能**：
- 编号完整性验证
- 配对关系验证
- 文档质量评分
- Markdown 格式检查
- 链接有效性检查

**Allowed Tools**：`Read, Glob, Grep, Bash`

**触发时机**：
- 文档创建后自动验证
- 用户手动触发验证
- Git pre-commit hook 集成

### 4.2 doc-indexer Skill 🟢 低优先级

**目的**：生成文档索引和导航

**功能**：
- 自动生成文档目录
- 创建编号索引
- 生成配对关系图
- 创建文档状态仪表板

**输出示例**：
```markdown
# 文档索引

## 需求文档 (9)
- [REQ-001: 项目初始化需求](docs/requirements/001-xxx.md) ✅
- [REQ-002: 功能A](docs/requirements/002-xxx.md) ✅
...
- [REQ-009: 文档编号系统](docs/requirements/009-xxx.md) ✅

## 配对状态
- ✅ 已配对: 8/9 (89%)
- ⚠️  缺失: REQ-005 缺少技术设计文档
```

---

## 5. 实施优先级总结

### 🔴 最高优先级（立即实施）

1. **doc-generator**：添加编号自动分配逻辑
2. **doc-generator**：添加占位符替换说明
3. **claude-md-enforcer**：添加编号规范生成
4. **doc-detector**：添加编号完整性检查
5. **跨 Skill**：明确 skills 协作流程

### 🟡 高优先级（近期实施）

6. **pattern-extractor**：添加 LSP 使用说明
7. **doc-generator**：添加验证和反馈机制
8. **claude-md-enforcer**：添加模板路径引用
9. **doc-detector**：添加文档质量评分
10. **跨 Skill**：统一错误处理格式

### 🟢 中低优先级（可选）

11. **pattern-extractor**：添加模式优先级排序
12. **doc-generator**：添加交互式生成
13. **新 Skill**：创建 doc-validator
14. **跨 Skill**：添加配置文件支持
15. **新 Skill**：创建 doc-indexer

---

## 6. 与 REQ-009 的关联

本次分析与 **REQ-009: 文档编号系统** 高度相关：

| 需求 | 相关 Skills | 优化建议 |
|------|------------|----------|
| 自动编号分配 | doc-generator | 添加编号分配流程（最高优先级） |
| 编号规范文档化 | claude-md-enforcer | 生成编号规范章节（最高优先级） |
| 编号冲突检测 | doc-detector | 添加完整性检查（高优先级） |
| 配对关系验证 | doc-detector | 添加配对验证（高优先级） |

**建议**：在实施 REQ-009 时，同步完成上述 skills 的优化。

---

## 7. 总结

### 优势
- ✅ 4 个 skills 功能定位清晰，职责明确
- ✅ 工具权限设计合理
- ✅ 文档结构完整

### 主要 Gaps
- ❌ 缺少编号系统的自动化支持
- ❌ 缺少文档验证和质量检查
- ❌ 缺少 skills 之间的协作流程说明

### 改进方向
1. **自动化增强**：完善编号分配和验证
2. **质量保证**：添加文档质量检查
3. **用户体验**：添加交互式生成和清晰的反馈
4. **协作流程**：明确 skills 使用顺序

---

**下一步行动**：
1. 实施 REQ-009 文档编号系统
2. 同步更新相关 skills（doc-generator, claude-md-enforcer, doc-detector）
3. 测试完整的文档创建流程
4. 根据测试结果迭代优化

---

*本分析文档为内部参考，用于指导 ai-doc-driven-dev 插件的持续优化。*
