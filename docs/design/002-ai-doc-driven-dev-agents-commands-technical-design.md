# 技术方案 002: AI 文档驱动开发插件 - 核心 Agents 技术设计

## 文档信息

- **编号**: TECH-002
- **标题**: 核心 Agents 技术方案
- **版本**: 2.0.0
- **创建日期**: 2026-01-10
- **更新日期**: 2026-01-10
- **状态**: 已完成
- **依赖**: TECH-001 (基础插件架构), REQ-002 (功能需求)

## 1. 需求背景

### 1.1 核心问题

许多代码仓库缺乏系统化的 AI 文档驱动开发流程，导致：

- 缺少 CLAUDE.md 等 AI 协作文件
- 没有标准的 docs 文档结构，或现有 docs 结构与标准不符
- AI 无法了解项目的代码风格和通用模式
- 后续 AI 开发时缺乏一致性指导

### 1.2 解决方案

设计两个核心 Agent 解决上述问题：

1. **doc-flow-initializer** - 智能建立 AI 文档驱动开发基础设施，处理现有 docs 结构冲突
2. **codebase-style-analyzer** - 分析并提取仓库的代码风格和通用模式

## 2. 技术架构

### 2.1 插件结构设计

```text
ai-doc-driven-dev/
├── .claude-plugin/
│   └── plugin.json                # 添加两个核心agents配置
├── skills/                        # 现有：4个核心技能
│   ├── claude-md-enforcer/
│   ├── doc-detector/
│   ├── pattern-extractor/
│   └── doc-generator/
├── agents/                        # 新增：两个核心AI代理
│   ├── doc-flow-initializer.md   # 文档流程初始化Agent
│   └── codebase-style-analyzer.md # 代码风格分析Agent
├── knowledge/                     # 现有：知识库
└── README.md                      # 现有：双语文档
```

### 2.2 工作流程设计

```text
仓库初始化流程:
1. 用户调用 doc-flow-initializer agent
2. Agent分析项目类型和现有结构
3. 首先执行 /init 流程创建基础CLAUDE.md
4. 在基础CLAUDE.md上增强文档驱动开发流程内容
5. 检测现有docs目录情况：
   - 无docs → 直接创建标准结构
   - 有docs但结构不同 → 分析差异，征求用户意见
   - 有docs且部分匹配 → 补充缺失目录
6. 根据用户选择处理docs结构
7. 生成项目特定的文档模板

代码风格分析流程:
1. 用户调用 codebase-style-analyzer agent
2. Agent扫描代码库识别模式
3. 提取命名约定、架构模式、代码风格
4. 生成风格指南文档
5. 更新CLAUDE.md中的开发规范
```

## 3. 核心 Agents 设计

### 3.1 Agent 设计原则

- **实用导向**: 专注解决实际开发中的痛点问题
- **自动化**: 减少手动配置，智能识别项目特征
- **标准化**: 建立一致的文档和代码风格标准
- **可扩展**: 支持不同类型项目的个性化需求

### 3.2 Agent 通用架构

```yaml
---
name: agent-name
description: |
  简洁的功能描述
system_prompt: |
  详细的系统提示，包括：
  - 专业领域定义和核心职责
  - 分析方法和工作流程
  - 输出格式和质量标准
  - 与用户交互的方式
allowed-tools: ["Read", "Write", "Edit", "Glob", "Grep", "LSP"]
license: MIT
---
```

### 3.3 Agent 1: doc-flow-initializer (文档流程初始化 Agent)

#### 3.3.1 核心职责

为缺乏 AI 文档驱动开发流程的仓库建立完整的基础设施，包括：

- **CLAUDE.md 创建/更新**: 建立 AI 协作的核心文件
- **docs 目录结构**: 创建标准的文档组织结构
- **项目类型识别**: 自动识别前端/后端/全栈等项目类型
- **模板应用**: 根据项目特点应用相应的文档模板

#### 3.3.2 技术实现

**工具使用策略**:

```text
Glob → 项目结构分析，识别技术栈特征
Read → 读取package.json、README等关键文件
Write → 创建CLAUDE.md和docs结构
Edit → 更新现有文档文件
Grep → 搜索项目中的关键配置信息
```

**核心工作流程**:

