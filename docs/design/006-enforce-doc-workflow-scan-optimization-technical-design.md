# 技术方案 006: enforce-doc-workflow 命令扫描优化 - 技术设计

## 文档信息

- **编号**: TECH-006
- **标题**: enforce-doc-workflow 命令扫描优化
- **版本**: 1.0.0
- **创建日期**: 2026-01-17
- **状态**: 待实现
- **依赖**: REQ-006 (enforce-doc-workflow 命令扫描优化需求)

## 1. 技术架构概述

### 1.1 整体设计思路

在命令执行时增加用户交互环节,询问是否需要扫描仓库,而不是强制执行扫描。这是一个**轻量级改进**,不引入缓存机制,只增加用户选择权。

核心理念:
- **用户主导**: 让用户决定是否需要扫描
- **简单直接**: 不引入复杂的缓存和状态管理
- **向后兼容**: 通过参数支持自动化场景

### 1.2 架构设计

修改现有命令和 skill 的行为描述,不改变目录结构:

```
plugins/ai-doc-driven-dev/
├── commands/
│   └── enforce-doc-workflow.md          [修改] 添加行为说明和参数示例
├── skills/
│   ├── doc-detector/
│   │   └── SKILL.md                     [修改] 说明可选扫描
│   └── claude-md-enforcer/
│       └── SKILL.md                     [修改] 说明可选扫描
└── README.md                            [可选] 更新使用说明
```

## 2. 核心修改详细设计

### 2.1 enforce-doc-workflow.md 命令定义修改

**功能职责**:
- 在命令执行前询问用户是否扫描
- 支持 `--scan` 参数跳过询问
- 根据用户选择决定是否调用扫描相关的 skills

**修改内容**:

在 `## Behavior` 章节添加扫描询问说明:

```markdown
## Behavior

### Scan Confirmation

Before entering enforcement mode, the command will ask if you want to scan the repository:

- **Scan Purpose**: Check documentation completeness and project status
- **Scan Scope**:
  - `docs/requirements/` - Requirement documents
  - `docs/standards/` - Project standards and templates
  - `CLAUDE.md` - Workflow enforcement configuration

**User Options**:
- **Yes**: Perform full repository scan (recommended if docs changed)
- **No**: Skip scan and enter enforcement mode directly (faster if docs unchanged)

**Command Line Parameter**:
- `--scan=yes`: Skip prompt and scan automatically
- `--scan=no`: Skip prompt and don't scan
- No parameter: Ask user (default)

### Enforcement Workflow

After scan decision:
- Enter enforcement mode and intercept code change requests
- Detect intent (feature/bugfix/refactor) and required documents
- If scan was performed: Use scan results to check for missing docs
- If scan was skipped: Check for docs on-demand when needed
- Guide the user to create missing documents using templates
```

在 `## Examples` 章节添加新示例:

```markdown
## Examples

### Example 1: Interactive Mode (Default)

```bash
# Command prompts for scan decision
claude enforce-doc-workflow

# Output:
# 📋 Documentation Scan
#
#    The scan will check:
#    • docs/requirements/ - Requirement documents
#    • docs/standards/ - Project standards
#    • CLAUDE.md - Workflow enforcement
#
# ❓ Do you want to scan the repository?
#    [Y] Yes - Scan now (recommended if docs changed)
#    [N] No - Skip scan (faster, if docs unchanged)
#
# Your choice [Y/n]:
```

### Example 2: Auto-scan Mode

```bash
# Skip prompt and scan automatically
claude enforce-doc-workflow --scan=yes
```

### Example 3: Skip Scan Mode

```bash
# Skip prompt and don't scan
claude enforce-doc-workflow --scan=no
```
```

### 2.2 doc-detector Skill 修改

**功能职责**:
- 说明该 skill 的扫描是可选的
- 说明跳过扫描时的行为

**修改内容**:

在 `## How It Works` 章节开头添加说明:

