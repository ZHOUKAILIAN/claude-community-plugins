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
| **AI Documentation-Driven Development** | CLAUDE.md Enforcement, Documentation Analysis, Pattern Extraction, Smart Documentation Generation | Establishes documentation-first development workflows and maintains project documentation standards |

## 📦 Plugin Details

### AI Documentation-Driven Development
**Location**: `plugins/ai-doc-driven-dev/`

**Purpose**: Transform any project into a documentation-driven development workflow with AI assistance

**Key Capabilities**:
- **🔧 CLAUDE.md Enforcement**: Automatically ensures CLAUDE.md contains mandatory documentation-driven development workflows
- **📊 Documentation Analysis**: Comprehensive assessment of project documentation completeness
- **🎯 Pattern Extraction**: Automatically extracts project-specific coding patterns and conventions
- **📝 Smart Generation**: Creates standardized documentation based on project analysis and templates

**Skills Included**: claude-md-enforcer, doc-detector, pattern-extractor, doc-generator

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
   # Copy the plugin to your Claude Code plugins directory
   cp -r plugins/ai-doc-driven-dev ~/.claude-code/plugins/
   ```

3. **Use the Plugin**
   - Restart Claude Code
   - The plugin's skills and commands will be available automatically

### For Plugin Developers

1. **Create a New Plugin**
   ```bash
   # Use the plugin template (coming soon)
   ./scripts/scaffold.sh my-awesome-plugin
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
   # Validate your plugin structure
   ./scripts/validate.sh plugins/my-awesome-plugin
   ```

4. **Publish to Marketplace**
   ```bash
   # Submit your plugin for review
   ./scripts/publish.sh my-awesome-plugin
   ```

## 📚 Documentation

### For Users
- [Plugin Installation Guide](docs/user-guide/installation.md) *(Coming Soon)*
- [Plugin Management](docs/user-guide/management.md) *(Coming Soon)*

### For Developers
- [Plugin Development Guide](docs/developer-guide/getting-started.md) *(Coming Soon)*
- [Skill Documentation Template](docs/standards/skill-documentation-template.md)
- [Plugin Structure Reference](docs/design/directory-structure.md)

### Architecture & Design
- [Marketplace Architecture](docs/design/architecture.md) *(Coming Soon)*
- [Plugin Standards](docs/standards/)
- [Development Workflow](docs/design/workflow.md) *(Coming Soon)*

## 🏗️ Project Structure

```
claude-code-plugins/
├── README.md                    # This file
├── README-zh.md                 # Chinese version
├── plugins/                     # Plugin collection (marketplace inventory)
│   └── ai-doc-driven-dev/      # Example plugin
├── docs/                        # Documentation and design specs
│   ├── design/                  # Architecture and design docs
│   ├── standards/               # Development standards and templates
│   └── requirements/            # Project requirements
└── scripts/                     # Management and automation scripts
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

- **Issues**: [GitHub Issues](https://github.com/your-username/claude-code-plugins/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-username/claude-code-plugins/discussions)
- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md) *(Coming Soon)*

---

**[中文版本](README-zh.md) | [English Version](README.md)**

*Last Updated: 2026-01-10*