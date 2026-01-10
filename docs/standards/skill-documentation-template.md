# Claude Code Skill Documentation Template

## Template Structure

### 1. Frontmatter (Metadata)

```yaml
---
name: skill-name
description: |
  Concise skill description explaining core functionality.
  Use trigger keywords: "when users need to...", "for...", "to build..."
allowed-tools: ["Read", "Write", "Edit", "Grep", "Glob", "Bash"]
license: MIT
---
```

### 2. Overview

**Purpose**: Summarize the skill's core value and capabilities in 1-2 paragraphs

**Template**:
```markdown
## Overview

This skill empowers Claude to [core capability description]. It leverages [key technology/method] to [specific function], enabling [final value/result].
```

### 3. How It Works

**Purpose**: Detail the skill's execution steps and internal mechanisms

**Template**:
```markdown
## How It Works

1. **[Step 1 Name]**: [Specific description]
2. **[Step 2 Name]**: [Specific description]
3. **[Step 3 Name]**: [Specific description]
4. **[Step N Name]**: [Specific description]
```

### 4. When to Use This Skill

**Purpose**: Define activation conditions and applicable scenarios

**Template**:
```markdown
## When to Use This Skill

This skill activates when you need to:
- [Use case 1]
- [Use case 2]
- [Use case 3]
- [Use case N]
```

### 5. Examples

**Purpose**: Demonstrate practical application through concrete examples

**Template**:
```markdown
## Examples

### Example 1: [Example Title]

User request: "[Specific user request]"

The skill will:
1. [Skill execution step 1]
2. [Skill execution step 2]
3. [Skill execution step 3]

### Example 2: [Example Title]

User request: "[Specific user request]"

The skill will:
1. [Skill execution step 1]
2. [Skill execution step 2]
3. [Skill execution step 3]
```

### 6. Best Practices (Optional)

**Template**:
```markdown
## Best Practices

- **[Practice Point 1]**: [Specific recommendation]
- **[Practice Point 2]**: [Specific recommendation]
- **[Practice Point 3]**: [Specific recommendation]
```

### 7. Integration (Optional)

**Template**:
```markdown
## Integration

This skill integrates seamlessly with [related technology/plugins], allowing you to [integration value]. It leverages [tech stack] for [technical advantages].
```

## Complete Example Template

```markdown
---
name: example-skill
description: |
  Concise skill description explaining core functionality.
  Trigger conditions: "when users need to...", "for..."
allowed-tools: ["Read", "Write", "Edit"]
license: MIT
---

## Overview

This skill empowers Claude to [core capability]. It leverages [technical method] to [specific function], enabling [final value].

## How It Works

1. **[Step 1]**: [Description]
2. **[Step 2]**: [Description]
3. **[Step 3]**: [Description]

## When to Use This Skill

This skill activates when you need to:
- [Scenario 1]
- [Scenario 2]
- [Scenario 3]

## Examples

### Example 1: [Title]

User request: "[User request]"

The skill will:
1. [Execution step 1]
2. [Execution step 2]
3. [Execution step 3]

### Example 2: [Title]

User request: "[User request]"

The skill will:
1. [Execution step 1]
2. [Execution step 2]
3. [Execution step 3]

## Best Practices

- **[Point 1]**: [Recommendation]
- **[Point 2]**: [Recommendation]

## Integration

This skill integrates with [related technology], enabling [integration value].
```

## Key Requirements Summary

### ✅ Required Sections
1. **Frontmatter** - Skill metadata
2. **Overview** - Core value summary
3. **How It Works** - Working principles
4. **When to Use This Skill** - Use cases
5. **Examples** - Concrete examples (at least 2)

### 🔄 Optional Sections
1. **Best Practices** - Best practice recommendations
2. **Integration** - Integration explanations

### 📝 Writing Requirements
- **Concise and Clear**: Each section should be brief and to the point
- **Specific and Actionable**: Examples should be concrete, steps should be clear
- **User-Oriented**: Organize content from the user's perspective
- **Consistency**: All skill documentation follows the same structure