```markdown
## How It Works

**Note**: This skill's scanning can be skipped based on user choice. When the `enforce-doc-workflow` command is invoked, users are asked whether to perform a scan. If skipped, this skill is not invoked, and the workflow proceeds without scan results.

When scanning is performed:

1. **Directory Scanning**: Systematically scans docs/ directory structure for existing documentation
2. **Core Document Detection**: Identifies presence of essential documents (requirements, technical designs)
3. **Project Type Analysis**: Determines project type (frontend/backend/fullstack) to tailor recommendations
4. **Gap Analysis**: Compares current documentation against documentation-driven development standards
5. **User Consultation**: Asks users about missing documentation rather than auto-generating
```

### 2.3 claude-md-enforcer Skill 修改

**功能职责**:
- 说明该 skill 的扫描是可选的
- 说明可以在不完整扫描的情况下工作

**修改内容**:

在 `## How It Works` 章节开头添加说明:

```markdown
## How It Works

**Note**: This skill can work with or without a full repository scan. When users skip the scan in `enforce-doc-workflow` command, this skill focuses only on CLAUDE.md enforcement without comprehensive project analysis.

Workflow steps:

1. **CLAUDE.md Detection**: Scans the project root for existing CLAUDE.md files
2. **Content Analysis**: Analyzes current content to identify missing documentation workflow sections
3. **Template Injection**: Inserts or updates documentation-driven development standards
4. **Standards Synchronization**: (Optional, if full scan was performed) Ensures CLAUDE.md reflects current project standards from docs/standards/
5. **Workflow Enforcement**: Establishes mandatory "docs-first, code-second" development process
6. **Prohibition Insertion**: Adds explicit prohibitions against direct code implementation
7. **Approval Gate Setup**: Creates mandatory documentation review and approval gates
```

## 3. 用户交互设计

### 3.1 提示文本设计

**提示内容** (在命令执行时显示):

```
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

**设计要点**:
- 使用 emoji 增加可读性
- 清晰列出扫描范围
- 说明每个选项的适用场景
- 提供默认选项提示 `[Y/n]` (Y 大写表示默认)

### 3.2 用户响应处理

**接受的输入**:
- `Y`, `y`, `yes`, `Yes` → 执行扫描
- `N`, `n`, `no`, `No` → 跳过扫描
- 空输入(直接回车) → 使用默认值(Y,执行扫描)
- 其他输入 → 提示无效,重新询问

**响应后的输出**:

选择 Yes:
```
🔍 Scanning repository for documentation...
   ✓ Scanned docs/requirements/ (5 files)
   ✓ Scanned docs/standards/ (3 files)
   ✓ Analyzed CLAUDE.md

✅ Scan complete. Entering enforcement mode...
```

选择 No:
```
⚡ Skipping repository scan

✅ Entering enforcement mode...
```

## 4. 参数处理逻辑

### 4.1 命令行参数解析

**参数格式**: `--scan=<value>`

**支持的值**:
- `yes`, `y`, `true`, `1` → 自动扫描,不询问
- `no`, `n`, `false`, `0` → 跳过扫描,不询问
- 未提供参数 → 询问用户(默认行为)

### 4.2 执行流程伪代码

```python
def enforce_doc_workflow(scan_param=None):
    """
    enforce-doc-workflow 命令的执行逻辑

    Args:
        scan_param: --scan 参数值,可选
    """
    # 1. 解析扫描参数
    if scan_param is not None:
        # 有参数,直接使用参数值
        should_scan = parse_scan_param(scan_param)
    else:
        # 无参数,询问用户
        should_scan = ask_user_for_scan()

    # 2. 根据决定执行或跳过扫描
    if should_scan:
        print("🔍 Scanning repository for documentation...")
        scan_results = perform_repository_scan()
        print("✅ Scan complete. Entering enforcement mode...")
    else:
        print("⚡ Skipping repository scan")
        print("✅ Entering enforcement mode...")
        scan_results = None

    # 3. 进入文档驱动强制模式
    enter_enforcement_mode(scan_results)


def parse_scan_param(param):
    """
    解析 --scan 参数

    Args:
        param: 参数值字符串

    Returns:
        bool: True 表示扫描, False 表示跳过
    """
    param_lower = param.lower()

    if param_lower in ['yes', 'y', 'true', '1']:
        return True
    elif param_lower in ['no', 'n', 'false', '0']:
        return False
    else:
        print(f"⚠️  Invalid --scan value: {param}")
        print("   Valid values: yes, no")
        print("   Defaulting to: ask user")
        return ask_user_for_scan()


