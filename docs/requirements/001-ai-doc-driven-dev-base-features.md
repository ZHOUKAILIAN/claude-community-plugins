# 需求文档 001: AI Documentation-Driven Development Plugin - 需求与技术规范

## 文档信息
- **编号**: REQ-001
- **标题**: AI文档驱动开发插件基础功能
- **版本**: 1.0.0
- **创建日期**: 2026-01-10
- **状态**: 已实现

## 1. 需求背景

### 1.1 问题现状

当前 AI 辅助开发存在以下核心问题：

**缺乏上下文追溯**

- AI 生成的代码难以关联到原始需求和设计决策
- 代码变更与设计决策脱节，维护困难

**代码质量不可控**

- 直接生成的代码可能不符合项目规范和架构约束
- 缺少必要的上下文约束和规范指导

**文档体系缺失**

- 大部分项目缺乏标准化文档体系
- 需求文档、技术方案、仓库分析、编码规范不完整或缺失

### 1.2 目标用户

- 使用 AI 进行代码开发的研发团队
- 希望建立规范化开发流程的项目负责人
- 需要快速了解项目上下文的新团队成员

## 2. 功能需求

### 2.1 核心功能

**F1: 文档体系检测与初始化**

- 自动检测项目中缺失的标准化文档
- 一键初始化完整的文档体系结构
- 支持多种项目类型的文档模板

**F2: 智能文档生成**

- 基于代码分析自动生成仓库结构文档
- 提取现有代码中的架构模式和编码规范
- 生成项目技术栈和依赖关系文档

**F2.1: 项目规范自动提炼**

- 分析现有代码风格和命名约定
- 提取API设计模式和请求规范
- 识别数据类型定义和接口规范
- 总结项目特有的架构模式和最佳实践

**F2.2: CLAUDE.md文档驱动开发模式强制集成**

- 检测项目中是否存在CLAUDE.md文件
- 如果存在，自动在其中插入/更新文档驱动开发流程规范
- 如果不存在，创建包含完整文档驱动开发指南的CLAUDE.md
- 强制要求Claude Code CLI用户在代码变更前先更新docs
- 提供标准化的"先文档后代码"工作流程模板

**F3: 上下文感知的代码生成约束**

- 为 AI 提供项目特定的约束条件
- 集成编码规范到代码生成过程
- 确保生成代码符合项目架构要求

**F4: 文档驱动的上下文管理**

- 建立标准化的docs目录结构
- AI自动读取docs中的历史背景和设计决策
- 确保所有代码变更都基于文档中的上下文

### 2.2 辅助功能

**F5: 文档同步与维护**

- 检测代码变更对文档的影响
- 提醒更新相关文档
- 支持文档版本管理

**F6: AI友好的开发支持**

- 生成AI上下文友好的项目概览
- 优化代码结构描述以便AI理解
- 支持vibe coding模式的快速上下文切换
- 提供AI代码生成的最佳实践指南

## 3. 技术需求

### 3.1 架构设计

**插件架构**

```
ai-context-docs/
├── .claude-plugin/
│   └── plugin.json              # 插件元数据
├── skills/
│   ├── doc-detector/            # 文档检测技能
│   ├── doc-generator/           # 文档生成技能
│   ├── pattern-extractor/       # 项目规范提炼技能
│   └── context-analyzer/        # 上下文分析技能
├── knowledge/
│   ├── templates/               # 文档模板库
│   ├── patterns/               # 架构模式识别
│   └── standards/              # 编码规范库
└── README.md
```

**标准化文档体系结构**

```
项目根目录/
├── docs/
│   ├── requirements/           # 需求文档
│   │   ├── functional-requirements.md
│   │   ├── non-functional-requirements.md
│   │   └── user-stories.md
│   ├── design/                # 技术设计
│   │   ├── architecture.md
│   │   ├── api-design.md
│   │   └── database-design.md
│   ├── analysis/              # 仓库分析
│   │   ├── codebase-structure.md
│   │   ├── dependency-analysis.md
│   │   └── tech-stack.md
│   ├── standards/             # 编码规范
│   │   ├── coding-standards.md
│   │   ├── naming-conventions.md
│   │   └── review-guidelines.md
│   └── ai-context/            # AI开发上下文
│       ├── project-overview.md
│       ├── coding-patterns.md
│       └── development-guidelines.md
└── README.md
```

### 3.2 技术实现大纲

