# AI Agent Workflow Rules

## Mandatory Development Process

**Follow this workflow strictly for all code changes:**

### Step 1: Documentation Phase
1. Create/update requirement document: `docs/requirements/YYYYMMDD-feature-name.md`
2. Create/update technical design: `docs/design/YYYYMMDD-feature-name-technical-design.md`
3. Wait for user approval of documentation

### Step 2: Implementation Phase
1. Read approved documentation from `docs/` directory
2. Implement code following documented design
3. Ensure implementation matches technical specifications

### Step 3: Verification Phase
1. Verify code aligns with documentation
2. Update documentation if implementation differs
3. Maintain sync between docs and code

## Documentation Standards

### Naming Convention
- Use date-based naming: `YYYYMMDD-feature-name.md`
- Use current date directly (no sequence scanning)
- Handle same-day conflicts with `-v2`, `-v3` suffixes

### Visual-First Principle
- **REQUIRED**: Use Mermaid diagrams for system architecture, data flows, state transitions
- **REQUIRED**: Use Markdown tables for data structures, API parameters, configurations
- **REQUIRED**: Show modifications inline (strikethrough, color, annotations) - no "Before/After" sections

### Document Templates
- Follow templates in `docs/standards/requirements-template.md`
- Follow templates in `docs/standards/technical-design-template.md`

## Prohibited Actions

- ❌ Writing code before creating/updating documentation
- ❌ Skipping documentation approval step
- ❌ Creating documentation without user alignment
- ❌ Using text descriptions where diagrams/tables are required

## Reference Documents

For detailed standards and guidelines:
- [Requirements Template](docs/standards/requirements-template.md)
- [Technical Design Template](docs/standards/technical-design-template.md)
- [Coding Standards](docs/standards/coding-standards.md)
- [Project Analysis](docs/analysis/project-analysis.md)

---

*These rules ensure all AI-generated code follows project standards and documentation.*
