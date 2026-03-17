# Documentation Templates

This directory contains templates used by the ai-doc-driven-dev plugin.

## Instruction File Templates

### claude-md-template.md
Template for generating `CLAUDE.md` in target projects.

**Purpose**: Defines the documentation-driven workflow and project structure.

**Language**: English

**Content Focus**:
- Development workflow rules
- Document naming conventions
- Visual-First documentation principles
- Links to detailed standards in `docs/` directory

**Used By**:
- `init-doc-driven-dev` command (initial setup)
- `update-doc-driven-dev` command (updating existing files)
- `doc-flow-initializer` agent
- `doc-flow-updater` agent

### agents-md-template.md
Template for generating `AGENTS.md` in target projects.

**Purpose**: Defines mandatory AI workflow process and documentation standards.

**Language**: English

**Content Focus**:
- Step-by-step AI workflow (documentation → implementation)
- Documentation standards (naming, visual-first, templates)
- Prohibited actions (no code before docs)
- Reference links to project standards

**Used By**:
- `init-doc-driven-dev` command (initial setup)
- `update-doc-driven-dev` command (updating existing files)
- `doc-flow-initializer` agent
- `doc-flow-updater` agent

## Design Principles

Both templates follow these principles:

1. **English Only**: All content in English for consistency
2. **Direct Instructions**: No explanations about "AI-human collaboration" - just the workflow
3. **Process-Oriented**: Clear step-by-step rules, not guidelines
4. **Lightweight**: Link to detailed docs instead of embedding content
5. **Separation of Concerns**: CLAUDE.md for workflow, AGENTS.md for AI rules

## Requirement Document Templates

### YYYYMMDD-feature-name.md
Template for creating requirement documents in target projects.

**Location in Target Project**: `docs/requirements/`

**Used By**:
- `init-doc-driven-dev` command (creates initial requirements)
- Referenced in `AGENTS.md` as standard template

### YYYYMMDD-feature-name-technical-design.md
Template for creating technical design documents in target projects.

**Location in Target Project**: `docs/design/`

**Used By**:
- `init-doc-driven-dev` command (creates initial design)
- Referenced in `AGENTS.md` as standard template

## Usage in Commands

When commands generate instruction files, they:

1. Read the appropriate template from this directory
2. Optionally inject project-specific content
3. Write the result to the target project's root directory
4. Ensure all links in templates resolve to actual files in `docs/`

## Template Updates

When updating these templates:

1. Maintain English language throughout
2. Keep instructions direct and process-oriented
3. Update both `init-doc-driven-dev` and `update-doc-driven-dev` if workflow changes
4. Test with both new projects (init) and existing projects (update)
5. Ensure links reference standard doc locations
