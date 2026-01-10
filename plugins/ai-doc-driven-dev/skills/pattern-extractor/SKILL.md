---
name: pattern-extractor
description: |
  Extract project-specific coding patterns, conventions, and standards from existing codebase.
  Use when you need to "analyze code patterns", "extract coding conventions", or "document project standards".
allowed-tools: ["Read", "Glob", "Grep", "LSP"]
license: MIT
---

## Overview

This skill empowers Claude to automatically analyze existing codebases and extract project-specific coding patterns, naming conventions, architectural decisions, and development standards. It creates comprehensive documentation of how the project actually works, enabling consistent AI-assisted development that follows established patterns.

## How It Works

1. **Codebase Scanning**: Systematically analyzes project files to understand structure and patterns
2. **Pattern Recognition**: Identifies common naming conventions, architectural patterns, and coding styles
3. **Framework Detection**: Recognizes frontend/backend frameworks and their specific usage patterns
4. **Convention Extraction**: Documents API design patterns, data modeling approaches, and error handling
5. **Standards Documentation**: Generates comprehensive project-specific coding standards and guidelines

## When to Use This Skill

This skill activates when you need to:
- Document existing project coding standards and conventions
- Extract patterns from legacy or undocumented codebases
- Create project-specific development guidelines for new team members
- Ensure AI code generation follows established project patterns
- Analyze and document architectural decisions and design patterns

## Examples

### Example 1: Frontend Project Analysis

User request: "Extract our React project's coding patterns and conventions"

The skill will:
1. Analyze component structure, naming patterns, and file organization
2. Extract TypeScript interface patterns, Props naming, and State management approaches
3. Document API calling conventions, error handling patterns, and data transformation methods
4. Identify styling approaches (CSS-in-JS, modules) and theme management patterns
5. Generate comprehensive frontend development standards document

### Example 2: Backend API Standards Extraction

User request: "Document our Express.js API coding standards and patterns"

The skill will:
1. Analyze route definition patterns, parameter validation approaches, and response formats
2. Extract data model patterns, field naming conventions, and relationship mapping
3. Document error handling strategies, logging patterns, and authentication methods
4. Identify database interaction patterns and transaction management approaches
5. Create detailed backend development conventions documentation

### Example 3: Full-Stack Project Documentation

User request: "Create comprehensive coding standards for our full-stack application"

The skill will:
1. Analyze both frontend and backend codebases for consistent patterns
2. Extract cross-cutting concerns like API communication patterns and data flow
3. Document shared naming conventions and architectural decisions
4. Identify integration patterns between frontend and backend components
5. Generate unified project development standards covering all aspects

## Best Practices

- **Pattern Frequency Analysis**: Prioritizes most commonly used patterns over one-off implementations
- **Context-Aware Extraction**: Considers project type and framework-specific best practices
- **Comprehensive Coverage**: Analyzes naming, structure, error handling, and architectural patterns
- **Documentation Standards**: Generates clear, actionable standards that can guide future development

## Integration

This skill integrates with LSP servers for deep code analysis and works seamlessly with documentation generation tools. It provides the foundation for creating project-specific AI development guidelines and ensures consistency across team development efforts.