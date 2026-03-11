# AI Documentation-Driven Development Plugin

Transform any project into a documentation-driven development workflow with AI assistance. This plugin automatically detects, generates, and maintains project documentation standards, ensuring consistent and maintainable development practices.

## Overview

The AI Documentation-Driven Development Plugin helps teams establish and maintain documentation-first development workflows. It enforces the principle that all code changes must be preceded by appropriate documentation updates, creating better maintainability and team collaboration.

## Key Features

- **🔧 Workflow Instruction Enforcement**: Ensures `CLAUDE.md` or `AGENTS.md` contains mandatory documentation-driven development workflows
- **📊 Documentation Analysis**: Comprehensive assessment of project documentation completeness
- **🎯 Pattern Extraction**: Automatically extracts project-specific coding patterns and conventions
- **📝 Smart Generation**: Creates standardized documentation based on project analysis and templates

## Skills Included

### 1. doc-workflow-enforcer
Enforces documentation-driven development workflow in instruction files (`CLAUDE.md` / `AGENTS.md`). This skill runs first to establish the foundation for documentation-first development.

**Use cases:**
- Initialize documentation-driven development in new projects
- Update existing projects to follow documentation standards
- Synchronize CLAUDE.md with evolving project standards

### 2. doc-detector
Analyzes project documentation completeness and identifies missing critical documents.

**Use cases:**
- Assess current documentation status
- Identify gaps in documentation coverage
- Prepare recommendations for documentation improvements

### 3. pattern-extractor
Extracts project-specific coding patterns, conventions, and standards from existing codebase.

**Use cases:**
- Document existing project coding standards
- Create guidelines for new team members
- Ensure AI code generation follows established patterns

### 4. doc-generator
Generates standardized project documentation using intelligent templates and project analysis.

**Use cases:**
- Create missing documentation identified by doc-detector
- Establish comprehensive documentation structure
- Generate project-specific standards based on extracted patterns

## Commands

### enforce-doc-workflow

Enable documentation-first workflow enforcement for code change requests.

**Usage:**
```bash
claude enforce-doc-workflow [--scan=yes|no]
```

**Features:**
- **Interactive Scan Prompt**: Asks whether to scan repository before entering enforcement mode
- **Flexible Scanning**: Choose to scan or skip based on your needs
  - Scan: Check documentation completeness (recommended if docs changed)
  - Skip: Faster startup (use if docs unchanged)
- **Parameter Support**: Use `--scan=yes` to auto-scan or `--scan=no` to skip prompt

**What it does:**
1. Optionally scans `docs/requirements/`, `docs/standards/`, and `CLAUDE.md`
2. Enters enforcement mode to intercept code change requests
3. Ensures all code changes are preceded by proper documentation
4. Guides you to create missing requirement and technical design documents

**Example workflow:**
```bash
# Interactive mode (default) - asks whether to scan
claude enforce-doc-workflow

# Auto-scan mode - skips prompt and scans
claude enforce-doc-workflow --scan=yes

# Skip scan mode - skips prompt and scan
claude enforce-doc-workflow --scan=no
```

## Getting Started

1. **Install the Plugin**: Add this plugin to your Claude Code environment
2. **Run Initial Setup**: Use the doc-workflow-enforcer skill to establish documentation-driven development workflow
3. **Analyze Your Project**: Use doc-detector to understand current documentation status
4. **Extract Patterns**: Use pattern-extractor to document existing coding conventions
5. **Generate Documentation**: Use doc-generator to create missing documentation

## Documentation Structure

The plugin establishes and maintains this standard documentation structure:

```
docs/
├── requirements/     # Project requirements and specifications
├── design/          # Technical design and architecture
├── analysis/        # Project and codebase analysis
├── standards/       # Coding standards and conventions
└── [custom]/        # Project-specific documentation
```

## Workflow Integration

This plugin integrates seamlessly with existing development workflows:

1. **Before Code Changes**: Update relevant documentation in docs/
2. **AI Development**: Claude Code CLI reads docs/ for context and constraints
3. **Code Implementation**: Implement changes based on documented requirements and standards
4. **Review Process**: Ensure code matches documented specifications

## Best Practices

- **Start with Instruction Files**: Always run doc-workflow-enforcer first to establish workflow standards in `CLAUDE.md` or `AGENTS.md`
- **Regular Analysis**: Periodically run doc-detector to maintain documentation completeness
- **Pattern Updates**: Re-run pattern-extractor when significant architectural changes occur
- **Template Customization**: Adapt generated documentation templates to project-specific needs

## Benefits

- **Consistency**: Ensures all team members follow the same development standards
- **Maintainability**: Creates comprehensive documentation for long-term project maintenance
- **AI Effectiveness**: Provides rich context for more accurate AI-assisted development
- **Team Onboarding**: Simplifies new team member integration with clear documentation

## License

MIT License - see LICENSE file for details.

## Contributing

Contributions are welcome! Please read the contributing guidelines and follow the established documentation-driven development workflow.

---

**[中文版本](README-zh.md) | [English Version](README.md)**
