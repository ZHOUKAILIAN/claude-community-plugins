# 003-JS框架源码仓库分析器需求文档

## 需求概述

开发一个Claude Code插件，专门分析三种特定类型的JavaScript源码仓库，通过探索和发现来梳理核心实现机制：

1. **微前端框架源码**：分析CSS隔离和JS隔离的实现机制
2. **AI应用平台源码**：分析架构和核心功能实现
3. **前端框架源码**：分析响应式系统的实现机制

## 目标仓库类型详细分析

### 1. 微前端框架源码（Microfrontend Framework Source）

#### 框架示例
- **qiankun**：基于single-spa的微前端框架
- **wujie**：基于WebComponent + iframe的微前端框架
- **single-spa**：微前端基础框架
- **emp**：基于Webpack 5 Module Federation的微前端框架

#### 核心分析重点：隔离机制

##### JS隔离机制分析
- 探索框架如何实现JavaScript执行环境的隔离
- 识别沙箱相关的核心文件和代码
- 分析隔离策略的实现细节（不预设具体方案）

##### CSS隔离机制分析
- 探索框架如何实现样式隔离
- 识别样式管理相关的核心文件和代码
- 分析CSS隔离策略的实现细节（不预设具体方案）

##### DOM 元素拦截分析
- **根级DOM元素拦截**：分析对 `html`、`body`、`head` 元素访问的拦截机制
- **document对象拦截**：分析对 `document.querySelector`、`document.getElementById`、`document.createElement` 等方法的拦截
- **DOM操作隔离**：分析如何确保子应用的DOM操作范围限制和隔离
- **DOM事件拦截**：分析对全局事件监听的拦截和代理机制

##### API 拦截分析
- **浏览器原生API拦截**：分析对 `location`、`history`、`navigator` 等浏览器API的拦截
- **存储API拦截**：分析对 `localStorage`、`sessionStorage`、`indexedDB` 等存储API的拦截
- **全局对象拦截**：分析对 `window`、`global`、`globalThis` 等全局对象的访问控制
- **网络请求拦截**：分析对 `fetch`、`XMLHttpRequest` 等网络请求API的拦截和代理
- **定时器API拦截**：分析对 `setTimeout`、`setInterval` 等定时器API的拦截

##### 拦截策略深度分析
- **拦截实现技术**：分析使用的技术手段（Proxy、Object.defineProperty、函数重写、原型链修改等）
- **拦截范围控制**：分析哪些API被拦截、哪些被放行的策略和原因
- **拦截时机管理**：分析拦截发生的时机（应用加载前、运行时、卸载时等）
- **拦截恢复机制**：分析应用卸载时如何恢复被拦截的API

---

### 2. AI应用平台源码（AI Platform Source）

#### 平台示例
- **Coze**：字节跳动的AI应用构建平台
- **Dify**：开源的LLM应用开发平台
- **FastGPT**：基于LLM的知识库问答平台

#### 核心分析重点
- 探索平台的整体架构设计
- 识别核心功能模块的实现位置
- 分析各模块之间的交互方式（不预设具体模块列表）

---

### 3. 前端框架源码（Frontend Framework Source）

#### 框架示例
- **Vue**：渐进式JavaScript框架
- **React**：用户界面库
- **SolidJS**：细粒度响应式框架
- **Svelte**：编译型框架

#### 核心分析重点：响应式系统
- 探索框架如何实现数据变化驱动视图更新
- 识别响应式系统相关的核心文件和代码
- 分析响应式实现策略（不预设具体方案）

---

## 技术实现规格

### 插件结构
```
plugins/js-framework-analyzer/
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

### 核心分析方法

#### 探索式分析流程
1. **仓库类型识别**：通过package.json、目录结构等特征识别仓库类型
2. **核心机制定位**：基于关键词、文件名、代码注释等线索定位核心实现
3. **代码关系梳理**：分析核心文件之间的依赖和调用关系
4. **实现机制总结**：用自然语言总结发现的核心机制

#### 分析策略
- 不预设具体的实现方式
- 通过代码探索发现实际实现
- 关注核心文件和关键代码片段
- 用清晰的中文描述发现的内容

### 输出报告格式

#### 微前端隔离机制分析报告
```markdown
# 微前端框架隔离机制分析

## 框架信息
- 框架名称：{name}
- 版本：{version}
- 技术栈：{techStack}

## JS隔离实现
### 核心文件
{jsIsolationFiles}

### 实现机制
{jsIsolationMechanism}

### 关键代码片段
{jsIsolationCode}

## CSS隔离实现
### 核心文件
{cssIsolationFiles}

### 实现机制
{cssIsolationMechanism}

### 关键代码片段
{cssIsolationCode}

## DOM 元素拦截实现
### 核心文件
{domInterceptionFiles}

### 拦截机制
#### 根级DOM元素拦截
{htmlBodyHeadInterception}

#### document对象拦截
{documentInterception}

#### DOM操作隔离
{domOperationIsolation}

### 关键代码片段
{domInterceptionCode}

## API 拦截实现
### 核心文件
{apiInterceptionFiles}

### 拦截机制
#### 浏览器原生API拦截
{browserApiInterception}

#### 存储API拦截
{storageApiInterception}

#### 全局对象拦截
{globalObjectInterception}

#### 网络请求拦截
{networkApiInterception}

### 关键代码片段
{apiInterceptionCode}

## 拦截策略深度分析
### 拦截实现技术
{interceptionTechniques}

### 拦截范围控制
{interceptionScope}

### 拦截时机管理
{interceptionTiming}

### 拦截恢复机制
{interceptionRecovery}

## 总结与洞察
### 总体评估
{overallAssessment}

### 隔离机制对比
{isolationComparison}

### 最佳实践建议
{bestPractices}
```

#### 响应式系统分析报告
```markdown
# 前端框架响应式系统分析

## 框架信息
- 框架名称：{name}
- 版本：{version}

## 响应式实现
### 核心文件
{reactivityFiles}

### 实现机制
{reactivityMechanism}

### 关键代码片段
{reactivityCode}
```

#### AI平台架构分析报告
```markdown
# AI应用平台架构分析

## 平台信息
- 平台名称：{name}
- 技术栈：{techStack}

## 核心架构
{architecture}

## 核心功能实现
{coreFeatures}
```
