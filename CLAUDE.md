# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **Claude Code Plugin Marketplace** - a centralized repository designed to discover, install, manage, and publish Claude Code Plugins.

**Key Concept**:

- The repository itself IS the marketplace
- Each plugin in `plugins/` is an independent Claude Code Plugin offering specific functionality

## Project Structure

```
claude-code-plugins/
├── README.md                              # Main project documentation
├── docs/                                  # Marketplace design & documentation
│   ├── requirements/                      # Project requirements and technical designs
│   ├── standards/                         # Development standards and templates
│   │   └── skill-documentation-template.md # Standard skill documentation template
│   └── design/
│       └── directory-structure.md         # Comprehensive directory structure guide
├── plugins/                               # Collection of plugins (marketplace products)
│   └── ai-doc-driven-dev/                # Example: AI Documentation-Driven Development Plugin
│       ├── .claude-plugin/
│       │   └── plugin.json               # Plugin metadata manifest
│       ├── README.md                     # Plugin-specific documentation (bilingual)
│       └── skills/
│           └── doc-workflow-enforcer/
│               └── SKILL.md              # Skill definition with frontmatter
└── .git/                                  # Git repository
```

**Directory Purposes**:

- **`plugins/`**: The marketplace inventory - each subdirectory is a complete, independent Claude Code Plugin
- **`docs/requirements/`**: Project requirement documents (functional requirements)
- **`docs/design/`**: Technical design documents and architectural documentation
- **`docs/standards/`**: Development standards, templates, and coding conventions
- **`README.md`**: Main entry point explaining marketplace concept and capabilities

## Plugin Structure Pattern

Each plugin in `plugins/{name}/` follows this standardized structure:

```
plugins/{name}/
├── .claude-plugin/
│   └── plugin.json                # Metadata: name, version, author, keywords
├── .mcp.json                      # MCP server configuration (optional)
├── commands/                      # Command definitions (*.md with frontmatter)
├── skills/                        # Skill definitions (*/SKILL.md with frontmatter)
├── agents/                        # Agent definitions (*.md with frontmatter)
├── knowledge/                     # Knowledge base (guide.md, troubleshooting.md, etc.)
└── README.md                      # Plugin documentation
```

## Frontmatter Templates

**Skill Frontmatter** (from `SKILL.md`):

```markdown
---
name: [skill-name]
description: |
  [Description]
  <example>[Example 1]</example>
  <example>[Example 2]</example>
allowed-tools: ["Read", "Write", "Bash", "Grep"]
license: MIT
---
```

**Plugin Manifest** (`plugin.json`):

```json
{
  "name": "plugin-name",
  "version": "1.0.0",
  "description": "Description",
  "author": {
    "name": "...",
    "email": "..."
  },
  "keywords": ["keyword1", "keyword2"]
}
```

## File Naming Conventions

| Type              | Convention    | Example                  |
| ----------------- | ------------- | ------------------------ |
| Plugin directory  | kebab-case    | `ai-doc-driven-dev/`     |
| Markdown docs     | kebab-case.md | `directory-structure.md` |
| Command files     | kebab-case.md | `plugin-a-action.md`     |
| Skill directories | kebab-case/   | `doc-workflow-enforcer/`    |
| Skill files       | SKILL.md      | `SKILL.md`               |

## Documentation Standards

### README Requirements

- **Bilingual Support**: All plugin documentation MUST be available in both English and Chinese
- **Structure**: Use separate files - `README.md` (English) and `README-zh.md` (Chinese)
- **Consistency**: Both language versions should contain equivalent information
- **Cross-linking**: Each file must include language switching links at the bottom
- **Maintenance**: When updating README content, both language versions must be updated simultaneously

**File Structure:**

```
plugin-name/
├── README.md           # English version
├── README-zh.md        # Chinese version
└── [other files]
```

**Language Switching Template:**

```markdown
---

**[中文版本](README-zh.md) | [English Version](README.md)**
```

**Enforcement**: All existing and new plugins must provide both English and Chinese documentation in separate files

## Marketplace Core Capabilities