**核心技能设计**

**技能 1: doc-detector**
- 功能：检测项目文档完整性
- 输入：项目根目录
- 输出：缺失文档清单和建议
- 工具权限：["Read", "Glob", "Grep"]

**技能 2: doc-generator**
- 功能：生成标准化文档
- 输入：项目代码和配置
- 输出：完整文档体系
- 工具权限：["Read", "Write", "Glob", "Grep", "Bash"]

**技能 3: pattern-extractor**
- 功能：自动提炼项目特有的代码规范和模式
- 输入：项目代码库
- 输出：项目规范文档和代码模式总结
- 工具权限：["Read", "Glob", "Grep", "LSP"]

**技能 4: claude-md-enforcer**
- 功能：强制集成文档驱动开发流程到CLAUDE.md
- 输入：项目根目录和现有CLAUDE.md（如果存在）
- 输出：包含文档驱动开发规范的CLAUDE.md文件
- 工具权限：["Read", "Write", "Edit"]

**技能 5: context-analyzer**
- 功能：分析项目上下文并生成AI友好的文档
- 输入：项目代码和现有文档
- 输出：AI开发上下文文档
- 工具权限：["Read", "Write", "Glob", "Grep", "LSP"]

### 3.3 分项目类型的详细规范

#### 3.3.1 前端项目规范

**检测规则**
- 检测 `package.json` 中的前端框架（React/Vue/Angular）
- 识别构建工具（Webpack/Vite/Rollup）
- 分析组件结构和状态管理

**项目规范提炼**
- **类型规范**：分析TypeScript接口定义、Props类型、State类型的命名和结构模式
- **组件规范**：提取组件文件结构、命名约定、导入导出模式
- **请求规范**：分析API调用方式、错误处理模式、数据转换规范
- **样式规范**：识别CSS-in-JS、CSS Modules、或传统CSS的使用模式
- **状态管理**：分析Redux/Zustand/Context使用模式和数据流设计

**生成文档**
- `docs/design/component-architecture.md` - 组件架构设计
- `docs/design/state-management.md` - 状态管理方案
- `docs/standards/frontend-conventions.md` - 前端开发约定（从代码中提炼）
- `docs/standards/type-definitions.md` - 类型定义规范
- `docs/ai-context/frontend-patterns.md` - 前端开发模式

**AI上下文优化**
- 组件命名和结构约定
- 状态管理最佳实践
- UI/UX一致性指南
- 性能优化模式

#### 3.3.2 后端项目规范

**检测规则**
- 检测后端框架（Express/Spring/Django/Go Gin）
- 识别数据库类型和ORM
- 分析API设计模式

**项目规范提炼**
- **API规范**：分析路由定义、参数验证、响应格式的统一模式
- **数据模型规范**：提取实体定义、字段命名、关系映射的约定
- **错误处理规范**：识别异常处理、错误码定义、日志记录的模式
- **认证授权规范**：分析JWT、Session、权限控制的实现方式
- **数据库规范**：提取表命名、字段类型、索引设计的约定
- **服务层规范**：分析业务逻辑组织、依赖注入、事务管理模式

**生成文档**
- `docs/design/api-architecture.md` - API架构设计
- `docs/design/database-schema.md` - 数据库设计
- `docs/standards/backend-conventions.md` - 后端开发约定（从代码中提炼）
- `docs/standards/api-specifications.md` - API规范定义
- `docs/standards/data-model-conventions.md` - 数据模型约定
- `docs/ai-context/backend-patterns.md` - 后端开发模式

**AI上下文优化**
- RESTful API设计原则
- 数据模型和关系约定
- 错误处理和日志规范
- 安全和认证模式

### 3.4 简化数据模型

**文档元数据结构**（在每个markdown文件的frontmatter中）

```yaml
---
type: "requirement|design|analysis|standard|ai-context"
version: "1.0.0"
lastUpdated: "2026-01-10"
author: "string"
status: "draft|active|deprecated"
relatedFiles: ["string"]
---
```

**项目上下文配置**（docs/ai-context/项目配置）