```text
1. 项目分析阶段:
   - 扫描根目录文件 (package.json, requirements.txt, pom.xml等)
   - 识别技术栈类型 (React, Vue, Node.js, Python等)
   - 分析现有文档结构

2. CLAUDE.md基础建立:
   - 首先调用现有的 /init 流程
   - 确保基础CLAUDE.md文件存在
   - 在基础内容上增强文档驱动开发流程

3. 文档驱动流程增强:
   - 添加AI协作规范和开发工作流
   - 集成文档优先开发原则
   - 建立代码变更前文档更新的要求

4. docs目录智能处理:
   - 检测现有docs结构
   - 如有冲突，分析差异并征求用户意见
   - 根据用户选择创建/整理标准目录结构
   - 生成项目特定的文档模板

5. 初始化验证:
   - 检查创建的文件和目录
   - 验证文档结构的完整性
   - 提供后续使用指导
```

#### 3.3.3 输出标准

**CLAUDE.md 增强内容结构**:

```markdown
# Project Overview (基于/init 生成的基础内容)

# Development Workflow (增强：文档驱动开发流程)

## Documentation-First Development Process

## Code Change Requirements

# AI Collaboration Guidelines (增强：AI 协作规范)

## AI Development Context

## Documentation Standards for AI

# Documentation Standards (新增：文档标准)

## docs/ Directory Structure

## Documentation Templates

# Code Style Requirements (将由 codebase-style-analyzer 填充)
```

**docs 目录结构**:

```text
docs/
├── requirements/     # 需求文档
├── design/          # 设计文档
├── standards/       # 开发标准
└── analysis/        # 分析报告
```

### 3.4 Agent 2: codebase-style-analyzer (代码风格分析 Agent)

#### 3.4.1 核心职责

**技术特性**:

- **专业领域**: 开发标准设计和维护
- **核心算法**: 模式识别和标准提取算法
- **分析维度**: 命名约定、架构模式、代码风格、最佳实践
- **输出格式**: 标准化的规范文档模板

**工具使用策略**:

```text
Read → 代码文件内容分析
Glob → 项目文件结构探索
Grep → 模式匹配和约定提取
LSP → 语义分析和定义跳转
```

**核心算法流程**:

```text
1. 项目探索 (Glob) → 分析项目结构和文件组织
2. 代码分析 (Read + LSP) → 提取命名约定和架构模式
3. 模式识别 (Grep) → 识别重复的代码模式和约定
4. 标准归纳 → 将发现的模式归纳为标准规则
5. 最佳实践集成 → 结合行业标准优化项目规范
6. 文档生成 → 创建可执行的标准文档
```

## 3. Commands 技术设计

### 3.1 Command 架构模式

#### 3.1.1 设计原则

- **用户友好**: 简洁的命令语法和清晰的参数设计
- **功能聚合**: 每个 Command 封装完整的业务流程
- **错误处理**: 完善的错误处理和用户反馈机制
- **进度反馈**: 实时的操作进度和状态信息

#### 3.1.2 Command 通用架构

````yaml
---
name: command-name
description: 简洁的命令描述
category: setup|analysis|generation
shortcut: "xx"
---

# Command Name

## Description
详细的功能描述

## Usage
```bash
claude command-name [options]
````

## Options

参数说明

## Examples

使用示例

## Output

输出格式说明

## Related Commands

相关命令链接

````

### 3.2 具体Command设计

#### 3.2.1 init-doc-driven-dev

**技术实现**:

```text
执行流程:
1. 项目类型检测 → 分析package.json、技术栈特征
2. 目录结构创建 → 创建标准docs/目录结构
3. CLAUDE.md更新 → 集成文档驱动工作流
4. 模板应用 → 根据项目类型应用相应模板
5. 初始文档生成 → 创建基础文档文件
````

**参数设计**:

```bash
claude init-doc-driven-dev [options]
  --force           # 强制覆盖现有文件
  --template <type> # 指定模板类型 (frontend/backend/fullstack)
  --minimal         # 创建最小化文档结构
  --analyze-only    # 仅分析项目不创建文件
```

#### 3.2.2 analyze-docs

**技术实现**:

```text
执行流程:
1. 调用documentation-analyst Agent
2. 生成详细分析报告
3. 格式化输出结果
4. 可选保存到文件
```

**参数设计**:

```bash
claude analyze-docs [options]
  --detailed        # 生成详细分析报告
  --format <type>   # 输出格式 (markdown/json/html)
  --save <file>     # 保存报告到文件
  --focus <area>    # 聚焦特定分析领域
```

#### 3.2.3 extract-patterns

**技术实现**:

