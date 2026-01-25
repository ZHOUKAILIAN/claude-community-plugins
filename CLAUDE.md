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
│           └── claude-md-enforcer/
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
| Skill directories | kebab-case/   | `claude-md-enforcer/`    |
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
| Plugin Discovery    | Search/browse available plugins | `docs/design/workflow.md` |
| Plugin Installation | Install from marketplace        | `scripts/scaffold.sh`     |
| Plugin Management   | List, update, uninstall         | `scripts/` collection     |
| Plugin Publishing   | Publish new plugins             | `scripts/publish.sh`      |

## Current Implementation Status

**Implemented**:

- Project structure and documentation design
- One example plugin: `ai-doc-driven-dev` (AI Documentation-Driven Development Plugin)
  - Provides: Documentation-driven development workflow enforcement, project analysis, pattern extraction
  - Features: Complete agents and commands system with 2 core agents and 3 commands
  - Agents: doc-flow-initializer (文档流程初始化), codebase-style-analyzer (代码风格分析)
  - Commands: init-doc-driven-dev, analyze-docs, extract-patterns
  - Skills: claude-md-enforcer, doc-detector, pattern-extractor, doc-generator
  - Allowed tools: Read, Write, Edit, Glob, Grep, Bash, LSP
- Core design documentation and standards
- Bilingual README requirements and templates

**Planned but Not Yet Implemented**:

- `.gitignore` file
- Additional design docs: `architecture.md`, `workflow.md`, `capability-list.md`, `interaction-protocol.md`
- Requirement documents
- Convention documents (lint, format, structure, naming)
- Reference documentation
- Example plugins (minimal, standard, advanced)
- Management scripts (validate.sh, format.sh, lint.sh, scaffold.sh, sync.sh, publish.sh)

## Design Alignment

The project explicitly aligns with **customplugin/plugins** reference implementation:

- ✅ Plugin metadata structure (`.claude-plugin/plugin.json`)
- ✅ MCP configuration (`.mcp.json`)
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

**CRITICAL**: All future development MUST follow this AI-driven documentation workflow:

### Development Workflow

1. **User Request**: User provides requirements or feature requests
2. **AI Documentation**: AI creates comprehensive documentation:
   - Requirement document in `docs/requirements/`
   - Technical design document in `docs/design/`
3. **User Review & Alignment**: User reviews and approves the documentation
4. **AI Implementation**: Only after approval, AI implements changes to `plugins/` based on the approved documentation

### Key Principles

- ❌ **PROHIBITED**: Direct modification of `plugins/` content without prior documentation and alignment
- ✅ **REQUIRED**: User → AI writes docs → User approval → AI implements via docs
- ✅ **REQUIRED**: All requirements and technical specifications must be documented before implementation
- 📋 **DOCUMENTATION-DRIVEN**: AI must reference and follow approved documentation when making any plugin changes

### Documentation Structure

**CRITICAL - Document Naming and Numbering**:
- ✅ **REQUIRED**: All documents MUST follow the numbering convention: `NNN-feature-name.md`
- ✅ **REQUIRED**: Document numbers MUST be sequential (001, 002, 003, etc.)
- ✅ **REQUIRED**: AI MUST scan `docs/requirements/` directory to determine the next available number before creating new documents
- ❌ **PROHIBITED**: Creating documents without proper numbering or reusing existing numbers
- ✅ **REQUIRED**: Use templates from `docs/standards/requirements-template.md` and `docs/standards/technical-design-template.md`

**Document Organization**:
- **Requirement documents** (functional requirements):
  - Location: `docs/requirements/NNN-feature-name.md`
  - Focus: What needs to be built, user stories, acceptance criteria
- **Technical design documents** (implementation details):
  - Location: `docs/design/NNN-feature-name-technical-design.md`
  - Focus: How to build it, architecture, implementation plan
- **Pairing**: Each requirement document should have a corresponding technical design document with the same number
- **Standards and templates**: Stored in `docs/standards/`

**Example Document Structure**:
```
docs/
├── requirements/
│   ├── 001-ai-doc-driven-dev-base-features.md
│   ├── 002-ai-doc-driven-dev-agents-commands.md
│   ├── 003-js-framework-repository-analyzer.md
│   └── ... (next would be 007-xxx.md)
├── design/
│   ├── 001-ai-doc-driven-dev-base-features-technical-design.md
│   ├── 002-ai-doc-driven-dev-agents-commands-technical-design.md
│   ├── 003-js-framework-repository-analyzer-technical-design.md
│   └── ... (next would be 007-xxx-technical-design.md)
└── standards/
    ├── requirements-template.md
    └── technical-design-template.md
```

**AI Workflow for Creating New Documents**:
1. **Scan existing documents**: Use `ls docs/requirements/` or `Glob` to list all existing requirement documents
2. **Determine next number**: Find the highest number (e.g., 006) and increment by 1 (e.g., 007)
3. **Create paired documents**:
   - Requirement: `docs/requirements/NNN-feature-name.md`
   - Technical design: `docs/design/NNN-feature-name-technical-design.md`
4. **Follow templates**: Use the standard templates for consistent structure

### Skill Development Standards

- All skill documentation MUST follow the template in `docs/standards/skill-documentation-template.md`
- Required sections: Overview, How It Works, When to Use This Skill, Examples
- Optional sections: Best Practices, Integration
- Consistent frontmatter format with name, description, allowed-tools, and license

This ensures proper planning, maintains consistency, and establishes clear approval gates for all marketplace development.