def ask_user_for_scan():
    """
    询问用户是否扫描

    Returns:
        bool: True 表示扫描, False 表示跳过
    """
    print("📋 Documentation Scan")
    print()
    print("   The scan will check:")
    print("   • docs/requirements/ - Requirement documents")
    print("   • docs/standards/ - Project standards")
    print("   • CLAUDE.md - Workflow enforcement")
    print()
    print("❓ Do you want to scan the repository?")
    print("   [Y] Yes - Scan now (recommended if docs changed)")
    print("   [N] No - Skip scan (faster, if docs unchanged)")
    print()

    while True:
        choice = input("Your choice [Y/n]: ").strip()

        if choice == '' or choice.lower() in ['y', 'yes']:
            return True
        elif choice.lower() in ['n', 'no']:
            return False
        else:
            print(f"⚠️  Invalid input: {choice}")
            print("   Please enter Y or N")


def perform_repository_scan():
    """
    执行仓库扫描

    Returns:
        dict: 扫描结果
    """
    # 调用 doc-detector skill
    docs_structure = scan_docs_directory()
    print("   ✓ Scanned docs/requirements/ (X files)")
    print("   ✓ Scanned docs/standards/ (Y files)")

    # 调用 claude-md-enforcer skill
    claude_md_status = analyze_claude_md()
    print("   ✓ Analyzed CLAUDE.md")

    return {
        'docs_structure': docs_structure,
        'claude_md_status': claude_md_status
    }


def enter_enforcement_mode(scan_results):
    """
    进入文档驱动强制模式

    Args:
        scan_results: 扫描结果,如果跳过扫描则为 None
    """
    if scan_results:
        # 有扫描结果,使用结果进行判断
        enforce_with_scan_results(scan_results)
    else:
        # 无扫描结果,按需检查
        enforce_without_scan()
```

## 5. 工作流程设计

### 5.1 完整执行流程图

```
用户执行命令: claude enforce-doc-workflow [--scan=yes|no]
                          ↓
                  检查 --scan 参数
                          ↓
            ┌─────────────┴─────────────┐
            ↓                           ↓
     有 --scan 参数              无 --scan 参数
            ↓                           ↓
    解析参数值(yes/no)          显示扫描提示信息
            ↓                           ↓
            │                    询问用户选择(Y/n)
            │                           ↓
            │                    等待用户输入
            │                           ↓
            │                    解析用户输入
            │                           ↓
            └─────────────┬─────────────┘
                          ↓
                   should_scan?
                          ↓
            ┌─────────────┴─────────────┐
            ↓                           ↓
         Yes (扫描)                  No (跳过)
            ↓                           ↓
    显示扫描进度                 显示跳过信息
            ↓                           ↓
    调用 doc-detector                  │
            ↓                           │
    调用 claude-md-enforcer            │
            ↓                           │
    显示扫描完成                       │
            ↓                           │
    scan_results = {...}        scan_results = None
            │                           │
            └─────────────┬─────────────┘
                          ↓
            enter_enforcement_mode(scan_results)
                          ↓
                  文档驱动强制模式
