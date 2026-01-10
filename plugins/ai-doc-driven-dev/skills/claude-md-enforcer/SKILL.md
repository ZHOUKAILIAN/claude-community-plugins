---
name: claude-md-enforcer
description: |
  Enforce documentation-driven development workflow in CLAUDE.md files.
  Use when you need to "setup doc-driven development", "enforce documentation workflow", or "initialize project standards".
allowed-tools: ["Read", "Write", "Edit", "Glob"]
license: MIT
---

## Overview

This skill empowers Claude to enforce documentation-driven development workflows in any project. It automatically detects existing CLAUDE.md files and ensures they contain mandatory documentation-first development processes, creating a consistent development standard across all projects using Claude Code CLI.

## How It Works

1. **CLAUDE.md Detection**: Scans the project root for existing CLAUDE.md files
2. **Content Analysis**: Analyzes current content to identify missing documentation workflow sections
3. **Template Injection**: Inserts or updates documentation-driven development standards
4. **Standards Synchronization**: Ensures CLAUDE.md reflects current project standards from docs/standards/
5. **Workflow Enforcement**: Establishes mandatory "docs-first, code-second" development process

## When to Use This Skill

This skill activates when you need to:
- Initialize documentation-driven development in a new project
- Enforce consistent development workflows across team projects
- Update CLAUDE.md when project standards change
- Ensure all Claude Code CLI users follow documentation-first practices
- Synchronize CLAUDE.md with evolving project standards

## Examples

### Example 1: New Project Setup

User request: "Setup this project for documentation-driven development"

The skill will:
1. Check if CLAUDE.md exists in the project root
2. Create a new CLAUDE.md with complete documentation-driven workflow if missing
3. Insert mandatory development process sections emphasizing docs-first approach
4. Add clear violations warnings and enforcement statements

### Example 2: Existing Project Enhancement

User request: "Update our CLAUDE.md to enforce documentation standards"

The skill will:
1. Read existing CLAUDE.md content to preserve project-specific information
2. Identify missing documentation workflow sections
3. Insert documentation-driven development requirements at appropriate locations
4. Update any outdated workflow descriptions to match current standards

### Example 3: Standards Synchronization

User request: "Sync CLAUDE.md with our updated project standards"

The skill will:
1. Scan docs/standards/ directory for updated templates and conventions
2. Compare current CLAUDE.md content with latest standards
3. Update relevant sections to reflect new standards
4. Maintain consistency between project standards and CLAUDE.md directives

## Best Practices

- **Preserve Existing Content**: Always read existing CLAUDE.md before making changes to preserve project-specific information
- **Clear Enforcement**: Use strong, unambiguous language to enforce documentation-first workflow
- **Standards Alignment**: Regularly sync CLAUDE.md with evolving project standards
- **Team Communication**: Ensure all team members understand the mandatory documentation workflow

## Integration

This skill integrates seamlessly with other documentation tools and project management systems. It leverages standard file operations for maximum compatibility and can be combined with other Claude Code skills for comprehensive project setup and maintenance.