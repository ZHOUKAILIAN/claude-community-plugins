# 需求文档 008: Commands 和 Skills 优化

## 文档信息
- **编号**: REQ-008
- **标题**: Commands 和 Skills 优化
- **版本**: 1.0.0
- **创建日期**: 2026-01-29
- **状态**: 已合并（Merged into REQ-009）

> 说明：本需求已合并到 `REQ-009: 文档编号系统`，不再单独实施。
> 合并原因：REQ-009 已包含 Commands/Skills 优化的范围与验收标准，并统一了文档编号与模板规范。

## 1. 需求背景

### 1.1 问题现状

当前 claude-community-plugins 项目中的 commands 和 skills 存在以下问题:

**文档标准化问题**:
- commands 和 skills 的文档结构不统一,缺乏标准化模板
- frontmatter 字段定义不完整,缺少版本号、作者、依赖等关键信息
- 缺少双语支持(中英文),不利于国际化推广
- 示例和最佳实践不足,开发者难以快速上手

**开发流程问题**:
- 缺少 command 和 skill 的脚手架工具,手动创建效率低且容易出错
- 没有自动化验证工具,无法确保 frontmatter 格式和必填字段的正确性
- 缺少测试框架,无法验证 commands 和 skills 的功能正确性
- 开发者需要手动维护文档一致性,容易遗漏

**功能增强需求**:
- commands 缺少参数验证和错误处理机制
- skills 的 allowed-tools 定义不够灵活,难以适应复杂场景
- 缺少 command 和 skill 之间的依赖关系管理
- 没有版本兼容性检查机制

**用户体验问题**:
- 错误提示信息不够友好,难以定位问题
- 缺少进度反馈,用户不知道 command 执行到哪一步
- 没有交互式引导,新用户学习成本高
- 性能优化不足,部分 commands 执行时间较长

### 1.2 目标用户

- **插件开发者**: 需要创建和维护 commands 和 skills 的开发者
- **插件使用者**: 使用 claude-community-plugins 中各种 commands 和 skills 的用户
- **项目维护者**: 负责审核和维护插件质量的维护者

## 2. 功能需求

### 2.1 核心功能

**F1: 文档标准化**

**F1.1 Command 文档模板**
- 创建标准化的 command 文档模板,包含以下部分:
  - Frontmatter 字段定义(description, category, shortcut, model, version, author, dependencies, etc.)
  - 命令描述和用途说明
  - 使用方法和参数说明
  - 选项和标志说明
  - 使用示例(至少 3 个)
  - 输出格式说明
  - 前置条件和依赖
  - 相关命令链接
  - 常见问题和故障排除
- 提供中英文双语版本模板

**F1.2 Skill 文档模板增强**
- 基于现有 `docs/standards/skill-documentation-template.md`,增强以下内容:
  - Frontmatter 字段扩展(version, author, dependencies, compatibility, etc.)
  - 技术实现细节章节
  - 性能考量和优化建议
  - 错误处理和异常场景
  - 与其他 skills 的集成方式
  - 版本兼容性说明
- 提供中英文双语版本模板

**F1.3 Frontmatter 字段标准**
- 定义 command 和 skill 的完整 frontmatter 字段规范:
  ```yaml
  # Command Frontmatter
  ---
  name: command-name                    # 命令名称(必填)
  description: Brief description        # 简要描述(必填)
  category: git|setup|analysis|etc      # 分类(必填)
  shortcut: "sc"                        # 快捷键(可选)
  model: inherit|sonnet|opus|haiku      # 模型选择(可选,默认 inherit)
  version: 1.0.0                        # 版本号(必填)
  author:                               # 作者信息(必填)
    name: Author Name
    email: author@example.com
  dependencies:                         # 依赖项(可选)
    - skill:skill-name
    - command:other-command
  compatibility:                        # 兼容性(可选)
    min_claude_version: 1.0.0
  tags: [git, commit, automation]       # 标签(可选)
  ---

  # Skill Frontmatter
  ---
  name: skill-name                      # 技能名称(必填)
  description: |                        # 详细描述(必填)
    Multi-line description with examples
    <example>Example 1</example>
  allowed-tools: ["Read", "Write"]      # 允许的工具(必填)
  license: MIT                          # 许可证(必填)
  version: 1.0.0                        # 版本号(必填)
  author:                               # 作者信息(必填)
    name: Author Name
    email: author@example.com
  dependencies:                         # 依赖项(可选)
    - skill:other-skill
  compatibility:                        # 兼容性(可选)
    min_claude_version: 1.0.0
  tags: [documentation, automation]     # 标签(可选)
  ---
  ```

