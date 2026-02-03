---
name: doc-detector
description: This skill should be used when the user asks to "analyze project documentation",
"check doc completeness", "assess documentation status", or discusses "documentation quality".
allowed-tools: ["Read", "Glob", "Grep"]
license: MIT
---

# Documentation Detector

## Overview

Analyze project documentation completeness and quality for documentation-driven development.

## When This Skill Applies

- User requests to assess documentation completeness
- User wants to check documentation quality
- User needs to identify missing critical documents
- Pre-development documentation readiness check required

## Workflow

### Phase 1: Discovery

**Goal**: Find and categorize all documentation

**Actions**:
1. Scan docs/ directory structure
2. Identify documentation types
3. List existing files

---

### Phase 2: Numbering Analysis

**Goal**: Verify numbering system integrity

**Actions**:
1. Check sequence (001, 002, 003...)
2. Detect conflicts and gaps
3. Verify pairing (REQ ↔ DESIGN)
4. Check filename-title consistency

**Critical**: Report any numbering issues immediately.

---

### Phase 3: Quality Assessment

**Goal**: Evaluate documentation quality

**Actions**:
1. Score each document (A-F)
2. Check section completeness
3. Assess content quality

**Scoring System**:
- **A (90-100)**: Comprehensive, current
- **B (70-89)**: Good coverage
- **C (50-69)**: Basic info
- **D (30-49)**: Sparse
- **F (0-29)**: Inadequate

---

### Phase 4: Report Generation

**Goal**: Present findings to user

**Actions**:
1. Summarize status
2. List critical issues
3. Provide recommendations
4. **WAIT for user decision**

---

## Output Format

```markdown
# Documentation Analysis Report

## Summary
- Total Documents: 8
- Average Score: 87/100 (Grade B)
- Critical Issues: 1

## Numbering Status
✅ Sequential: 001-008
⚠️  Missing Pairs: REQ-005 lacks DESIGN-005

## Quality Scores
| Document | Score | Grade |
|----------|-------|-------|
| REQ-001  | 95    | A     |
| REQ-002  | 87    | B     |

## Recommendations
1. [ ] Create DESIGN-005
2. [ ] Update REQ-002
```

## Best Practices

- Non-intrusive analysis (read-only)
- Always ask before generating documents
- Provide actionable insights
- Focus on critical gaps first
