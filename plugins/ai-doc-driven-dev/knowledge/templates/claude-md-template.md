# Project Documentation

This project follows a documentation-driven development workflow.

## Development Workflow

**CRITICAL**: All code changes MUST follow this sequence:

1. **Update Requirements**: Create or update docs in `docs/requirements/YYYYMMDD-feature-name.md`
2. **Update Technical Design**: Create or update docs in `docs/design/YYYYMMDD-feature-name-technical-design.md`
3. **Implement Code**: Write code based on approved documentation

## Document Naming Convention

- Requirements: `docs/requirements/YYYYMMDD-feature-name.md`
- Technical Design: `docs/design/YYYYMMDD-feature-name-technical-design.md`
- Same-day conflicts: append `-v2`, `-v3`

## Visual-First Documentation

- Use Mermaid diagrams for architecture, data flows, and state transitions
- Use Markdown tables for data structures, API parameters, and configurations
- Show modifications inline within diagrams/tables (strikethrough, color, annotations)

## Documentation Structure

```
docs/
├── requirements/     # Feature requirements and user stories
├── design/          # Technical designs and architecture
├── standards/       # Coding standards and conventions
└── analysis/        # Project analysis and patterns
```

## Standards and Conventions

For detailed project standards, see:
- [Coding Standards](docs/standards/coding-standards.md)
- [Testing Standards](docs/standards/testing-standards.md)
- [Architecture Overview](docs/standards/architecture.md)

---

*Documentation-driven workflow ensures consistency and maintainability across all changes.*
