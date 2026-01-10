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

1. **CLAUDE.md Setup**: Creates or updates CLAUDE.md with mandatory documentation-first workflow
2. **Documentation Structure**: Establishes standard docs/ directory structure
3. **Project Analysis**: Analyzes current project type and existing patterns
4. **Standards Extraction**: Documents existing coding conventions and patterns
5. **Template Generation**: Creates project-specific documentation templates

## Usage

```bash
claude init-doc-driven-dev [options]
```

## Options

- `--force` - Overwrite existing documentation files
- `--template <type>` - Use specific template (frontend/backend/fullstack)
- `--minimal` - Create minimal documentation structure only
- `--analyze-only` - Only analyze project without creating files

## Examples

```bash
# Basic initialization
claude init-doc-driven-dev

# Force overwrite existing files
claude init-doc-driven-dev --force

# Initialize with specific template
claude init-doc-driven-dev --template frontend

# Analyze project without creating files
claude init-doc-driven-dev --analyze-only
```

## Output

The command creates the following structure:

```
project-root/
├── CLAUDE.md                    # Updated with doc-driven workflow
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
└── [existing project files]
```

## Prerequisites

- Project must be in a Git repository
- Must be run from project root directory

## Related Commands

- `analyze-docs` - Analyze existing documentation
- `extract-patterns` - Extract coding patterns only
- `update-standards` - Update project standards