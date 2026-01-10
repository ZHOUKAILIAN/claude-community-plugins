---
name: doc-detector
description: |
  Detect and analyze project documentation completeness for documentation-driven development.
  Use when you need to "analyze project documentation", "check doc completeness", or "assess documentation status".
allowed-tools: ["Read", "Glob", "Grep"]
license: MIT
---

## Overview

This skill empowers Claude to comprehensively analyze project documentation structure and completeness. It identifies existing documentation, detects missing critical documents, and provides recommendations for establishing a complete documentation-driven development workflow.

## How It Works

1. **Directory Scanning**: Systematically scans docs/ directory structure for existing documentation
2. **Core Document Detection**: Identifies presence of essential documents (requirements, technical designs)
3. **Project Type Analysis**: Determines project type (frontend/backend/fullstack) to tailor recommendations
4. **Gap Analysis**: Compares current documentation against documentation-driven development standards
5. **User Consultation**: Asks users about missing documentation rather than auto-generating

## When to Use This Skill

This skill activates when you need to:
- Assess current documentation completeness in a project
- Identify missing critical documents for documentation-driven development
- Understand project documentation structure before making changes
- Get recommendations for documentation improvements
- Prepare for documentation generation or updates

## Examples

### Example 1: New Project Assessment

User request: "Analyze our project's documentation status"

The skill will:
1. Scan the entire docs/ directory structure
2. Identify existing documentation by category (requirements, design, standards)
3. Check for core documents needed for documentation-driven development
4. Report current status and recommend missing documentation types
5. Ask user which missing documents they'd like to generate

### Example 2: Documentation-Driven Readiness Check

User request: "Check if our project is ready for documentation-driven development"

The skill will:
1. Verify presence of essential documents (requirements and technical design)
2. Analyze CLAUDE.md for documentation workflow enforcement
3. Check docs/standards/ for project-specific standards
4. Provide readiness score and specific recommendations for improvements

### Example 3: Pre-Development Analysis

User request: "What documentation do we need before starting development?"

The skill will:
1. Analyze project type and scope based on existing code and configuration
2. Recommend essential documentation based on project characteristics
3. Suggest documentation priorities (must-have vs. nice-to-have)
4. Provide specific templates and examples for missing document types

## Best Practices

- **Non-Intrusive Analysis**: Only reads and analyzes, never automatically creates documentation
- **User-Driven Decisions**: Always asks users about generating missing documentation
- **Flexible Standards**: Adapts recommendations based on project type and existing structure
- **Clear Reporting**: Provides actionable insights about documentation gaps and improvements

## Integration

This skill integrates with documentation generation tools and project analysis systems. It serves as a foundation for other documentation-related skills by providing comprehensive project documentation assessment capabilities.