**F2: 开发工具链**

**F2.1 脚手架工具 (scaffold-command.sh / scaffold-skill.sh)**
- 交互式创建 command 或 skill 的基础结构
- 功能包括:
  - 提示输入必填字段(name, description, category/allowed-tools, etc.)
  - 自动生成符合标准的 frontmatter
  - 创建文档结构框架(包括所有必需章节)
  - 可选择生成双语版本(中英文)
  - 自动创建相关目录结构
  - 生成示例代码和测试文件
- 使用示例:
  ```bash
  # 创建新 command
  ./scripts/scaffold-command.sh --name my-command --category git

  # 创建新 skill
  ./scripts/scaffold-skill.sh --name my-skill --bilingual
  ```

**F2.2 验证工具 (validate-commands.sh / validate-skills.sh)**
- 自动验证 commands 和 skills 的规范性
- 验证内容包括:
  - Frontmatter 格式正确性(YAML 语法)
  - 必填字段完整性检查
  - 字段值格式验证(version 格式、email 格式等)
  - 文档结构完整性检查(必需章节是否存在)
  - 双语版本一致性检查(如果存在)
  - 依赖项有效性检查(引用的 skill/command 是否存在)
  - 文件命名规范检查
- 集成到 CI/CD 流程中
- 提供详细的错误报告和修复建议
- 使用示例:
  ```bash
  # 验证所有 commands
  ./scripts/validate-commands.sh

  # 验证特定插件的 skills
  ./scripts/validate-skills.sh --plugin ai-doc-driven-dev
  ```

**F2.3 测试框架**
- 为 commands 和 skills 提供测试框架
- 功能包括:
  - 单元测试支持(测试单个功能点)
  - 集成测试支持(测试 command/skill 完整流程)
  - Mock 工具支持(模拟文件系统、Git 操作等)
  - 测试覆盖率报告
  - 测试用例模板生成
- 测试框架目录结构:
  ```
  tests/
  ├── commands/
  │   ├── test-command-name.sh
  │   └── fixtures/
  ├── skills/
  │   ├── test-skill-name.sh
  │   └── fixtures/
  └── lib/
      ├── test-helpers.sh
      └── mock-tools.sh
  ```

**F3: 功能增强**

**F3.1 Command 参数验证**
- 在 command frontmatter 中定义参数规范:
  ```yaml
  parameters:
    - name: template
      type: string
      required: false
      default: standard
      allowed_values: [minimal, standard, advanced]
      description: Template type to use
    - name: force
      type: boolean
      required: false
      default: false
      description: Force overwrite existing files
  ```
- 自动生成参数验证逻辑
- 提供友好的参数错误提示

**F3.2 Skill 工具权限管理**
- 扩展 allowed-tools 定义,支持更细粒度的权限控制:
  ```yaml
  allowed-tools:
    - name: Read
      restrictions:
        - no_sensitive_files  # 不能读取敏感文件
    - name: Write
      restrictions:
        - only_docs_directory  # 只能写入 docs/ 目录
    - name: Bash
      restrictions:
        - no_destructive_commands  # 禁止破坏性命令
  ```

**F3.3 依赖关系管理**
- 在 frontmatter 中声明依赖关系
- 自动检查依赖项是否满足
- 提供依赖项安装引导
- 支持版本兼容性检查

**F4: 用户体验优化**

**F4.1 错误处理增强**
- 为 commands 和 skills 定义标准错误代码
- 提供多语言错误消息支持
- 错误消息包含:
  - 清晰的问题描述
  - 可能的原因分析
  - 具体的解决方案
  - 相关文档链接
- 错误日志记录和追踪

**F4.2 进度反馈机制**
- 为长时间运行的 commands 提供进度条
- 关键步骤完成时显示通知
- 支持详细模式(--verbose)显示详细执行日志
- 提供估计剩余时间

