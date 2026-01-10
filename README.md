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
   # Add this marketplace repository
   /plugin add marketplace git@github.com:ZHOUKAILIAN/claude-community-plugins.git

   # Install the specific plugin you want
   /plugin add ai-doc-driven-dev
   ```

3. **Use the Plugin**
   - The plugin will be automatically loaded
   - All skills and commands will be available immediately

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

## 📖 Usage Tutorial

### AI Documentation-Driven Development Plugin

This comprehensive tutorial shows you how to use the AI Documentation-Driven Development plugin to transform your project into a documentation-first development workflow.

#### 🚀 Quick Start

**Step 1: Install the Plugin**
```bash
# Add the marketplace repository
/plugin add marketplace git@github.com:ZHOUKAILIAN/claude-community-plugins.git

# Install the AI Documentation-Driven Development plugin
/plugin add ai-doc-driven-dev

# The plugin will be automatically loaded
```

**Step 2: Initialize Documentation-Driven Development**
```bash
# Navigate to your project root
cd your-project

# Initialize complete documentation workflow
claude init-doc-driven-dev
```

This command will:
- ✅ Create or update `CLAUDE.md` with documentation-first workflow
- ✅ Establish standard `docs/` directory structure
- ✅ Analyze your project type (frontend/backend/fullstack)
- ✅ Generate project-specific documentation templates

#### 🎯 Core Commands

##### 1. **Initialize Documentation Workflow** (`init-doc-driven-dev`)

**Basic Usage:**
```bash
# Standard initialization
claude init-doc-driven-dev

# With specific project template
claude init-doc-driven-dev --template frontend

# Force overwrite existing files
claude init-doc-driven-dev --force

# Analyze only, don't create files
claude init-doc-driven-dev --analyze-only
```

**What it creates:**
```
your-project/
├── CLAUDE.md                    # Enhanced with doc-driven workflow
├── docs/
│   ├── requirements/
│   │   └── project-requirements.md
│   ├── design/
│   │   └── technical-design.md
│   ├── standards/
│   │   ├── coding-standards.md
│   │   └── project-conventions.md
│   └── analysis/
│       └── project-analysis.md
└── [your existing files]
```

##### 2. **Analyze Documentation** (`analyze-docs`)

**Basic Usage:**
```bash
# Quick documentation analysis
claude analyze-docs

# Detailed analysis with report
claude analyze-docs --detailed --save analysis-report.md

# Focus on specific areas
claude analyze-docs --focus requirements
claude analyze-docs --focus design
claude analyze-docs --focus standards

# Export in different formats
claude analyze-docs --format json --save docs-analysis.json
claude analyze-docs --format html --save report.html
```

**What it analyzes:**
- 📋 **Requirements**: Functional/non-functional requirements completeness
- 🏗️ **Technical Design**: Architecture, API, database documentation
- 📏 **Standards**: Coding standards, conventions, workflows
- 🔍 **Code Documentation**: Inline comments, API docs, configuration

##### 3. **Extract Coding Patterns** (`extract-patterns`)

**Basic Usage:**
```bash
# Extract all patterns
claude extract-patterns

# Project-specific extraction
claude extract-patterns --type frontend
claude extract-patterns --type backend
claude extract-patterns --type fullstack

# Selective pattern extraction
claude extract-patterns --include naming,api,architecture
claude extract-patterns --exclude testing,database

# Export patterns
claude extract-patterns --format json --output patterns.json
```

**Pattern Types:**
- `naming` - Variable, function, class, file naming conventions
- `architecture` - Code organization and structural patterns
- `api` - API design and endpoint conventions
- `error-handling` - Exception handling patterns
- `styling` - Code formatting and style patterns
- `testing` - Test organization and naming patterns
- `database` - Database naming and query patterns

#### 🎨 Project-Specific Features

##### Frontend Projects (React, Vue, Angular)
```bash
# Initialize with frontend template
claude init-doc-driven-dev --template frontend

# Extract frontend-specific patterns
claude extract-patterns --type frontend --include naming,api,styling
```

**Frontend patterns include:**
- Component organization and naming
- State management patterns (Redux, Context, Zustand)
- Styling approaches (CSS-in-JS, modules, traditional)
- API integration patterns
- TypeScript interface conventions

##### Backend Projects (Node.js, Python, Java)
```bash
# Initialize with backend template
claude init-doc-driven-dev --template backend

