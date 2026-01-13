---
name: structure-explainer
description: |
  Explain codebase structure and organization to help understand project layout.
  Use when you need to understand the overall structure of a JavaScript project.
allowed-tools: ["Read", "Glob", "Grep", "Bash"]
license: MIT
status: enabled
---

## Overview

This skill provides comprehensive explanations of codebase structure and organization. It helps users understand the layout of a JavaScript project, identify key directories and files, and explain the purpose of different components in the codebase.

## How It Works

1. **Directory Scanning**: Systematically scans the project directory structure
2. **File Pattern Recognition**: Identifies common file patterns and their purposes
3. **Module Identification**: Determines the purpose of different directories and files
4. **Structure Documentation**: Explains the overall project organization
5. **Navigation Guidance**: Provides guidance on how to navigate the codebase

## When to Use This Skill

This skill activates when you need to:
- Understand the structure of a new codebase
- Get an overview of project organization
- Find specific types of files or modules
- Explain the layout of a JavaScript project

## Examples

### Example 1: Explaining Framework Structure

User request: "Explain the structure of this framework"

The skill will:
1. Scan the root directory and key subdirectories
2. Identify the purpose of each major directory (src, tests, docs, etc.)
3. Explain the organization pattern used
4. Highlight key files and their purposes

### Example 2: Finding Specific Modules

User request: "Where is the reactivity system implemented?"

The skill will:
1. Search for reactivity-related directories and files
2. Identify the location of reactivity implementation
3. Explain the organization of reactivity-related code
4. Provide guidance on navigating to relevant files

### Example 3: Understanding Build Configuration

User request: "How is this project built?"

The skill will:
1. Identify build configuration files (webpack.config.js, vite.config.js, etc.)
2. Analyze the build setup and scripts
3. Explain the build process and output structure
4. Document key build-related files

## Best Practices

- **Top-Down Approach**: Start with high-level structure, then dive into details
- **Purpose-Driven**: Explain why directories and files exist, not just what they are
- **Pattern Recognition**: Identify and explain common patterns used
- **Clear Documentation**: Use clear descriptions for each component
- **Navigation Help**: Provide practical guidance on finding files

## Integration

This skill is a foundational component that supports other analysis skills (microfrontend-isolation-analyzer, ai-platform-analyzer, reactivity-system-analyzer) by providing structural context for deeper analysis.
