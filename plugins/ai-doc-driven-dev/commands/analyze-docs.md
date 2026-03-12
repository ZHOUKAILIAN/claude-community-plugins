---
description: Comprehensive analysis of project documentation completeness and quality
category: analysis
shortcut: "ad"
model: inherit
---

# Analyze Documentation

Perform comprehensive analysis of project documentation to identify gaps, quality issues, and improvement opportunities.

## Description

This command provides detailed analysis of your project's documentation by:

1. **Completeness Assessment**: Evaluates presence of essential documentation types
2. **Quality Analysis**: Assesses documentation clarity, accuracy, and usefulness
3. **Gap Identification**: Identifies missing critical documents and outdated information
4. **Compliance Check**: Verifies adherence to documentation-driven development standards
5. **Naming Convention Audit**: Validates date-based filename and document ID consistency
6. **Improvement Recommendations**: Provides prioritized suggestions for enhancement

## Options

- `--detailed` - Generate detailed analysis report
- `--format <type>` - Output format (markdown/json/html)
- `--save <file>` - Save analysis report to file
- `--focus <area>` - Focus on specific area (requirements/design/standards/all)

## Examples

```bash
# Basic documentation analysis
analyze-docs

# Detailed analysis with HTML report
analyze-docs --detailed --format html --save analysis-report.html

# Focus on requirements documentation only
analyze-docs --focus requirements

# Generate JSON output for integration
analyze-docs --format json --save docs-analysis.json
```

## Analysis Areas

### 📋 Requirements Documentation
- Functional requirements completeness
- Non-functional requirements coverage
- User stories and acceptance criteria
- Requirements traceability

### 🏗️ Technical Design
- Architecture documentation accuracy
- API documentation completeness
- Database design documentation
- System integration details

### 📏 Standards & Conventions
- Coding standards documentation
- Project conventions consistency
- Development workflow documentation
- Code review guidelines

### 🏷️ Naming Convention Compliance
- Detect legacy `NNN-feature-name.md` and `NNN-feature-name-technical-design.md` files
- Validate date-based format: `YYYYMMDD-feature-name*.md`
- Verify in-document IDs match filename prefix (`REQ-YYYYMMDD`, `TECH-YYYYMMDD`)
- Detect same-day same-name conflicts and suggest `-v2`, `-v3` suffixes

### 🔍 Code Documentation
- Inline code comments quality
- API documentation coverage
- Function/method documentation
- Configuration documentation

## Output Format

The analysis report includes:

- **Executive Summary**: High-level findings and recommendations
- **Completeness Score**: Percentage of expected documentation present
- **Quality Assessment**: Documentation quality ratings by category
- **Gap Analysis**: Detailed list of missing or inadequate documentation
- **Naming Compliance**: Date-format adoption status and legacy filename findings
- **Action Items**: Prioritized recommendations with effort estimates

## Related Commands

- `init-doc-driven-dev` - Initialize documentation structure
- `extract-patterns` - Extract coding patterns from codebase
- `generate-docs` - Generate missing documentation
