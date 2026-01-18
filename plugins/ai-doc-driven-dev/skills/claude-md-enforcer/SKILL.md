---
name: claude-md-enforcer
description: |
  Enforce documentation-driven development workflow in CLAUDE.md files with MANDATORY docs-first process.
  Use when you need to "setup doc-driven development", "enforce documentation workflow", or "initialize project standards".
  CRITICAL: Ensures CLAUDE.md explicitly prohibits direct code implementation without prior documentation.
allowed-tools: ["Read", "Write", "Edit", "Glob"]
license: MIT
---

## Overview

This skill empowers Claude to enforce MANDATORY documentation-driven development workflows in any project. It automatically detects existing CLAUDE.md files and ensures they contain STRICT documentation-first development processes with EXPLICIT prohibitions against direct code implementation, creating a consistent development standard across all projects using Claude Code CLI.

**KEY ENFORCEMENT**: The skill MUST insert clear language that **PROHIBITS** any code implementation without prior requirements documentation and technical design approval.

## How It Works

**Note**: This skill can work with or without a full repository scan. When users skip the scan in `enforce-doc-workflow` command, this skill focuses only on CLAUDE.md enforcement without comprehensive project analysis.

Workflow steps:

1. **CLAUDE.md Detection**: Scans the project root for existing CLAUDE.md files
2. **Content Analysis**: Analyzes current content to identify missing documentation workflow sections
3. **Template Injection**: Inserts or updates documentation-driven development standards
4. **Standards Synchronization**: (Optional, if full scan was performed) Ensures CLAUDE.md reflects current project standards from docs/standards/
5. **Workflow Enforcement**: Establishes mandatory "docs-first, code-second" development process
6. **Prohibition Insertion**: Adds explicit prohibitions against direct code implementation
7. **Approval Gate Setup**: Creates mandatory documentation review and approval gates

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

### Example 4: Enforcement Enhancement

User request: "Make sure CLAUDE.md strongly enforces documentation-first development"

The skill will:
1. Insert explicit PROHIBITION statements against direct code implementation
2. Add mandatory approval gates for all development phases
3. Include clear consequences for workflow violations
4. Emphasize that ALL development MUST start with documentation
5. Add templates and examples for required documentation types

## Best Practices

- **Preserve Existing Content**: Always read existing CLAUDE.md before making changes to preserve project-specific information
- **MANDATORY ENFORCEMENT**: Use strong, unambiguous language with explicit PROHIBITIONS against direct code implementation
- **Standards Alignment**: Regularly sync CLAUDE.md with evolving project standards
- **Team Communication**: Ensure all team members understand the mandatory documentation workflow
- **Approval Gates**: Insert clear approval requirements for all development phases
- **Violation Consequences**: Include warnings about development process violations
- **Documentation Templates**: Reference required documentation templates and formats

## Integration

This skill integrates seamlessly with other documentation tools and project management systems. It leverages standard file operations for maximum compatibility and can be combined with other Claude Code skills for comprehensive project setup and maintenance.

**CRITICAL INTEGRATION**: This skill should be used FIRST in any project setup to establish the mandatory documentation-driven development foundation before any code implementation begins.