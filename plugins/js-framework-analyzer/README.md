# JS Framework Analyzer

A Claude Code plugin for analyzing JavaScript framework source code repositories to understand core implementation mechanisms.

## Features

This plugin provides specialized analysis capabilities for three types of JavaScript frameworks:

### Microfrontend Framework Analysis
Analyze JavaScript and CSS isolation mechanisms in microfrontend frameworks:
- qiankun (based on single-spa)
- wujie (based on WebComponent + iframe)
- single-spa (microfrontend foundation)
- emp (based on Webpack 5 Module Federation)

### AI Platform Analysis
Analyze architecture and core functionality of AI application platforms:
- Coze (ByteDance's AI platform)
- Dify (open source LLM platform)
- FastGPT (knowledge-based Q&A platform)

### Frontend Framework Reactivity Analysis
Analyze reactivity system implementations in frontend frameworks:
- Vue (progressive framework)
- React (UI library)
- SolidJS (fine-grained reactivity)
- Svelte (compile-time framework)

## Installation

This plugin is part of the Claude Code Plugin Marketplace. To install:

```bash
# Navigate to your project directory
cd your-project

# Install the plugin (when marketplace is available)
claude plugin install js-framework-analyzer
```

## Usage

### Commands

#### Analyze Microfrontend Isolation
```bash
claude analyze-mf-isolation
claude analyze-mf-isolation --focus js
claude analyze-mf-isolation --detailed --save report.md
```

#### Analyze AI Platform Architecture
```bash
claude analyze-ai-platform
claude analyze-ai-platform --module chat
claude analyze-ai-platform --detailed --save report.md
```

#### Analyze Reactivity System
```bash
claude analyze-reactivity
claude analyze-reactivity --detailed --save report.md
```

### Skills

The plugin includes four specialized skills:

1. **microfrontend-isolation-analyzer** - Analyze JS and CSS isolation in microfrontends
2. **ai-platform-analyzer** - Analyze AI platform architecture
3. **reactivity-system-analyzer** - Analyze reactivity systems in frameworks
4. **structure-explainer** - Explain codebase structure and organization

## Analysis Approach

This plugin uses an exploratory analysis approach:

1. **Repository Detection**: Identify framework type through package.json and directory structure
2. **Keyword Search**: Search for relevant keywords to locate core implementations
3. **Core File Identification**: Locate files containing the target mechanism
4. **Code Relationship Analysis**: Map dependencies and call relationships
5. **Mechanism Documentation**: Summarize discovered implementations in clear descriptions

## Output Format

Analysis reports include:

- Framework/Platform information (name, version, tech stack)
- Core files and their purposes
- Implementation mechanism explanation
- Key code snippets with annotations
- Trade-offs and design decisions

## Plugin Structure

```
js-framework-analyzer/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   ├── microfrontend-isolation-analyzer/
│   │   └── SKILL.md
│   ├── ai-platform-analyzer/
│   │   └── SKILL.md
│   ├── reactivity-system-analyzer/
│   │   └── SKILL.md
│   └── structure-explainer/
│       └── SKILL.md
├── commands/
│   ├── analyze-mf-isolation.md
│   ├── analyze-ai-platform.md
│   └── analyze-reactivity.md
├── README.md
└── README-zh.md
```

## License

MIT

---

**[中文版本](README-zh.md) | [English Version](README.md)**
