---
description: Update existing documentation to match latest skill versions and standards
category: maintenance
shortcut: "udd"
model: inherit
---

# Update Documentation-Driven Development

Update your project's documentation infrastructure to align with the latest skill versions and standards without destructive re-initialization.

## Description

This command intelligently updates existing documentation-driven development setup by:

1. **Reading Current State**: Scans existing CLAUDE.md, AGENTS.md, and docs/ structure
2. **Extracting Context**: Preserves user-customized content and project-specific information
3. **Applying New Rules**: Merges latest skill version requirements with existing content
4. **Intelligent Merging**: Combines old valuable context with new structural standards
5. **Decoupling Check**: Detects monolithic CLAUDE.md patterns and suggests refactoring
6. **Standards Sync**: Updates workflow rules, naming conventions, and best practices

**Key Difference from init**: This command preserves your existing content and customizations while upgrading the documentation infrastructure. It's designed for projects that already have documentation but need to adopt newer standards or fix structural issues.

## When to Use This Command

- After updating the ai-doc-driven-dev plugin to a newer version
- When skill prompts or standards have been improved (version A → version B)
- To refactor a bloated CLAUDE.md into a lightweight pointer-based structure
- To separate mixed AI rules from CLAUDE.md into AGENTS.md
- To adopt new documentation conventions without losing existing content
- When you want to apply latest best practices to an existing setup

## Options

- `--dry-run` - Preview changes without modifying files
- `--force-decouple` - Automatically extract monolithic CLAUDE.md content to docs/
- `--backup` - Create timestamped backup before updating (default: true)
- `--skip-backup` - Skip backup creation
- `--verbose` - Show detailed merge and update operations

## Examples

```bash
# Update with preview
update-doc-driven-dev --dry-run

# Update and automatically decouple bloated CLAUDE.md
update-doc-driven-dev --force-decouple

# Update without backup (not recommended)
update-doc-driven-dev --skip-backup

# Detailed update with verbose output
update-doc-driven-dev --verbose
```

## Update Process

The command follows this workflow:

```
1. Backup Phase
   ├─ Create .backup-YYYYMMDD-HHMMSS/ directory
   └─ Copy CLAUDE.md, AGENTS.md, docs/ to backup

2. Analysis Phase
   ├─ Read current CLAUDE.md and AGENTS.md
   ├─ Detect monolithic anti-patterns
   ├─ Identify outdated conventions
   └─ Extract user customizations

3. Merge Phase
   ├─ Apply latest skill version rules
   ├─ Preserve user-specific content
   ├─ Suggest decoupling if needed
   └─ Update naming conventions

4. Write Phase
   ├─ Update CLAUDE.md (lightweight + pointers)
   ├─ Update or create AGENTS.md (AI rules)
   ├─ Extract detailed content to docs/standards/ if needed
   └─ Verify file integrity

5. Report Phase
   └─ Show summary of changes made
```

## Output

The command produces:

```
project-root/
├── .backup-YYYYMMDD-HHMMSS/      # Automatic backup (unless skipped)
│   ├── CLAUDE.md
│   ├── AGENTS.md
│   └── docs/
├── CLAUDE.md                      # Updated with latest standards (lightweight)
├── AGENTS.md                      # Updated or created with AI rules
├── docs/
│   ├── requirements/              # Preserved existing docs
│   ├── design/                    # Preserved existing docs
│   ├── standards/
│   │   ├── coding-standards.md   # Extracted from CLAUDE.md if bloated
│   │   └── architecture.md       # Extracted from CLAUDE.md if bloated
│   └── analysis/
└── [existing project files]
```

## Safety Features

- **Automatic Backup**: Creates timestamped backup before any modifications
- **Content Preservation**: Never deletes user content, only restructures
- **Dry-Run Mode**: Preview all changes before applying
- **Merge Logic**: Intelligently combines old and new content
- **Rollback Instructions**: Provides clear rollback steps if needed

## Prerequisites

- Project must already have some form of CLAUDE.md or AGENTS.md
- Must be run from project root directory
- Recommended: Commit your changes before running update

## Troubleshooting

**"No existing documentation found"**
- Use `init-doc-driven-dev` instead for first-time setup

**"Backup directory already exists"**
- Previous backup found, will append timestamp to avoid conflicts

**"Dry-run mode - no files modified"**
- Review the proposed changes and run without `--dry-run` to apply

## Complete Update Workflow

For a full documentation infrastructure upgrade, run both commands in sequence:

### Two-Step Update Process

**Step 1: Update Infrastructure** (this command)
```bash
update-doc-driven-dev
```
- Upgrades CLAUDE.md and AGENTS.md structure
- Refactors monolithic patterns
- Updates naming conventions to date-based format
- Migrates content to proper locations

**Step 2: Sync Content Standards** (separate command)
```bash
update-standards
```
- Checks all docs/ files against latest templates
- Applies Visual-First principles to existing documents
- Updates requirement/design docs to match new standards
- Detects missing sections in existing docs

### Why Two Steps?

- **Structural updates** (file organization, naming) vs **Content updates** (template compliance, new principles)
- Running `update-doc-driven-dev` alone updates the "skeleton"
- Running `update-standards` after ensures the "content" matches latest standards
- **Recommended**: Run both after plugin version upgrades

### Example: Template Evolution Case

**Scenario**: You updated `docs/standards/technical-design-template.md` to require a new "Performance Considerations" section.

**What happens**:
1. `update-doc-driven-dev` - Won't detect this (it focuses on structure)
2. `update-standards` - **Will detect** that existing `docs/design/*.md` files are missing the new section and suggest adding it

## Related Commands

- `init-doc-driven-dev` - Initial setup (use this first if no docs exist)
- `update-standards` - Sync docs content with latest templates and standards (run after this command)

## Migration Example

**Before update** (Version A - Monolithic CLAUDE.md):
```
project-root/
├── CLAUDE.md (500+ lines with inline coding standards, architecture details)
└── docs/requirements/
```

**After update** (Version B - Decoupled structure):
```
project-root/
├── CLAUDE.md (50 lines, workflow + pointers)
├── AGENTS.md (AI rules extracted)
├── docs/
│   ├── requirements/
│   ├── standards/
│   │   ├── coding-standards.md (extracted from CLAUDE.md)
│   │   └── architecture.md (extracted from CLAUDE.md)
└── [All original content preserved and reorganized]
```