```

### 5.2 Skill 调用策略

**有扫描结果时**:
- 使用 `doc-detector` 的结果判断缺失文档
- 使用 `claude-md-enforcer` 的结果判断 CLAUDE.md 状态
- 基于扫描结果提供精确的指导

**无扫描结果时**:
- 按需检查文档(当用户请求代码修改时)
- 延迟调用 skills(只在需要时调用)
- 提供通用的文档驱动指导

## 6. 文件修改清单

### 6.1 必须修改的文件

| 文件路径 | 修改类型 | 修改内容 |
|---------|---------|---------|
| `plugins/ai-doc-driven-dev/commands/enforce-doc-workflow.md` | 内容增强 | 添加扫描询问说明、参数说明、新示例 |
| `plugins/ai-doc-driven-dev/skills/doc-detector/SKILL.md` | 内容增强 | 说明可选扫描特性 |
| `plugins/ai-doc-driven-dev/skills/claude-md-enforcer/SKILL.md` | 内容增强 | 说明可选扫描特性 |

### 6.2 可选修改的文件

| 文件路径 | 修改类型 | 修改内容 |
|---------|---------|---------|
| `plugins/ai-doc-driven-dev/README.md` | 文档更新 | 更新命令使用说明 |
| `plugins/ai-doc-driven-dev/README-zh.md` | 文档更新 | 更新命令使用说明(中文) |

## 7. 向后兼容性

### 7.1 兼容性保证

**现有用户**:
- 默认行为变更: 从"自动扫描"变为"询问用户"
- 影响: 需要额外一次交互(按 Y 或回车即可)
- 优点: 更好的用户体验和控制

**自动化脚本**:
- 可以使用 `--scan=yes` 保持自动扫描行为
- 可以使用 `--scan=no` 跳过扫描加快执行

### 7.2 迁移指南

**对于习惯旧行为的用户**:
```bash
# 方式 1: 每次使用参数
claude enforce-doc-workflow --scan=yes

# 方式 2: 创建 alias
alias edw='claude enforce-doc-workflow --scan=yes'
```

**对于希望更快执行的用户**:
```bash
# 跳过扫描,直接进入
claude enforce-doc-workflow --scan=no
```

## 8. 质量保证

### 8.1 测试策略

**功能测试**:
1. 测试无参数时的交互流程
   - 输入 Y → 应该执行扫描
   - 输入 N → 应该跳过扫描
   - 直接回车 → 应该执行扫描(默认)
   - 输入无效值 → 应该提示并重新询问

2. 测试 `--scan=yes` 参数
   - 应该跳过询问,直接扫描

3. 测试 `--scan=no` 参数
   - 应该跳过询问,不扫描

4. 测试无效参数值
   - 应该提示错误,降级到询问用户

**集成测试**:
1. 扫描后进入文档驱动模式
   - 验证扫描结果被正确使用

2. 跳过扫描后进入文档驱动模式
   - 验证可以正常工作(按需检查文档)

**用户体验测试**:
1. 提示信息是否清晰易懂
2. 选项说明是否准确
3. 响应是否符合预期

### 8.2 质量指标

**功能完整性**:
- ✅ 支持交互式询问
- ✅ 支持参数化控制
- ✅ 扫描和跳过两种模式都能正常工作

**用户体验**:
- ✅ 提示信息清晰
- ✅ 响应及时(无额外延迟)
- ✅ 错误处理友好

**兼容性**:
- ✅ 支持旧行为(通过参数)
- ✅ 不破坏现有功能
- ✅ 文档更新完整

## 9. 实施步骤

### 阶段 1: 文档修改
1. 修改 `enforce-doc-workflow.md` 命令定义
2. 修改 `doc-detector/SKILL.md` 说明
3. 修改 `claude-md-enforcer/SKILL.md` 说明

### 阶段 2: 文档更新(可选)
1. 更新 `README.md` 使用说明
2. 更新 `README-zh.md` 使用说明

### 阶段 3: 测试验证
1. 手动测试各种场景
2. 验证提示信息正确性
3. 验证参数处理逻辑

### 阶段 4: 文档发布
1. 更新 CHANGELOG(如果有)
2. 发布更新说明

## 10. 未来扩展可能

虽然当前方案不包含这些功能,但为未来扩展预留可能性:

**可能的扩展方向**:
1. 记住用户选择(下次使用上次的选择)
2. 增加配置文件支持(设置默认行为)
3. 提供更多扫描选项(部分扫描、增量扫描等)
4. 添加扫描缓存机制(避免重复扫描)

**设计预留**:
- 当前设计不阻碍未来添加这些功能
- 参数系统可以扩展更多选项
- 交互流程可以增加更多选择

---

**实施建议**:
1. 先实现核心功能(询问用户)
2. 确保提示信息清晰易懂
3. 充分测试各种场景
4. 根据用户反馈迭代改进
