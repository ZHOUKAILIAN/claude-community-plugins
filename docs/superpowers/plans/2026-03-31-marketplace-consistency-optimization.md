# Marketplace Consistency Optimization Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Align the root-level marketplace documents with the repository's actual current state without changing plugin implementations.

**Architecture:** Treat the repository file tree and existing plugin metadata as the only source of truth. Update the four root documents in place, then re-scan them for missing-path references and inconsistent plugin inventory claims.

**Tech Stack:** Markdown, ripgrep, existing repository docs, `.claude-plugin/plugin.json`

---

### Task 1: Establish Verification Baseline

**Files:**
- Modify: `README.md`
- Modify: `README-zh.md`
- Modify: `CLAUDE.md`
- Modify: `GEMINI.md`
- Test: root-level path-reference scan via `rg`

- [ ] **Step 1: Run a failing reference scan against current root docs**

```bash
rg -n "scripts/scaffold\\.sh|scripts/validate\\.sh|scripts/publish\\.sh|docs/design/workflow\\.md|docs/design/architecture\\.md" README.md README-zh.md CLAUDE.md GEMINI.md
```

Expected: PASS with matches found, proving the current root docs still reference missing resources.

- [ ] **Step 2: Confirm the referenced paths do not exist**

```bash
find . -maxdepth 2 \( -path "./scripts" -o -path "./docs/design/workflow.md" -o -path "./docs/design/architecture.md" \)
```

Expected: no output, proving the current references are stale.

### Task 2: Align Root Marketplace READMEs

**Files:**
- Modify: `README.md`
- Modify: `README-zh.md`
- Test: `README.md`, `README-zh.md`

- [ ] **Step 1: Update the English marketplace overview**

```markdown
- Remove references to nonexistent management scripts and nonexistent design docs as if they are available now.
- Add the existing `openclaw-ops` plugin to the top-level marketplace inventory.
- Keep `js-framework-analyzer` clearly marked so disabled AI-platform analysis is not described as generally available.
- Unify plugin installation language around repository/plugin-directory usage instead of fictional repo tooling.
```

- [ ] **Step 2: Update the Chinese marketplace overview to match the same facts**

```markdown
- Remove conflicting installation wording that implies a different primary installation path from the English README.
- Mirror the same plugin inventory and implementation-status boundaries as the English README.
- Keep Codex guidance consistent with the English version.
```

- [ ] **Step 3: Re-run targeted scans on both READMEs**

```bash
rg -n "scripts/scaffold\\.sh|scripts/validate\\.sh|scripts/publish\\.sh|docs/design/workflow\\.md|docs/design/architecture\\.md" README.md README-zh.md
```

Expected: no matches.

### Task 3: Align Root AI Instruction Documents

**Files:**
- Modify: `CLAUDE.md`
- Modify: `GEMINI.md`
- Test: `CLAUDE.md`, `GEMINI.md`

- [ ] **Step 1: Rewrite capability and implementation-status sections in `CLAUDE.md`**

```markdown
- Remove claims that missing scripts or missing docs are implemented capabilities.
- Keep only current facts that can be verified from the repository.
- Preserve the repository's documentation-first workflow requirements.
```

- [ ] **Step 2: Apply the same fact corrections to `GEMINI.md`**

```markdown
- Keep the same capability matrix as `CLAUDE.md`.
- Remove the same stale path references and incorrect implementation claims.
```

- [ ] **Step 3: Re-run targeted scans on both instruction docs**

```bash
rg -n "scripts/scaffold\\.sh|scripts/validate\\.sh|scripts/publish\\.sh|docs/design/workflow\\.md|docs/design/architecture\\.md" CLAUDE.md GEMINI.md
```

Expected: no matches.

### Task 4: Run Final Consistency Verification

**Files:**
- Test: `README.md`
- Test: `README-zh.md`
- Test: `CLAUDE.md`
- Test: `GEMINI.md`

- [ ] **Step 1: Verify all four root docs are clean of the known stale references**

```bash
rg -n "scripts/scaffold\\.sh|scripts/validate\\.sh|scripts/publish\\.sh|docs/design/workflow\\.md|docs/design/architecture\\.md" README.md README-zh.md CLAUDE.md GEMINI.md
```

Expected: no matches.

- [ ] **Step 2: Verify root README inventory includes the actual plugin set**

```bash
find plugins -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
```

Expected:
```text
ai-doc-driven-dev
git-ops-helper
js-framework-analyzer
openclaw-ops
```

- [ ] **Step 3: Inspect the final diff**

```bash
git diff -- README.md README-zh.md CLAUDE.md GEMINI.md docs/requirements/20260331-marketplace-consistency-optimization.md docs/design/20260331-marketplace-consistency-optimization-technical-design.md docs/superpowers/plans/2026-03-31-marketplace-consistency-optimization.md
```

Expected: diff limited to the approved root-document scope plus the paired docs and plan.
