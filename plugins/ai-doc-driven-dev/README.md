# AI Documentation-Driven Development Plugin

Transform any project into a documentation-driven development workflow with AI assistance. This plugin automatically detects, generates, and maintains project documentation standards, ensuring consistent and maintainable development practices.

## Overview

The AI Documentation-Driven Development Plugin helps teams establish and maintain documentation-first development workflows. It enforces the principle that all code changes must be preceded by appropriate documentation updates, creating better maintainability and team collaboration.

## Key Features

- **🔧 Workflow Instruction Enforcement**: Ensures `CLAUDE.md` or `AGENTS.md` contains mandatory documentation-driven development workflows
- **📊 Documentation Analysis**: Assesses docs coverage, date-based naming, and requirement/design pairing
- **🎯 Pattern Extraction**: Distills dominant codebase patterns into reusable project standards
- **📝 Smart Generation**: Creates paired requirement and technical design docs from active templates

## Skills Included

### 1. doc-workflow-enforcer
Establishes the docs-first workflow entry rules in `CLAUDE.md` and `AGENTS.md`, with clear file responsibilities, approval gates, and lightweight instruction-file structure.

**Use cases:**
- Initialize documentation-driven development in new projects
- Separate workflow rules from AI behavior rules
- Repair or modernize existing instruction files

### 2. doc-detector
Analyzes whether project documentation is ready for docs-first development, with emphasis on date-based naming, requirement/design pairing, and the highest-priority gaps.

**Use cases:**
- Assess current documentation status
- Identify missing or inconsistent requirement/design pairs
- Prepare actionable next steps before implementation

### 3. pattern-extractor
Extracts dominant coding patterns, architectural conventions, and notable exceptions from the existing codebase so they can become reusable standards.

**Use cases:**
- Document existing project coding standards
- Build `docs/standards/` guidance from real code
- Ensure AI code generation follows the dominant project patterns

### 4. doc-generator
Generates paired requirement and technical design documents using the plugin's active templates and the project's current docs-first rules.

**Use cases:**
- Create missing requirement/design pairs identified by doc-detector
- Establish a reviewable docs-first baseline for new features
- Generate template-aligned documents with date-based naming

## Commands

### init-doc-driven-dev

Initialize documentation-driven development workflow in your project from scratch.

**Features:**
- **CLAUDE.md Setup**: Creates lightweight workflow and pointer-based CLAUDE.md
- **AGENTS.md Generation**: Establishes AI agent behavior rules in dedicated file
- **Documentation Structure**: Sets up standard docs/ directory hierarchy
- **Project Analysis**: Analyzes current project type and patterns
- **Standards Extraction**: Documents existing coding conventions and architecture

**Options:**
- `--force` - Overwrite existing documentation files
- `--template <type>` - Use specific template (frontend/backend/fullstack)
- `--minimal` - Create minimal documentation structure only
- `--analyze-only` - Only analyze project without creating files

**What it does:**
1. Analyzes project structure and technology stack
2. Creates CLAUDE.md (lightweight workflow + pointers)
3. Creates AGENTS.md (AI agent rules)
4. Establishes docs/ directory structure (requirements/, design/, standards/, analysis/)
5. Generates initial project analysis and coding standards

**Example workflow:**
```bash
# Basic initialization
init-doc-driven-dev

# Force overwrite existing files
init-doc-driven-dev --force

# Initialize with specific template
init-doc-driven-dev --template frontend

# Analyze project without creating files
init-doc-driven-dev --analyze-only
```

### update-doc-driven-dev

Update existing documentation to match latest skill versions and standards without destructive re-initialization.

**Features:**
- **Intelligent Merging**: Preserves user content while applying new standards
- **Decoupling Detection**: Identifies and refactors bloated CLAUDE.md
- **Content Migration**: Extracts detailed standards to appropriate docs/ files
- **Standards Sync**: Updates workflow rules and naming conventions
- **Safe Updates**: Automatic backup before modifications

**Options:**
- `--dry-run` - Preview changes without modifying files
- `--force-decouple` - Automatically extract monolithic CLAUDE.md content
- `--backup` - Create timestamped backup (default: true)
- `--skip-backup` - Skip backup creation
- `--verbose` - Show detailed merge operations

