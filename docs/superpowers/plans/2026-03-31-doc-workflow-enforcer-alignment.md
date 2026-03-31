# Doc-Workflow-Enforcer Alignment Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Align `doc-workflow-enforcer`, its two directly related agents, and the ai-doc-driven-dev README pair to the current docs-first workflow standard.

**Architecture:** Rewrite `doc-workflow-enforcer` as the single workflow-rule source around lightweight `CLAUDE.md`, separate `AGENTS.md`, approval-before-write, and date-based document naming. Then update the transformer and updater agents so they inherit the same workflow semantics. Finally sync the plugin README pair so the user-facing summary matches the rewritten internals.

**Tech Stack:** Markdown, existing plugin skill/agent structure, repository workflow standards

---

### Task 1: Establish Baseline Drift

**Files:**
- Modify: `plugins/ai-doc-driven-dev/skills/doc-workflow-enforcer/SKILL.md`
- Modify: `plugins/ai-doc-driven-dev/agents/doc-workflow-transformer.md`
- Modify: `plugins/ai-doc-driven-dev/agents/doc-flow-updater.md`
- Modify: `plugins/ai-doc-driven-dev/README.md`
- Modify: `plugins/ai-doc-driven-dev/README-zh.md`
- Test: baseline drift scan via `rg`

- [ ] **Step 1: Confirm stale workflow wording exists**

```bash
rg -n "REQ-YYYYMMDD|TECH-YYYYMMDD|Title format|001-feature|Before|After" \
  plugins/ai-doc-driven-dev/skills/doc-workflow-enforcer/SKILL.md \
  plugins/ai-doc-driven-dev/agents/doc-workflow-transformer.md \
  plugins/ai-doc-driven-dev/agents/doc-flow-updater.md \
  plugins/ai-doc-driven-dev/README.md \
  plugins/ai-doc-driven-dev/README-zh.md
```

Expected: matches in the current files, proving stale workflow wording is still present.

### Task 2: Rewrite the Workflow Skill

**Files:**
- Modify: `plugins/ai-doc-driven-dev/skills/doc-workflow-enforcer/SKILL.md`

- [ ] **Step 1: Rewrite `doc-workflow-enforcer` around current priorities**

```markdown
- Make lightweight `CLAUDE.md` plus separate `AGENTS.md` the core workflow rule.
- Keep approval-before-write as a hard gate.
- Express date-based naming as the file naming convention without expanding legacy title-token rules.
- Focus on goals, constraints, and review gates instead of tutorial-heavy process detail.
```

### Task 3: Sync the Two Agents

**Files:**
- Modify: `plugins/ai-doc-driven-dev/agents/doc-workflow-transformer.md`
- Modify: `plugins/ai-doc-driven-dev/agents/doc-flow-updater.md`

- [ ] **Step 1: Update `doc-workflow-transformer`**

```markdown
- Make its orchestration stages match the rewritten workflow skill.
- Emphasize instruction-file separation and docs-first sequencing.
- Keep the agent as an orchestrator, not a second rule source.
```

- [ ] **Step 2: Update `doc-flow-updater`**

```markdown
- Keep backup, analysis, approval, write, and verification stages.
- Replace stale title-format and legacy migration examples with current date-based naming language.
- Keep success criteria centered on separation, naming consistency, and preserved content.
```

### Task 4: Sync Plugin README Summaries

**Files:**
- Modify: `plugins/ai-doc-driven-dev/README.md`
- Modify: `plugins/ai-doc-driven-dev/README-zh.md`

- [ ] **Step 1: Update the English README**

```markdown
- Rewrite the `doc-workflow-enforcer` summary and related best-practice wording.
- Describe workflow enforcement as instruction-file organization plus approval gates.
```

- [ ] **Step 2: Update the Chinese README**

```markdown
- Mirror the same meaning as the English README.
- Keep the summary aligned with the updated skill and agents.
```

### Task 5: Verify Drift Removal and Scope

**Files:**
- Test: all five target files

- [ ] **Step 1: Verify stale title-format defaults are removed**

```bash
rg -n "REQ-YYYYMMDD|TECH-YYYYMMDD|Title format|001-feature" \
  plugins/ai-doc-driven-dev/skills/doc-workflow-enforcer/SKILL.md \
  plugins/ai-doc-driven-dev/agents/doc-workflow-transformer.md \
  plugins/ai-doc-driven-dev/agents/doc-flow-updater.md
```

Expected: no matches.

- [ ] **Step 2: Verify workflow-entry references remain present in the README pair**

```bash
rg -n "doc-workflow-enforcer|CLAUDE.md|AGENTS.md" \
  plugins/ai-doc-driven-dev/README.md \
  plugins/ai-doc-driven-dev/README-zh.md
```

Expected: matches remain, but only in updated workflow-summary sections.

- [ ] **Step 3: Inspect final scope**

```bash
git diff -- \
  plugins/ai-doc-driven-dev/skills/doc-workflow-enforcer/SKILL.md \
  plugins/ai-doc-driven-dev/agents/doc-workflow-transformer.md \
  plugins/ai-doc-driven-dev/agents/doc-flow-updater.md \
  plugins/ai-doc-driven-dev/README.md \
  plugins/ai-doc-driven-dev/README-zh.md \
  docs/requirements/20260331-doc-workflow-enforcer-alignment.md \
  docs/design/20260331-doc-workflow-enforcer-alignment-technical-design.md \
  docs/superpowers/plans/2026-03-31-doc-workflow-enforcer-alignment.md
```

Expected: diff limited to the approved five files plus the paired docs and plan.
