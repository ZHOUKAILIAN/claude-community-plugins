# 需求文档 006: enforce-doc-workflow 命令扫描优化

## 文档信息
- **编号**: REQ-006
- **标题**: enforce-doc-workflow 命令扫描优化
- **版本**: 1.0.0
- **创建日期**: 2026-01-17
- **状态**: 草案

## 1. 需求背景

### 1.1 问题现状

当前 `enforce-doc-workflow` 命令在每次执行时都会自动扫描整个仓库,存在以下问题:

1. **强制扫描**: 每次启动都自动扫描,即使文档没有变化
2. **缺乏控制**: 用户无法选择是否需要扫描
3. **用户体验**: 频繁执行时,每次都扫描让用户感觉不合理

### 1.2 目标用户

- 频繁使用 `enforce-doc-workflow` 命令的开发者
- 需要快速进入文档驱动开发模式的用户
- 希望有更多控制权的用户

## 2. 功能需求

### 2.1 核心功能

**F1: 询问用户是否扫描**
- 命令执行时,先**询问用户**是否需要扫描仓库
- 用户可以选择:
  - **是**: 执行完整扫描
  - **否**: 跳过扫描,直接进入文档驱动模式
- 默认行为: 询问用户

**F2: 清晰的提示信息**
- 说明扫描的目的(检查文档完整性)
- 说明扫描的范围(`docs/requirements/`, `docs/standards/`, `CLAUDE.md`)
- 让用户明白选择"否"的影响

### 2.2 辅助功能

- 提供 `--scan` 参数允许命令行直接指定
  - `--scan=yes`: 跳过询问,直接扫描
  - `--scan=no`: 跳过询问,不扫描
  - 不提供参数: 询问用户(默认)

## 3. 技术需求

### 3.1 架构设计

```
用户执行命令
    ↓
检查 --scan 参数
    ↓
    ├─ 有参数 → 按参数执行
    └─ 无参数 → 询问用户
         ↓
    用户选择 Yes/No
         ↓
    ├─ Yes → 执行扫描 → 进入文档驱动模式
    └─ No  → 直接进入文档驱动模式
```

### 3.2 技术实现大纲

**修改文件**:
1. `plugins/ai-doc-driven-dev/commands/enforce-doc-workflow.md`
   - 在行为描述中添加"询问用户是否扫描"的说明
   - 添加 `--scan` 参数示例

2. `plugins/ai-doc-driven-dev/skills/doc-detector/SKILL.md`
   - 在"How It Works"中说明可以被跳过
   - 说明跳过扫描时的行为

3. `plugins/ai-doc-driven-dev/skills/claude-md-enforcer/SKILL.md`
   - 说明可以在不扫描的情况下工作

**实现逻辑** (伪代码):
```python
def enforce_doc_workflow(scan_param=None):
    if scan_param == 'yes':
        should_scan = True
    elif scan_param == 'no':
        should_scan = False
    else:
        # 询问用户
        should_scan = ask_user_to_scan()

    if should_scan:
        scan_results = perform_repository_scan()
        enter_enforcement_mode(scan_results)
    else:
        enter_enforcement_mode(no_scan=True)
```

### 3.3 用户交互示例

**场景 1: 无参数,询问用户**
```bash
$ claude enforce-doc-workflow

📋 Documentation Scan

   The scan will check:
   • docs/requirements/ - Requirement documents
   • docs/standards/ - Project standards
   • CLAUDE.md - Workflow enforcement

❓ Do you want to scan the repository?
   [Y] Yes - Scan now (recommended if docs changed)
   [N] No - Skip scan (faster, if docs unchanged)

Your choice [Y/n]:
```

**场景 2: 使用参数跳过询问**
```bash
# 直接扫描
$ claude enforce-doc-workflow --scan=yes
🔍 Scanning repository...
✅ Entering enforcement mode...

# 跳过扫描
$ claude enforce-doc-workflow --scan=no
⚡ Skipping scan
✅ Entering enforcement mode...
```

## 技术栈

- **命令定义**: Markdown with YAML frontmatter
- **Skill 定义**: Markdown with YAML frontmatter
- **工具**: Read, Write, Glob, Grep

## 开发约定（从代码中自动提炼）

- 所有文件使用 kebab-case 命名
- 命令文件放在 `commands/` 目录
- Skill 文件放在 `skills/*/SKILL.md`
- 使用 frontmatter 定义元数据

## 项目特有规范

- 遵循 Claude Code Plugin 标准结构
- 命令和 skill 分离设计
- 工具权限显式声明

## 架构模式

- **交互式命令**: 在执行前询问用户确认
- **参数化控制**: 支持命令行参数覆盖默认行为

## 开发工作流程

### 1. 强制性文档优先原则

- ❌ **禁止**: 未经文档审批直接修改 `plugins/` 内容
- ✅ **要求**: 用户 → AI 编写文档 → 用户审批 → AI 实现

### 2. 开发步骤（严格按顺序执行）

1. **需求文档编写**: 创建本文档并等待用户审批
2. **技术方案编写**: 创建详细技术设计文档并等待用户审批
3. **实现阶段**: 按技术方案修改相关文件
4. **测试验证**: 测试询问流程和参数功能

### 3. AI使用规范

- AI 必须参考已审批的文档进行实现
- 实现过程中如发现文档不完善,应先更新文档

### 4. 文档结构

```
docs/requirements/
├── 006-enforce-doc-workflow-scan-optimization.md (本文档)
└── 006-enforce-doc-workflow-scan-optimization-technical-design.md (待创建)
```

## 4. 风险评估

### 4.1 技术风险

**风险 1: 用户跳过扫描后缺少必要信息**
- **描述**: 用户选择不扫描,但文档驱动模式可能需要扫描结果
- **影响**: 中等 - 可能导致功能不完整
- **缓解**:
  - 在提示中说明跳过扫描的影响
  - 如果后续需要扫描结果,再次询问用户
  - 建议用户在文档变更后选择扫描

**风险 2: 用户不理解询问的含义**
- **描述**: 用户可能不清楚"扫描"是什么意思
- **影响**: 低 - 影响用户体验
- **缓解**:
  - 在提示中清晰解释扫描的内容和目的
  - 提供推荐选项(括号说明)
  - 更新文档添加FAQ

### 4.2 其他风险

**风险 3: 向后兼容性**
- **描述**: 新增询问步骤改变了原有行为
- **影响**: 低 - 改善了用户体验
- **缓解**:
  - 提供 `--scan=yes` 保持自动扫描行为
  - 在更新日志中说明变更
  - 更新相关文档
