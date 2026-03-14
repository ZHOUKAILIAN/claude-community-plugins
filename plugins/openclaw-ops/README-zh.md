# OpenClaw 运维工具包

用于管理和诊断 OpenClaw Telegram 机器人网关服务器的 Claude Code 插件。

## 概述

OpenClaw 运维工具包提供两个核心命令来维护你的 OpenClaw 部署：

- **`/openclaw-diagnose`** - 全面的服务健康诊断
- **`/openclaw-update-token`** - 自动化令牌同步

## 功能特性

### 诊断功能 (`/openclaw-diagnose`)

自动检查：
- ✅ systemd 服务状态
- ✅ OAuth 令牌过期时间
- ✅ 内存和资源使用情况
- ✅ 最近的错误日志
- ✅ 端口可用性

### 令牌管理 (`/openclaw-update-token`)

处理完整的令牌更新流程：
- 📁 读取本地 auth.json
- ✅ 验证 JWT 过期时间
- ⬆️  上传到服务器
- 🔄 同步配置文件
- ♻️  重启服务
- ✅ 验证成功

## 安装

```bash
# 通过 Claude Code 安装
claude code plugin install openclaw-ops

# 或手动安装
cd ~/.claude/plugins/
git clone <repo-url> openclaw-ops
```

## 配置

### 必需的环境变量

```bash
export OPENCLAW_SSH_HOST="你的服务器IP"  # 必需
```

### 可选的环境变量

```bash
export OPENCLAW_SSH_USER="root"                   # 默认: root
export OPENCLAW_SERVICE_NAME="openclaw"           # 默认: openclaw
export OPENCLAW_INSTALL_DIR="/root/openclaw"      # 默认: /root/openclaw
export OPENCLAW_CONFIG_DIR="/root/.openclaw"      # 默认: /root/.openclaw
export OPENCLAW_MEM_WARN_PCT="70"                 # 默认: 70
export OPENCLAW_MEM_CRIT_PCT="80"                 # 默认: 80
```

将这些添加到你的 `~/.bashrc` 或 `~/.zshrc` 以持久化。

## 使用方法

### 基础诊断

```bash
# 完整的系统健康检查
/openclaw-diagnose

# 带问题描述
/openclaw-diagnose Bot 不响应，超时 60 秒
/openclaw-diagnose 内存使用率过高
```

### 令牌更新

```bash
# 交互模式（询问令牌文件）
/openclaw-update-token

# 直接指定令牌文件
/openclaw-update-token ~/.codex/auth.json
/openclaw-update-token ~/Downloads/auth.json
```

## 输出示例

### 健康系统

```
🔍 OpenClaw 诊断报告
时间: 2026-03-14 10:30:00 UTC
服务器: 104.168.43.20
整体状态: ✅ 健康

系统状态:
✅ 服务: active (running) - 运行时间 2 天
✅ 令牌: 有效期 15 天
✅ 内存: 44% (1.06GB / 2.4GB)
✅ 日志: 无错误

所有检查通过！
```

### 警告状态

```
🔍 OpenClaw 诊断报告
时间: 2026-03-14 10:30:00 UTC
服务器: 104.168.43.20
整体状态: ⚠️  警告

发现问题 (1 项):
⚠️ 令牌将在 2 天后过期

建议操作:
1. 更新令牌: /openclaw-update-token
```

## 故障排查

### SSH 连接失败

```bash
# 测试 SSH 连接
ssh ${OPENCLAW_SSH_USER}@${OPENCLAW_SSH_HOST} echo "OK"

# 检查 SSH 密钥
ssh-add -l
```

### 环境变量未设置

```bash
# 检查当前值
echo $OPENCLAW_SSH_HOST

# 临时设置
export OPENCLAW_SSH_HOST="104.168.43.20"

# 永久设置（添加到 ~/.bashrc）
echo 'export OPENCLAW_SSH_HOST="104.168.43.20"' >> ~/.bashrc
source ~/.bashrc
```

### 权限被拒绝

```bash
# 使用 root 用户
export OPENCLAW_SSH_USER="root"

# 或授予权限
ssh root@server 'chown youruser /root/.openclaw -R'
```

## 系统要求

### 本地机器
- Claude Code CLI
- SSH 客户端
- OpenClaw 服务器的 SSH 访问权限

### 远程服务器
- 带 systemd 的 Linux
- Python 3.6+
- jq（用于 JSON 解析）
- 已安装并配置 OpenClaw

## 架构

```
┌─────────────────┐
│  Claude Code    │
│   (本地)        │
└────────┬────────┘
         │ SSH
         ▼
┌─────────────────┐
│  OpenClaw       │
│   服务器        │
│                 │
│  • systemd      │
│  • auth.json    │
│  • 配置文件     │
└─────────────────┘
```

插件使用 SSH 在远程服务器上执行诊断脚本和同步配置。

## 安全考虑

- 使用 SSH 进行安全通信
- 令牌通过安全的 SSH 通道传输
- 插件代码中不存储凭据
- 环境变量将敏感数据排除在版本控制之外
- 所有操作记录用于审计

## 贡献

欢迎贡献！请：
1. Fork 仓库
2. 创建特性分支
3. 提交 Pull Request

## 许可证

MIT License - 详见 LICENSE 文件

## 支持

- 问题反馈: [GitHub Issues](https://github.com/your-org/openclaw-ops/issues)
- 文档: 参见 `knowledge/` 目录
- 相关: [OpenClaw 官方文档](https://github.com/openclaw/openclaw)

---

**[中文版本](README-zh.md) | [English Version](README.md)**
