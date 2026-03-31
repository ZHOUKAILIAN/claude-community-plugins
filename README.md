# Claude Code Plugin Marketplace

A centralized repository for discovering, installing, managing, and publishing Claude Code plugins. This marketplace serves as the official distribution platform for Claude Code extensions and tools.

## 🎯 What is This?

The **Claude Code Plugin Marketplace** is both a repository and a distribution platform where:
- **Developers** can discover and install plugins to extend Claude Code functionality
- **Plugin authors** can publish and share their Claude Code plugins with the community
- **Organizations** can manage and distribute internal Claude Code tools

**Key Concept**: The repository itself IS the marketplace - each plugin in the `plugins/` directory is a complete, independent Claude Code plugin ready for installation.

## 🚀 Available Features

| Plugin | Features | Description |
|--------|----------|-------------|
| **AI Documentation-Driven Development** | Workflow Instruction Enforcement (`CLAUDE.md` / `AGENTS.md`), Documentation Analysis, Pattern Extraction, Smart Documentation Generation | Establishes documentation-first development workflows and maintains project documentation standards |
| **Git Ops Helper** | Commit Summaries, Message Drafting, Conflict Resolution, Rebase Workflows | Provides safe, repeatable Git workflows with clear commands, change summaries, and expert guidance |
| **OpenClaw Operations Toolkit** | Remote Diagnostics ✅, Token Synchronization ✅ | Manages OpenClaw Telegram bot gateway servers with SSH-based diagnostics and token update workflows |
| **JS Framework Analyzer** | Microfrontend Isolation Analysis ✅, AI Platform Architecture Analysis 🚧, Reactivity System Analysis ✅ | Analyzes JavaScript framework source code to understand core implementation mechanisms with bilingual reports and PlantUML diagrams |

## 📦 Plugin Details

### AI Documentation-Driven Development
**Location**: `plugins/ai-doc-driven-dev/`

**Purpose**: Transform any project into a documentation-driven development workflow with AI assistance

**Key Capabilities**:
- **🔧 Workflow Instruction Enforcement**: Automatically ensures `CLAUDE.md` or `AGENTS.md` contains mandatory documentation-driven development workflows
- **📊 Documentation Analysis**: Comprehensive assessment of project documentation completeness
- **🎯 Pattern Extraction**: Automatically extracts project-specific coding patterns and conventions
- **📝 Smart Generation**: Creates standardized documentation based on project analysis and templates

**Skills Included**: doc-workflow-enforcer, doc-detector, pattern-extractor, doc-generator

### Git Ops Helper
**Location**: `plugins/git-ops-helper/`

**Purpose**: Provide safe, repeatable Git workflows with clear commands, change summaries, and expert guidance

**Key Capabilities**:
- **📝 Commit Summaries**: Automatically summarize git changes with clear descriptions
- **✉️ Message Drafting**: Draft commit messages following standard conventions
- **🔀 Conflict Resolution**: Expert guidance for resolving merge conflicts
- **🔄 Rebase Workflows**: Safe guidance for rebase, cherry-pick, and merge operations
- **🛡️ Safety Rules**: Never runs Git commands without explicit user confirmation

**Skills Included**: git-ops-helper

**Commands Included**: summarize-commit

**Safety Features**:
- Always shows exact command before asking for confirmation
- Offers to create new branch before committing on main/master
- Provides clear warnings for risky operations like reset --hard

### OpenClaw Operations Toolkit
**Location**: `plugins/openclaw-ops/`

**Purpose**: Diagnose and maintain OpenClaw Telegram bot gateway servers

**Key Capabilities**:
- **🔍 Remote Diagnostics**: Checks service status, token expiration, logs, memory pressure, and listening ports over SSH
- **🔄 Token Synchronization**: Uploads local auth tokens, updates remote config, restarts services, and verifies success
- **🛡️ Operational Guidance**: Keeps environment-variable requirements and troubleshooting guidance close to the commands

**Commands Included**: `openclaw-diagnose`, `openclaw-update-token`

### JS Framework Analyzer
**Location**: `plugins/js-framework-analyzer/`

**Purpose**: Analyze JavaScript framework source code to understand core implementation mechanisms through exploratory code analysis

**Key Capabilities**:
- **🔍 Microfrontend Isolation Analysis**: Deep analysis of JS and CSS isolation mechanisms in microfrontend frameworks (qiankun, wujie, single-spa, emp) ✅
- **🏗️ AI Platform Architecture Analysis**: Comprehensive analysis of AI application platform architecture and core functionality (Coze, Dify, FastGPT) *TODO*
- **⚡ Reactivity System Analysis**: Detailed analysis of frontend framework reactivity systems (Vue, React, SolidJS, Svelte) ✅
- **🌐 Bilingual Reports**: All analysis reports generated in both English and Chinese with equivalent content ✅
- **📊 PlantUML Diagrams**: Visual structure diagrams showing report organization and component relationships ✅

**Skills Included**:
- ✅ microfrontend-isolation-analyzer
- 🚧 ai-platform-analyzer *(Coming Soon)*
- ✅ reactivity-system-analyzer
- ✅ structure-explainer

**Report Features**:
- Comprehensive analysis of core implementation mechanisms
- Key code snippets with detailed annotations
- Trade-offs and design decisions analysis
- Summary & insights with best practices recommendations
- PlantUML structure diagrams for visual understanding
- Bilingual output (English/Chinese) with consistent content

**Implementation Status**:
- ✅ Microfrontend Isolation Analysis: Fully implemented and documented
- 🚧 AI Platform Architecture Analysis: Design completed, implementation in progress
- ✅ Reactivity System Analysis: Fully implemented and documented

*More plugins coming soon...*

## 🔧 How to Get Started

### For Plugin Users

