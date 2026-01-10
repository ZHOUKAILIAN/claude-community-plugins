---
name: doc-generator
description: |
  Generate standardized project documentation based on templates and project analysis.
  Use when you need to "generate project docs", "create documentation", or "setup project documentation structure".
allowed-tools: ["Read", "Write", "Glob", "Grep", "Bash"]
license: MIT
---

## Overview

This skill empowers Claude to generate comprehensive, standardized project documentation using intelligent templates and project analysis. It creates consistent documentation structures that support documentation-driven development workflows, ensuring all projects have the necessary foundation for effective AI-assisted development.

## How It Works

1. **Template Selection**: Chooses appropriate documentation templates based on project type and requirements
2. **Project Analysis Integration**: Uses extracted patterns and project characteristics to populate templates
3. **Intelligent Content Generation**: Creates project-specific content while maintaining standardized structure
4. **Documentation Structure Creation**: Establishes complete docs/ directory hierarchy with proper organization
5. **Metadata Management**: Adds appropriate frontmatter and version information to all generated documents

## When to Use This Skill

This skill activates when you need to:
- Generate missing documentation identified by doc-detector
- Create standardized documentation structure for new projects
- Update existing documentation to follow current standards
- Establish comprehensive documentation foundation for documentation-driven development
- Create project-specific documentation based on extracted patterns

## Examples

### Example 1: Complete Documentation Setup

User request: "Generate complete documentation structure for our React TypeScript project"

The skill will:
1. Create docs/ directory with requirements/, design/, standards/, and analysis/ subdirectories
2. Generate project-specific requirements documentation based on existing code analysis
3. Create technical design documents reflecting current architecture and patterns
4. Produce coding standards documentation based on extracted project conventions
5. Add appropriate frontmatter and metadata to all generated documents

### Example 2: Missing Documentation Generation

User request: "Create the technical design document for our Express API project"

The skill will:
1. Analyze existing codebase to understand API architecture and patterns
2. Select appropriate technical design template for backend projects
3. Populate template with project-specific API endpoints, data models, and patterns
4. Generate comprehensive technical design document with proper structure and metadata
5. Integrate with existing documentation structure and maintain consistency

### Example 3: Standards Documentation Creation

User request: "Generate coding standards document based on our current codebase patterns"

The skill will:
1. Use pattern-extractor results to understand project-specific conventions
2. Create comprehensive coding standards document covering naming, structure, and patterns
3. Include specific examples from the codebase to illustrate standards
4. Generate best practices and guidelines for maintaining consistency
5. Format document according to project documentation standards

## Best Practices

- **Template-Based Consistency**: Uses standardized templates while allowing project-specific customization
- **Content Quality**: Generates meaningful, actionable content rather than generic placeholder text
- **Integration Awareness**: Ensures generated documentation integrates well with existing project structure
- **Version Management**: Includes proper metadata and versioning information in all generated documents

## Integration

This skill integrates with template systems and project analysis tools to create comprehensive documentation. It works seamlessly with other documentation skills and supports various project types and frameworks for maximum flexibility and usefulness.