**What it does:**
1. Creates automatic backup of existing documentation
2. Analyzes current CLAUDE.md and AGENTS.md for anti-patterns
3. Detects monolithic content that should be decoupled
4. Merges latest standards with existing user content
5. Extracts detailed content to docs/standards/ if needed
6. Updates naming conventions to date-based format

**Example workflow:**
```bash
# Update with preview
update-doc-driven-dev --dry-run

# Update and automatically decouple bloated CLAUDE.md
update-doc-driven-dev --force-decouple

# Update without backup (not recommended)
update-doc-driven-dev --skip-backup
```

**When to use:**
- After updating ai-doc-driven-dev plugin to newer version
- When CLAUDE.md has become bloated with detailed standards
- To separate mixed AI rules into AGENTS.md
- To adopt latest documentation conventions
- When skill prompts have been improved (version A → B)

**Complete upgrade workflow:**
```bash
# Step 1: Update structure (this command)
update-doc-driven-dev

# Step 2: Sync content standards (separate command)
update-standards
```

### update-standards

Sync documentation content with latest templates and standards.

**Features:**
- **Template Compliance Check**: Detect if existing docs match latest templates
- **New Principles Detection**: Identify missing sections or updated requirements
- **Full Docs Coverage**: Check all `docs/**/*.md` files
- **Instruction File Review**: Verify CLAUDE.md/AGENTS.md has latest workflow rules

**What it does:**
1. Compare local docs against plugin's latest templates
2. Highlight missing sections (e.g., new "Performance Considerations" requirement)
3. Detect outdated principles (e.g., missing Visual-First diagrams)
4. Propose content updates for user approval
5. Apply approved changes across all documentation

**Example workflow:**
```bash
# Check and sync all documentation standards
update-standards
```

**Use case example:**
- You updated `technical-design-template.md` to require a "Security Considerations" section
- Run `update-standards` to detect which existing design docs are missing this section
- Review and approve adding the section to old documents

## Getting Started

### For New Projects
1. **Install the Plugin**: Add this plugin to your Claude Code environment
2. **Initialize Workflow**: Run `init-doc-driven-dev` to set up documentation infrastructure
3. **Review Generated Docs**: Check CLAUDE.md, AGENTS.md, and docs/ structure
4. **Customize Standards**: Adapt generated standards to your project needs
5. **Start Development**: Follow the documentation-first workflow

### For Existing Projects
1. **Install the Plugin**: Add this plugin to your Claude Code environment
2. **Update Infrastructure**: Run `update-doc-driven-dev` to modernize existing docs
3. **Review Changes**: Check the migration report and verify content preserved
4. **Refine Setup**: Adjust any extracted standards files as needed
5. **Continue Development**: Enjoy improved lightweight documentation structure

## Documentation Structure

The plugin establishes and maintains this standard documentation structure:

```
docs/
├── requirements/     # Project requirements and specifications
├── design/          # Technical design and architecture
├── analysis/        # Project and codebase analysis
├── standards/       # Coding standards and conventions
└── [custom]/        # Project-specific documentation
```

## Workflow Integration

This plugin integrates seamlessly with existing development workflows:

1. **Before Code Changes**: Update relevant documentation in docs/
2. **AI Development**: Claude Code CLI reads docs/ for context and constraints
3. **Code Implementation**: Implement changes based on documented requirements and standards
4. **Review Process**: Ensure code matches documented specifications

## Best Practices

- **Start with Instruction Files**: Always run doc-workflow-enforcer first to establish lightweight workflow entry rules in `CLAUDE.md` and AI behavior rules in `AGENTS.md`
- **Regular Analysis**: Periodically run doc-detector to catch missing pairs, naming drift, and incomplete docs
- **Pattern Updates**: Re-run pattern-extractor when major architectural or convention changes land
- **Template Customization**: Adapt generated documentation templates to project-specific needs without breaking pairing and naming rules

## Benefits

- **Consistency**: Ensures all team members follow the same development standards
- **Maintainability**: Creates comprehensive documentation for long-term project maintenance
- **AI Effectiveness**: Provides rich context for more accurate AI-assisted development
- **Team Onboarding**: Simplifies new team member integration with clear documentation

## License

MIT License - see LICENSE file for details.

## Contributing

Contributions are welcome! Please read the contributing guidelines and follow the established documentation-driven development workflow.

---

**[中文版本](README-zh.md) | [English Version](README.md)**