```text
执行流程:
1. 调用standards-architect Agent
2. 执行模式提取分析
3. 生成标准文档
4. 更新项目规范
```

**参数设计**:

```bash
claude extract-patterns [options]
  --type <project>     # 项目类型 (frontend/backend/fullstack)
  --output <file>      # 保存结果到文件
  --format <format>    # 输出格式 (markdown/json/yaml)
  --include <patterns> # 包含的模式类型
  --exclude <patterns> # 排除的模式类型
```

## 4. 集成设计

### 4.1 Plugin Manifest 更新

#### 4.1.1 contributes 扩展

```json
{
  "name": "ai-doc-driven-dev",
  "version": "1.0.0"
}
```

### 4.2 组件间协作设计

#### 4.2.1 调用关系

```text
Commands → Agents → Skills → Tools

具体流程:
1. 用户执行Command
2. Command调用相应的Agent
3. Agent使用Skills完成具体任务
4. Skills调用底层Tools进行操作
```

#### 4.2.2 数据流设计

```text
Input (用户参数)
  ↓
Command (参数验证和预处理)
  ↓
Agent (专业分析和处理)
  ↓
Skills (具体操作执行)
  ↓
Tools (底层工具调用)
  ↓
Output (格式化结果返回)
```

## 5. 性能和安全设计

### 5.1 性能优化

#### 5.1.1 Agent 性能优化

- **缓存策略**: 对重复分析的项目文件进行缓存
- **增量分析**: 仅分析变更的文件和内容
- **并行处理**: 对独立的分析任务进行并行执行
- **资源限制**: 设置合理的内存和时间限制

#### 5.1.2 Command 性能优化

- **参数验证**: 早期参数验证避免无效操作
- **进度反馈**: 实时进度显示提升用户体验
- **错误恢复**: 支持中断恢复和部分重试
- **批量操作**: 支持批量文件处理优化

### 5.2 安全设计

#### 5.2.1 工具权限控制

```yaml
documentation-analyst:
  allowed-tools: ["Read", "Glob", "Grep", "LSP"]
  restrictions:
    - 只读操作，不修改文件
    - 限制访问敏感目录
    - 禁止执行外部命令

standards-architect:
  allowed-tools: ["Read", "Glob", "Grep", "LSP"]
  restrictions:
    - 只读分析，不直接修改代码
    - 限制网络访问
    - 禁止系统级操作
```

#### 5.2.2 输入验证

- **路径验证**: 确保文件路径在项目范围内
- **参数校验**: 严格验证命令行参数
- **内容过滤**: 过滤潜在的恶意内容
- **权限检查**: 验证用户操作权限

## 6. 测试策略

### 6.1 单元测试

#### 6.1.1 Agent 测试

```text
测试维度:
- 系统提示响应准确性
- 工具使用正确性
- 输出格式标准性
- 错误处理完整性
```

#### 6.1.2 Command 测试

```text
测试维度:
- 参数解析正确性
- 业务流程完整性
- 错误处理健壮性
- 输出格式一致性
```

### 6.2 集成测试

#### 6.2.1 端到端测试

```text
测试场景:
- 新项目初始化完整流程
- 现有项目文档分析流程
- 模式提取和标准生成流程
- 多组件协作正确性
```

### 6.3 兼容性测试

#### 6.3.1 项目类型兼容性

```text
测试项目:
- Frontend: React, Vue, Angular
- Backend: Node.js, Python, Java
- Fullstack: Next.js, Nuxt.js
- 多语言混合项目
```

## 7. 部署和维护

### 7.1 部署策略

#### 7.1.1 版本管理

```text
版本号规则: major.minor.patch
- major: 不兼容的API变更
- minor: 向后兼容的功能增加
- patch: 向后兼容的问题修正
```

#### 7.1.2 更新机制

```text
更新流程:
1. 检查版本兼容性
2. 备份现有配置
3. 更新插件文件
4. 验证功能正确性
5. 回滚机制支持
```

### 7.2 监控和维护

#### 7.2.1 使用监控

```text
监控指标:
- 命令执行成功率
- Agent分析准确率
- 用户满意度反馈
- 性能指标统计
```

#### 7.2.2 维护策略

```text
维护内容:
- 定期更新最佳实践
- 优化Agent系统提示
- 扩展支持的项目类型
- 修复已知问题
```

---

**文档状态**: ✅ 已完成实现
**最后更新**: 2026-01-10
**实现版本**: ai-doc-driven-dev v1.0.0