| Capability          | Purpose                         | Implementation            |
| ------------------- | ------------------------------- | ------------------------- |
| Plugin Discovery    | Search/browse available plugins | `README.md` + `plugins/` |
| Plugin Installation | Install a specific plugin       | Manual copy from `plugins/<name>/` plus each plugin's `README.md` |
| Plugin Management   | Inspect current plugin inventory | `plugins/*/.claude-plugin/plugin.json` |
| Plugin Publishing   | Contribute new plugins          | Documentation + pull request workflow |

## Current Implementation Status

**Implemented**:

- Project structure and documentation design
- Four plugins are currently present in `plugins/`: `ai-doc-driven-dev`, `git-ops-helper`, `js-framework-analyzer`, `openclaw-ops`
- `ai-doc-driven-dev`
  - Commands currently present: `init-doc-driven-dev`, `update-doc-driven-dev`, `update-standards`
  - Skills currently present: `doc-workflow-enforcer`, `doc-detector`, `doc-generator`, `pattern-extractor`
- `git-ops-helper`
  - Command currently present: `summarize-commit`
- `js-framework-analyzer`
  - Commands currently present: `analyze-mf-isolation`, `analyze-reactivity`
  - Disabled command still documented: `analyze-ai-platform`
- `openclaw-ops`
  - Commands currently present: `openclaw-diagnose`, `openclaw-update-token`
- Core design documentation and standards
- Bilingual README requirements and templates

**Planned but Not Yet Implemented**:

- `.gitignore` file
- Additional standalone architecture/workflow reference docs
- Convention documents (lint, format, structure, naming)
- Reference documentation
- Example plugins (minimal, standard, advanced)
- Repository-level management scripts (validate, format, lint, scaffold, sync, publish)

## Design Alignment

The project explicitly aligns with **customplugin/plugins** reference implementation:

- ✅ Plugin metadata structure (`.claude-plugin/plugin.json`)
- ✅ Command definitions (`commands/*.md`)
- ✅ Skill definitions (`skills/*/SKILL.md`)
- ✅ Agent definitions (`agents/*.md`)
- ✅ Knowledge base (`knowledge/*.md`)
- ✅ Consistent frontmatter format

## Key Patterns and Principles

1. **Documentation-First**: Entire project is structured around Markdown documentation with frontmatter
2. **Kebab-Case Naming**: Consistent naming convention across all files and directories
3. **Modular Plugins**: Each plugin is completely independent and self-contained
4. **Standardized Metadata**: All plugins use consistent `plugin.json` structure
5. **Tool Permissions**: Each skill explicitly declares allowed tools via frontmatter
6. **Marketplace Model**: Repository acts as a central registry for discovering and managing plugins
7. **Skill Documentation Standards**: All skills follow the template defined in `docs/standards/skill-documentation-template.md`

## Development Process Requirements

**CRITICAL**: All future development MUST follow this documentation-driven workflow.

### Development Workflow

See **[AGENTS.md](AGENTS.md)** for complete AI workflow rules and development process.

**Quick Summary**:
1. **Documentation First**: Create requirements and technical design docs
2. **User Approval**: Get approval before implementation
3. **Implementation**: Code based on approved documentation

### Documentation Standards

**Document Naming (Date-Based)**:
- Requirements: `docs/requirements/YYYYMMDD-feature-name.md`
- Technical Design: `docs/design/YYYYMMDD-feature-name-technical-design.md`
- Same-day conflicts: append `-v2`, `-v3`

**Document Organization**:
```
docs/
├── requirements/        # Feature requirements (REQ-YYYYMMDD)
├── design/             # Technical designs (TECH-YYYYMMDD)
├── standards/          # Templates and conventions
└── analysis/           # Project analysis and patterns
```

**Templates**:
- [Requirements Template](docs/standards/requirements-template.md)
- [Technical Design Template](docs/standards/technical-design-template.md)
- [Skill Documentation Template](docs/standards/skill-documentation-template.md)

### Visual-First Principle

- Use Mermaid diagrams for architecture, data flows, and state transitions
- Use Markdown tables for data structures, API parameters, and configurations
- Show modifications inline within diagrams/tables (no separate Before/After sections)

### Key Principles

- ❌ **PROHIBITED**: Direct code changes without prior documentation
- ✅ **REQUIRED**: Documentation → User approval → Implementation
- 📋 **DOCUMENTATION-DRIVEN**: All changes must reference approved documentation

For detailed AI workflow rules, see **[AGENTS.md](AGENTS.md)**.
