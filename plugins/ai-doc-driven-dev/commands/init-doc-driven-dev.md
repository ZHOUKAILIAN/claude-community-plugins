---
description: Initialize documentation-driven development workflow in the current project
category: setup
shortcut: "idd"
model: inherit
---

# Initialize Documentation-Driven Development

Quickly set up a complete documentation-driven development workflow in any project.

## Description

This command initializes a comprehensive documentation-driven development setup by:

1. **CLAUDE.md Setup**: Creates or updates CLAUDE.md with a focus on workflow and rules. It links out to detailed docs rather than embedding them.
2. **AGENTS.md Setup**: Generates AGENTS.md in the root directory to guide AI capabilities and runtime rules.
3. **Documentation Structure**: Establishes standard docs/ directory structure for deep analysis and standards.
4. **Project Analysis**: Analyzes current project type and existing patterns.
5. **Standards Extraction**: Documents existing coding conventions, testing patterns, and architectural specifics.
6. **Template Generation**: Creates project-specific documentation templates.

## Options

- `--force` - Overwrite existing documentation files
- `--template <type>` - Use specific template (frontend/backend/fullstack)
- `--minimal` - Create minimal documentation structure only
- `--analyze-only` - Only analyze project without creating files

## Examples

```bash
# Basic initialization
init-doc-driven-dev

# Force overwrite existing files
init-doc-driven-dev --force

# Initialize with specific template
init-doc-driven-dev --template frontend

# Analyze project without creating files
init-doc-driven-dev --analyze-only
```

## Output

The command creates the following structure:

```
project-root/
├── CLAUDE.md                    # Workflow logic and links to detailed docs
├── AGENTS.md                    # AI agent capabilities and runtime rules
├── docs/
│   ├── requirements/
│   │   └── YYYYMMDD-project-initial-requirements.md
│   ├── design/
│   │   └── YYYYMMDD-project-initial-requirements-technical-design.md
│   ├── standards/
│   │   ├── coding-standards.md
│   │   └── testing-standards.md
│   └── analysis/
│       └── project-analysis.md
└── [existing project files]
```

Document naming convention:
- Requirement: `docs/requirements/YYYYMMDD-feature-name.md`
- Design: `docs/design/YYYYMMDD-feature-name-technical-design.md`
- Same-day same-name conflicts: append `-v2`, `-v3`

## Prerequisites

- Project must be in a Git repository
- Must be run from project root directory

## Related Commands

- `update-doc-driven-dev` - Update existing documentation to latest standards
- `update-standards` - Sync with marketplace plugin standards