```markdown
# 项目概览

## 技术栈
- 语言: TypeScript/Python/Java
- 框架: React/Express/Spring
- 数据库: PostgreSQL/MongoDB

## 开发约定（从代码中自动提炼）
- 命名规范: camelCase for variables, PascalCase for components
- 文件结构: feature-based organization
- 代码风格: ESLint + Prettier

## 项目特有规范
### 前端规范
- 组件Props: 使用interface定义，以Props结尾命名
- API调用: 统一使用axios，错误处理采用try-catch
- 状态管理: 使用Zustand，store按功能模块划分
- 样式: 使用styled-components，主题变量统一管理

### 后端规范
- API响应: 统一使用{code, data, message}格式
- 错误处理: 自定义BusinessException，统一错误码
- 数据库: 实体类使用@Entity注解，字段采用snake_case
- 服务层: Service类使用@Transactional注解，方法命名动词开头

## 架构模式
- 前端: Component-based architecture
- 后端: RESTful API with service layer
- 数据访问: Repository pattern
```

**CLAUDE.md文档驱动开发模板**（自动插入到项目CLAUDE.md中）

```markdown
# 文档驱动开发规范

**IMPORTANT**: 此项目采用文档驱动开发模式。所有代码变更必须遵循以下流程：

## 开发工作流程

### 1. 强制性文档优先原则
- ❌ **禁止直接修改代码**
- ✅ **必须先更新docs目录中的相关文档**
- ✅ **所有AI代码生成都基于docs中的上下文**

### 2. 开发步骤（严格按顺序执行）
1. **需求分析**: 更新 `docs/requirements/` 中的需求文档
2. **技术设计**: 更新 `docs/design/` 中的技术方案
3. **规范检查**: 确认 `docs/standards/` 中的编码规范
4. **AI上下文**: 参考 `docs/ai-context/` 中的项目模式
5. **代码实现**: 基于文档进行代码变更

### 3. AI使用规范
- Claude Code CLI 会自动读取docs目录获取上下文
- 确保文档内容准确反映当前项目状态
- 代码生成时会遵循docs中定义的规范和模式

### 4. 文档结构
```
docs/
├── requirements/     # 需求文档
├── design/          # 技术设计
├── analysis/        # 项目分析
├── standards/       # 编码规范
└── ai-context/      # AI开发上下文
```

**违反此流程的代码变更将被拒绝！**
```

## 4. 非功能需求

### 4.1 性能要求

- 文档检测：< 5 秒（中等规模项目）
- 文档生成：< 30 秒（完整文档体系）
- 上下文分析：< 10 秒
- 内存占用：< 100MB

### 4.2 兼容性要求

- 支持主流编程语言：TypeScript, Python, Java, Go
- 支持版本控制：Git
- 支持项目类型：Web 应用、API 服务、库项目
- 支持开发环境：VS Code, Claude Code

### 4.3 可用性要求

- 零配置启动：插件安装后即可使用
- 渐进式采用：可选择性启用功能模块
- 轻量级集成：不影响现有开发流程

## 5. 实现计划

### 5.1 开发阶段

**阶段 1：核心框架**

- 插件基础结构搭建
- 文档模板库建立
- 基础检测功能实现

**阶段 2：智能分析**

- 代码结构分析
- 架构模式识别
- 约束条件提取

**阶段 3：集成优化**

- AI 代码生成集成
- 追溯关系管理
- 用户体验优化

### 5.2 验收标准

**功能验收**

- [ ] 能够检测并初始化完整文档体系
- [ ] 能够基于代码分析生成准确的项目文档
- [ ] 能够为 AI 提供有效的代码生成约束
- [ ] 能够建立和维护需求追溯关系

**质量验收**

- [ ] 文档生成准确率 > 90%
- [ ] 约束条件有效性 > 85%
- [ ] 用户满意度 > 4.0/5.0

## 6. 风险评估

### 6.1 技术风险

- **代码分析复杂性**：不同项目架构差异较大

  - 缓解措施：建立可扩展的模式识别框架

- **文档质量一致性**：自动生成文档质量难以保证
  - 缓解措施：建立人工审查和反馈机制

### 6.2 用户接受度风险

- **学习成本**：用户可能不愿意改变现有习惯
  - 缓解措施：提供渐进式采用路径和详细指南

## 7. 成功指标

### 7.1 定量指标

- 插件安装和使用率
- 文档完整性提升比例
- AI 代码生成质量改善程度
- 新成员上手时间缩短比例

### 7.2 定性指标

- 用户反馈和满意度
- 团队协作效率改善
- 代码质量和维护性提升
- 项目文档标准化程度

---

_此文档将作为插件开发的指导性文档，所有实现都应基于此规范进行。_