**F4.3 交互式引导**
- 为复杂 commands 提供交互式向导模式
- 使用 AskUserQuestion 收集必要信息
- 提供默认值和推荐选项
- 支持配置保存和复用

**F4.4 性能优化**
- 识别性能瓶颈(文件读取、Git 操作等)
- 实现缓存机制(避免重复操作)
- 并行化独立操作
- 提供性能分析工具

### 2.2 辅助功能

**F5: 文档生成工具**
- 自动从 frontmatter 生成 README 文档
- 生成 command/skill 索引页面
- 生成依赖关系图
- 支持导出为不同格式(Markdown, HTML, PDF)

**F6: 迁移工具**
- 提供工具将现有 commands 和 skills 迁移到新标准
- 自动添加缺失的 frontmatter 字段
- 生成迁移报告
- 保留现有功能和行为

**F7: 示例库**
- 为每种类型的 command 和 skill 提供完整示例
- 示例分类:
  - 简单示例(minimal example)
  - 标准示例(standard example)
  - 高级示例(advanced example with all features)
- 示例包含详细注释和说明

## 3. 技术需求

### 3.1 架构设计

**整体架构**:
```
claude-community-plugins/
├── docs/
│   └── standards/
│       ├── command-documentation-template.md      # Command 文档模板
│       ├── command-documentation-template-zh.md   # Command 文档模板(中文)
│       ├── skill-documentation-template.md        # Skill 文档模板(已存在,需增强)
│       ├── skill-documentation-template-zh.md     # Skill 文档模板(中文)
│       ├── frontmatter-specification.md           # Frontmatter 规范
│       └── error-codes.md                         # 错误代码规范
├── scripts/
│   ├── scaffold-command.sh                        # Command 脚手架
│   ├── scaffold-skill.sh                          # Skill 脚手架
│   ├── validate-commands.sh                       # Command 验证
│   ├── validate-skills.sh                         # Skill 验证
│   ├── migrate-to-new-standard.sh                 # 迁移工具
│   ├── generate-docs.sh                           # 文档生成
│   └── lib/
│       ├── validation-lib.sh                      # 验证库
│       ├── template-lib.sh                        # 模板库
│       └── utils.sh                               # 工具函数
├── tests/
│   ├── commands/                                  # Command 测试
│   ├── skills/                                    # Skill 测试
│   └── lib/                                       # 测试库
├── examples/
│   ├── commands/
│   │   ├── minimal-command.md
│   │   ├── standard-command.md
│   │   └── advanced-command.md
│   └── skills/
│       ├── minimal-skill/
│       ├── standard-skill/
│       └── advanced-skill/
└── plugins/
    └── [existing plugins with updated commands and skills]
```

### 3.2 技术实现大纲

**阶段 1: 标准化定义 (1-2 周)**
1. 完善 frontmatter 字段规范
2. 创建 command 和 skill 文档模板(中英文)
3. 定义错误代码规范
4. 编写最佳实践指南

**阶段 2: 工具开发 (2-3 周)**
1. 开发脚手架工具(scaffold-command.sh, scaffold-skill.sh)
2. 开发验证工具(validate-commands.sh, validate-skills.sh)
3. 开发测试框架基础设施
4. 开发迁移工具

**阶段 3: 功能增强 (2-3 周)**
1. 实现参数验证机制
2. 实现工具权限管理
3. 实现依赖关系管理
4. 实现错误处理增强

**阶段 4: 用户体验优化 (1-2 周)**
1. 实现进度反馈机制
2. 实现交互式引导
3. 性能分析和优化
4. 错误消息优化

**阶段 5: 现有插件迁移 (1-2 周)**
1. 使用迁移工具更新现有 commands 和 skills
2. 补充缺失的文档内容
3. 添加测试用例
4. 验证功能正确性

**阶段 6: 文档和示例 (1 周)**
1. 创建完整示例库
2. 生成文档索引
3. 编写使用指南
4. 录制演示视频(可选)

### 3.3 技术栈

