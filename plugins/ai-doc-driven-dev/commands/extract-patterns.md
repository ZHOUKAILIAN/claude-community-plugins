---
name: extract-patterns
description: Extract coding patterns and conventions from existing codebase
category: analysis
shortcut: "ep"
---

# Extract Patterns

Automatically extract coding patterns, conventions, and standards from your existing codebase to create comprehensive project documentation.

## Description

This command analyzes your codebase to extract and document:

1. **Naming Conventions**: Variable, function, class, and file naming patterns
2. **Architectural Patterns**: Code organization and structural patterns
3. **API Design Patterns**: Request/response formats and endpoint conventions
4. **Error Handling**: Exception handling and error response patterns
5. **Code Style**: Formatting, commenting, and documentation patterns

## Usage

```bash
claude extract-patterns [options]
```

## Options

- `--type <frontend|backend|fullstack>` - Specify project type for targeted analysis
- `--output <file>` - Save extracted patterns to specific file
- `--format <markdown|json|yaml>` - Output format for patterns documentation
- `--include <patterns>` - Comma-separated list of pattern types to include
- `--exclude <patterns>` - Comma-separated list of pattern types to exclude

## Pattern Types

- `naming` - Naming conventions for variables, functions, classes, files
- `architecture` - Code organization and structural patterns
- `api` - API design and endpoint patterns
- `error-handling` - Error handling and exception patterns
- `styling` - Code formatting and style patterns
- `testing` - Test organization and naming patterns
- `database` - Database naming and query patterns

## Examples

```bash
# Extract all patterns from codebase
claude extract-patterns

# Extract only naming and API patterns for frontend
claude extract-patterns --type frontend --include naming,api

# Save patterns to specific file in JSON format
claude extract-patterns --format json --output project-patterns.json

# Extract patterns excluding test-related patterns
claude extract-patterns --exclude testing
```

## Frontend-Specific Patterns

When analyzing frontend projects, extracts:

- **Component Patterns**: React/Vue/Angular component organization
- **State Management**: Redux/Zustand/Context usage patterns
- **Styling Patterns**: CSS-in-JS, modules, or traditional CSS usage
- **API Integration**: HTTP client usage and data transformation
- **Type Definitions**: TypeScript interface and type patterns

## Backend-Specific Patterns

When analyzing backend projects, extracts:

- **Route Patterns**: API endpoint organization and naming
- **Data Models**: Entity definitions and relationship patterns
- **Authentication**: Auth middleware and security patterns
- **Database Access**: Query patterns and ORM usage
- **Response Formats**: API response structure and error formats

## Output

Creates documentation files:

```
docs/
├── standards/
│   ├── coding-patterns.md       # Extracted coding patterns
│   ├── naming-conventions.md    # Naming convention rules
│   ├── api-patterns.md          # API design patterns (if applicable)
│   └── project-conventions.md   # Project-specific conventions
└── analysis/
    └── pattern-analysis.md      # Detailed pattern analysis
```

## Integration

Extracted patterns can be used with:

- **AI Code Generation**: Provides context for consistent code generation
- **Code Reviews**: Reference for maintaining consistency
- **Team Onboarding**: Documentation for new team members
- **Automated Linting**: Configuration for code quality tools

## Related Commands

- `analyze-docs` - Analyze documentation completeness
- `generate-docs` - Generate documentation from patterns
- `init-doc-driven-dev` - Initialize full documentation workflow