1. **Browse Available Plugins**
   ```bash
   # Navigate to the marketplace
   cd claude-code-plugins
   ls plugins/
   ```

2. **Install a Plugin**
   ```bash
   # Clone the marketplace repository
   git clone git@github.com:ZHOUKAILIAN/claude-community-plugins.git
   cd claude-community-plugins

   # Copy the specific plugin you want into your local Claude plugin directory
   cp -R plugins/ai-doc-driven-dev <your-claude-plugin-dir>/ai-doc-driven-dev
   ```

3. **Use the Plugin**
   - Restart or reload Claude Code after copying the plugin
   - Follow the plugin's own `README.md` for its commands, skills, and environment requirements

### For Codex Users

Codex typically works in an intent-driven way instead of `claude <command>` syntax.

1. **Open the target plugin directory**
   - Example: `plugins/ai-doc-driven-dev/`
2. **Use intent-based requests**
   - Example intents:
     - "Initialize docs-first workflow for this project"
     - "Analyze documentation gaps and naming compliance"
     - "Generate requirement and technical design docs from templates"
3. **Follow plugin docs as execution spec**
   - Read `README.md` and command/skill docs under the plugin (`commands/`, `skills/`)
4. **Apply the same workflow gates**
   - Keep docs-before-code, requirement/design pairing, and verification steps consistent with plugin guidance

### For Plugin Developers

1. **Create a New Plugin**
   ```bash
   # Create a new plugin directory under plugins/
   mkdir -p plugins/my-awesome-plugin
   ```

2. **Follow the Plugin Structure**
   ```
   plugins/my-awesome-plugin/
   ├── .claude-plugin/
   │   └── plugin.json          # Plugin metadata
   ├── skills/                  # Skill definitions
   ├── commands/               # Command definitions
   ├── agents/                 # Agent definitions
   ├── knowledge/              # Knowledge base
   └── README.md               # Plugin documentation
   ```

3. **Test and Validate**
   ```bash
   # Compare your structure against existing plugins and the directory guide
   ls plugins/my-awesome-plugin
   ```

4. **Publish to Marketplace**
   ```bash
   # Open a pull request with the new plugin and its documentation
   git status
   ```

## 📖 Usage Tutorial

### AI Documentation-Driven Development Plugin

This repository currently documents the following `ai-doc-driven-dev` commands as available:

- `init-doc-driven-dev`
- `update-doc-driven-dev`
- `update-standards`

#### 🚀 Quick Start

**Step 1: Install the Plugin**
```bash
git clone git@github.com:ZHOUKAILIAN/claude-community-plugins.git
cd claude-community-plugins
cp -R plugins/ai-doc-driven-dev <your-claude-plugin-dir>/ai-doc-driven-dev
```

**Step 2: Initialize Docs-First Workflow**
```bash
cd your-project
init-doc-driven-dev
```

**Step 3: Sync Existing Workflow Files with the Latest Plugin Rules**
```bash
update-doc-driven-dev
```

**Step 4: Refresh Existing Docs Against Current Standards**
```bash
update-standards
```

#### What These Commands Cover

| Command | Purpose | Current State |
|---------|---------|---------------|
| `init-doc-driven-dev` | Create or update docs-first workflow files and base `docs/` structure | Available |
| `update-doc-driven-dev` | Update existing workflow files to current plugin conventions | Available |
| `update-standards` | Review docs drift and synchronize approved standard changes | Available |

For command details, read:
- `plugins/ai-doc-driven-dev/README.md`
- `plugins/ai-doc-driven-dev/commands/init-doc-driven-dev.md`
- `plugins/ai-doc-driven-dev/commands/update-doc-driven-dev.md`
- `plugins/ai-doc-driven-dev/commands/update-standards.md`

## 📚 Documentation

### For Users
- Start with the root `README.md` and each plugin's own `README.md`
- Browse available plugins directly under `plugins/`

### For Developers
- [Skill Documentation Template](docs/standards/skill-documentation-template.md)
- [Requirements Template](docs/standards/requirements-template.md)
- [Technical Design Template](docs/standards/technical-design-template.md)
- [Plugin Structure Reference](docs/design/directory-structure.md)

### Architecture & Design
- Review the dated technical designs under `docs/design/`
- Review the dated requirements under `docs/requirements/`
- Review shared standards under `docs/standards/`

## 🏗️ Project Structure

```
claude-code-plugins/
├── README.md                    # This file
├── README-zh.md                 # Chinese version
├── plugins/                     # Plugin collection (marketplace inventory)
│   ├── ai-doc-driven-dev/
│   ├── git-ops-helper/
│   ├── js-framework-analyzer/
│   └── openclaw-ops/
├── docs/                        # Documentation and design specs
│   ├── design/                  # Architecture and design docs
│   ├── standards/               # Development standards and templates
│   └── requirements/            # Project requirements
```

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

1. **Submit a Plugin**: Share your Claude Code plugin with the community
2. **Improve Documentation**: Help us make the marketplace more accessible
3. **Report Issues**: Found a bug? Let us know in the issues section
4. **Feature Requests**: Suggest new marketplace features

### Contribution Guidelines
- All plugins must include both English and Chinese documentation
- Follow the established plugin structure and naming conventions
- Include comprehensive tests and examples
- Adhere to the code of conduct

## 📄 License

This project is licensed under the MIT License - see individual plugin licenses for their specific terms.

## 🌐 Community

- **Issues**: [GitHub Issues](https://github.com/ZHOUKAILIAN/claude-community-plugins/issues)
- **Discussions**: [GitHub Discussions](https://github.com/ZHOUKAILIAN/claude-community-plugins/discussions)
- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md) *(Coming Soon)*

---

**[中文版本](README-zh.md) | [English Version](README.md)**

*Last Updated: 2026-01-16*