# Extract backend-specific patterns
claude extract-patterns --type backend --include api,database,error-handling
```

**Backend patterns include:**
- API endpoint organization and naming
- Data model and entity patterns
- Authentication and security patterns
- Database access and ORM usage
- Response format conventions

##### Full-Stack Projects
```bash
# Initialize with full-stack template
claude init-doc-driven-dev --template fullstack

# Comprehensive pattern extraction
claude extract-patterns --type fullstack
```

#### 🔄 Typical Workflow

**For New Projects:**
```bash
# 1. Initialize documentation structure
claude init-doc-driven-dev

# 2. Start developing with documentation-first approach
# (Write requirements and design docs first)

# 3. Extract patterns as code grows
claude extract-patterns

# 4. Regularly analyze documentation quality
claude analyze-docs --detailed
```

**For Existing Projects:**
```bash
# 1. Analyze current documentation state
claude analyze-docs --detailed --save current-state.md

# 2. Extract existing patterns
claude extract-patterns --output existing-patterns.md

# 3. Initialize documentation structure
claude init-doc-driven-dev --force

# 4. Integrate extracted patterns into new structure
# (Manual step - review and merge patterns)

# 5. Establish ongoing documentation workflow
```

#### 💡 Best Practices

**1. Start with Analysis**
```bash
# Always understand current state first
claude analyze-docs --detailed
claude extract-patterns --format json --output current-patterns.json
```

**2. Use Project-Specific Templates**
```bash
# Choose appropriate template for better defaults
claude init-doc-driven-dev --template frontend    # For React/Vue/Angular
claude init-doc-driven-dev --template backend     # For APIs/servers
claude init-doc-driven-dev --template fullstack   # For complete applications
```

**3. Regular Documentation Maintenance**
```bash
# Weekly documentation health check
claude analyze-docs --focus all --save weekly-check.md

# Monthly pattern updates
claude extract-patterns --output updated-patterns.md
```

**4. Integration with Development Workflow**
- Update documentation BEFORE writing code
- Use extracted patterns for code reviews
- Reference standards during development
- Run analysis before major releases

#### 🛠️ Advanced Usage

**Custom Analysis Focus:**
```bash
# Deep dive into specific areas
claude analyze-docs --focus requirements --detailed
claude analyze-docs --focus design --format html --save design-analysis.html
```

**Selective Pattern Extraction:**
```bash
# Only naming and API patterns
claude extract-patterns --include naming,api --output core-patterns.md

# Everything except testing patterns
claude extract-patterns --exclude testing --format yaml
```

**Batch Operations:**
```bash
# Complete project setup in one go
claude init-doc-driven-dev --template frontend && \
claude extract-patterns --type frontend && \
claude analyze-docs --detailed --save initial-analysis.md
```

#### 🔍 Troubleshooting

**Common Issues:**

1. **"Project not in Git repository"**
   ```bash
   # Initialize Git first
   git init
   claude init-doc-driven-dev
   ```

2. **"Existing docs/ conflicts"**
   ```bash
   # Backup existing docs and force initialization
   mv docs docs-backup
   claude init-doc-driven-dev --force
   # Then manually merge important content
   ```

3. **"No patterns found"**
   ```bash
   # Ensure you're in project root with source code
   claude extract-patterns --type frontend --include naming
   ```

4. **"Analysis shows 0% completeness"**
   ```bash
   # Start with initialization first
   claude init-doc-driven-dev
   claude analyze-docs
   ```

This tutorial covers the complete workflow for implementing documentation-driven development in your projects. For more advanced features and customization options, refer to the individual command documentation.

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

- **Issues**: [GitHub Issues](https://github.com/ZHOUKAILIAN/claude-community-plugins/issues)
- **Discussions**: [GitHub Discussions](https://github.com/ZHOUKAILIAN/claude-community-plugins/discussions)
- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md) *(Coming Soon)*

---

**[中文版本](README-zh.md) | [English Version](README.md)**

*Last Updated: 2026-01-10*