- **脚本语言**: Bash (用于脚手架和验证工具)
- **配置格式**: YAML (frontmatter), JSON (plugin.json)
- **文档格式**: Markdown (符合 CommonMark 规范)
- **测试框架**: Bash 测试框架(如 bats-core)
- **CI/CD**: GitHub Actions (自动验证和测试)
- **版本控制**: Git

### 3.4 开发约定

**命名规范**:
- 脚本文件: kebab-case.sh (如 scaffold-command.sh)
- 函数名: snake_case (如 validate_frontmatter)
- 变量名: UPPER_SNAKE_CASE (全局), lower_snake_case (局部)

**代码规范**:
- 所有脚本必须包含 shebang (#!/usr/bin/env bash)
- 使用 set -euo pipefail 启用严格模式
- 函数必须包含注释说明用途和参数
- 错误处理必须使用统一的错误代码

**文档规范**:
- 所有模板必须提供中英文版本
- 文档结构必须遵循定义的模板
- 示例代码必须可以直接运行
- 链接必须使用相对路径

## 4. 风险评估

### 4.1 技术风险

**R1: 向后兼容性风险**
- 风险: 新标准可能与现有 commands 和 skills 不兼容
- 缓解措施:
  - 提供迁移工具自动更新现有内容
  - 保留向后兼容性,新字段设为可选
  - 充分测试迁移过程
  - 提供详细的迁移文档

**R2: 工具复杂性风险**
- 风险: 脚手架和验证工具可能过于复杂,难以维护
- 缓解措施:
  - 保持工具简单和模块化
  - 编写清晰的代码注释
  - 提供开发者文档
  - 建立测试覆盖

**R3: 性能风险**
- 风险: 验证和测试工具可能影响开发效率
- 缓解措施:
  - 优化验证算法
  - 提供增量验证选项
  - 使用缓存减少重复操作
  - 提供快速模式(跳过非关键验证)

### 4.2 其他风险

**R4: 采用风险**
- 风险: 开发者可能不愿意采用新标准和工具
- 缓解措施:
  - 提供清晰的价值说明
  - 降低学习成本(详细文档和示例)
  - 自动化迁移过程
  - 在社区中推广最佳实践

**R5: 维护风险**
- 风险: 新增的工具和标准需要持续维护
- 缓解措施:
  - 建立清晰的维护流程
  - 文档化所有工具的设计决策
  - 鼓励社区贡献
  - 定期审查和更新标准

## 5. 验收标准

**文档标准化**:
- ✅ 创建完整的 command 和 skill 文档模板(中英文)
- ✅ 定义完整的 frontmatter 字段规范
- ✅ 所有模板包含示例和最佳实践

**开发工具链**:
- ✅ 脚手架工具可以交互式创建 command 和 skill
- ✅ 验证工具可以检测所有规范违规情况
- ✅ 测试框架可以运行测试并生成报告
- ✅ 所有工具集成到 CI/CD 流程

**功能增强**:
- ✅ Commands 支持参数验证
- ✅ Skills 支持细粒度工具权限管理
- ✅ 依赖关系管理正常工作
- ✅ 错误处理提供友好的错误消息

**现有插件迁移**:
- ✅ 所有现有 commands 和 skills 迁移到新标准
- ✅ 功能保持不变,无破坏性变更
- ✅ 所有插件通过验证测试

**文档和示例**:
- ✅ 提供至少 3 个不同复杂度的示例
- ✅ 生成完整的文档索引
- ✅ 编写详细的使用指南

## 6. 后续计划

**短期 (1-2 个月)**:
- 完成核心工具开发和现有插件迁移
- 建立 CI/CD 自动化流程
- 完善文档和示例

**中期 (3-6 个月)**:
- 收集社区反馈并迭代改进
- 开发更多高级功能(如性能分析工具)
- 扩展示例库

**长期 (6-12 个月)**:
- 建立插件质量评分系统
- 开发可视化工具(依赖关系图、性能仪表板等)
- 探索 AI 辅助的 command 和 skill 生成

## 7. 合并记录

- **合并目标**：`docs/requirements/009-document-numbering-system.md`
- **合并日期**：2026-02-02
- **处理方式**：保留本文件作为历史记录，统一需求与设计在 REQ-009 / DESIGN-009 中维护。
