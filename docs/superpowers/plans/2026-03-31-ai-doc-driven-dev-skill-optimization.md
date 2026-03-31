# AI-Doc-Driven-Dev Skill Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Align three ai-doc-driven-dev skills and the plugin README pair with the current date-based documentation standard and a more goal-oriented writing style.

**Architecture:** Rewrite the three target `SKILL.md` files first so they share the same naming rule, output expectations, and level of abstraction. Then update the plugin README pair so their summaries reflect the rewritten skill behavior instead of legacy numbering-oriented or workflow-heavy language.

**Tech Stack:** Markdown, repository skill conventions, `docs/standards/*`, plugin README files

---

### Task 1: Establish Baseline Drift

**Files:**
- Modify: `plugins/ai-doc-driven-dev/skills/doc-detector/SKILL.md`
- Modify: `plugins/ai-doc-driven-dev/skills/doc-generator/SKILL.md`
- Modify: `plugins/ai-doc-driven-dev/skills/pattern-extractor/SKILL.md`
- Modify: `plugins/ai-doc-driven-dev/README.md`
- Modify: `plugins/ai-doc-driven-dev/README-zh.md`
- Test: drift scan via `rg`

- [ ] **Step 1: Confirm stale numbering language exists**

```bash
rg -n "001|002|REQ-005|DESIGN-005|analyze-docs|extract-patterns" \
  plugins/ai-doc-driven-dev/skills/doc-detector/SKILL.md \
  plugins/ai-doc-driven-dev/skills/doc-generator/SKILL.md \
  plugins/ai-doc-driven-dev/skills/pattern-extractor/SKILL.md \
  plugins/ai-doc-driven-dev/README.md \
  plugins/ai-doc-driven-dev/README-zh.md
```

Expected: matches in the current files, proving stale numbering semantics and old summaries are still present.

### Task 2: Rewrite the Three Skills

**Files:**
- Modify: `plugins/ai-doc-driven-dev/skills/doc-detector/SKILL.md`
- Modify: `plugins/ai-doc-driven-dev/skills/doc-generator/SKILL.md`
- Modify: `plugins/ai-doc-driven-dev/skills/pattern-extractor/SKILL.md`

- [ ] **Step 1: Rewrite `doc-detector`**

```markdown
- Replace sequence-number defaults with date-based document checks.
- Keep the focus on coverage, pairing, and actionable gaps.
- Remove mandatory A-F scoring and legacy `REQ-005` / `DESIGN-005` examples.
```

- [ ] **Step 2: Rewrite `doc-generator`**

```markdown
- Keep current date-based naming.
- Emphasize templates, output targets, pairing, and success criteria.
- Remove overly mechanical instruction wording where the AI can infer execution.
```

- [ ] **Step 3: Rewrite `pattern-extractor`**

```markdown
- Focus on extracting dominant patterns into `docs/standards/`.
- Keep LSP as an available capability, not the center of the skill.
- Make the output read like a standards document, not a tooling tutorial.
```

### Task 3: Sync Plugin README Summaries

**Files:**
- Modify: `plugins/ai-doc-driven-dev/README.md`
- Modify: `plugins/ai-doc-driven-dev/README-zh.md`

- [ ] **Step 1: Update the English README skill summaries**

```markdown
- Rewrite the `doc-detector`, `doc-generator`, and `pattern-extractor` sections to match the new skill goals.
- Remove any implied legacy numbering semantics.
```

- [ ] **Step 2: Update the Chinese README skill summaries**

```markdown
- Mirror the same meaning as the English README.
- Keep bilingual summaries aligned with the rewritten skill behavior.
```

### Task 4: Verify Scope and Drift Removal

**Files:**
- Test: all five target files

- [ ] **Step 1: Verify stale numbering defaults are removed from the three skills**

```bash
rg -n "001|002|REQ-005|DESIGN-005|REQ-001|REQ-002" \
  plugins/ai-doc-driven-dev/skills/doc-detector/SKILL.md \
  plugins/ai-doc-driven-dev/skills/doc-generator/SKILL.md \
  plugins/ai-doc-driven-dev/skills/pattern-extractor/SKILL.md
```

Expected: no matches.

- [ ] **Step 2: Verify README summaries still mention the three skills but no longer imply legacy behavior**

```bash
rg -n "doc-detector|doc-generator|pattern-extractor" \
  plugins/ai-doc-driven-dev/README.md \
  plugins/ai-doc-driven-dev/README-zh.md
```

Expected: matches remain, but only in updated summary sections.

- [ ] **Step 3: Inspect the final diff**

```bash
git diff -- \
  plugins/ai-doc-driven-dev/skills/doc-detector/SKILL.md \
  plugins/ai-doc-driven-dev/skills/doc-generator/SKILL.md \
  plugins/ai-doc-driven-dev/skills/pattern-extractor/SKILL.md \
  plugins/ai-doc-driven-dev/README.md \
  plugins/ai-doc-driven-dev/README-zh.md \
  docs/requirements/20260331-ai-doc-driven-dev-skill-optimization.md \
  docs/design/20260331-ai-doc-driven-dev-skill-optimization-technical-design.md \
  docs/superpowers/plans/2026-03-31-ai-doc-driven-dev-skill-optimization.md
```

Expected: diff limited to the approved five files plus the paired docs and plan.
