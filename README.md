# Claude Code PM

[![Automaze](https://img.shields.io/badge/By-automaze.io-4b3baf)](https://automaze.io)
&nbsp;
[![Claude Code](https://img.shields.io/badge/+-Claude%20Code-d97757)](https://github.com/automazeio/ccpm/blob/main/README.md)
[![GitHub Issues](https://img.shields.io/badge/+-GitHub%20Issues-1f2328)](https://github.com/automazeio/ccpm)
&nbsp;
[![MIT License](https://img.shields.io/badge/License-MIT-28a745)](https://github.com/automazeio/ccpm/blob/main/LICENSE)
&nbsp;
[![Follow on 𝕏](https://img.shields.io/badge/𝕏-@aroussi-1c9bf0)](http://x.com/intent/follow?screen_name=aroussi)
&nbsp;
[![Star this repo](https://img.shields.io/badge/★-Star%20this%20repo-e7b10b)](https://github.com/automazeio/ccpm)

### Claude Code workflow to ship ~~faster~~ _better_ using spec-driven development, GitHub issues, Git worktrees, and mutiple AI agents running in parallel.

Stop losing context. Stop blocking on tasks. Stop shipping bugs. This battle-tested system turns PRDs into epics, epics into GitHub issues, and issues into production code – with full traceability at every step.

![Claude Code PM](screenshot.webp)

## Table of Contents

- [Background](#background)
- [The Workflow](#the-workflow)
- [What Makes This Different?](#what-makes-this-different)
- [Why GitHub Issues?](#why-github-issues)
- [Core Principle: No Vibe Coding](#core-principle-no-vibe-coding)
- [System Architecture](#system-architecture)
- [Workflow Phases](#workflow-phases)
- [Command Reference](#command-reference)
- [The Parallel Execution System](#the-parallel-execution-system)
- [Key Features & Benefits](#key-features--benefits)
- [Proven Results](#proven-results)
- [Example Flow](#example-flow)
- [Get Started Now](#get-started-now)
- [Local vs Remote](#local-vs-remote)
- [Technical Notes](#technical-notes)
- [Support This Project](#support-this-project)

## Background

Every team struggles with the same problems:
- **Context evaporates** between sessions, forcing constant re-discovery
- **Parallel work creates conflicts** when multiple developers touch the same code
- **Requirements drift** as verbal decisions override written specs
- **Progress becomes invisible** until the very end

This system solves all of that.

## The Workflow

```mermaid
graph LR
    A[PRD Creation] --> B[Epic Planning]
    B --> C[Task Decomposition]
    C --> D[GitHub Sync]
    D --> E[Parallel Execution]
```

### Complete Workflow (32 minutes)

```bash
# 1. Validate your idea (18 min, fully automated)
/pm:validate-idea IDEA.md
# → Generates: VALIDATED-IDEA.md with GO/NO-GO decision

# 2. Setup project structure (2 min)
/pm:new-project my-project

# 3. Create comprehensive PRD from validated research (8 min)
/pm:prd-new project-foundation --from-idea VALIDATED-IDEA.md

# 4. Transform PRD into technical implementation plan (4 min)
/pm:prd-parse project-foundation
/pm:epic-oneshot project-foundation

# 5. Start parallel development
/pm:issue-start 1234
```

## What Makes This Different?

| Traditional Development | Claude Code PM System |
|------------------------|----------------------|
| **Manual idea validation** | **✨ Automated validation** with 15+ web searches & lean startup framework |
| Context lost between sessions | **Persistent context** across all work |
| Serial task execution | **Parallel agents** on independent tasks |
| "Vibe coding" from memory | **Spec-driven** with full traceability |
| Progress hidden in branches | **Transparent audit trail** in GitHub |
| Manual task coordination | **Intelligent prioritization** with `/pm:next` |

## Why GitHub Issues?

Most Claude Code workflows operate in isolation – a single developer working with AI in their local environment. This creates a fundamental problem: **AI-assisted development becomes a silo**.

By using GitHub Issues as our database, we unlock something powerful:

### 🤝 **True Team Collaboration**
- Multiple Claude instances can work on the same project simultaneously
- Human developers see AI progress in real-time through issue comments
- Team members can jump in anywhere – the context is always visible
- Managers get transparency without interrupting flow

### 🔄 **Seamless Human-AI Handoffs**
- AI can start a task, human can finish it (or vice versa)
- Progress updates are visible to everyone, not trapped in chat logs
- Code reviews happen naturally through PR comments
- No "what did the AI do?" meetings

### 📈 **Scalable Beyond Solo Work**
- Add team members without onboarding friction
- Multiple AI agents working in parallel on different issues
- Distributed teams stay synchronized automatically
- Works with existing GitHub workflows and tools

### 🎯 **Single Source of Truth**
- No separate databases or project management tools
- Issue state is the project state
- Comments are the audit trail
- Labels provide organization

This isn't just a project management system – it's a **collaboration protocol** that lets humans and AI agents work together at scale, using infrastructure your team already trusts.

## Core Principle: No Vibe Coding

> **Every line of code must trace back to a specification.**

We follow a strict 5-phase discipline:

1. **🧠 Brainstorm** - Think deeper than comfortable
2. **📝 Document** - Write specs that leave nothing to interpretation
3. **📐 Plan** - Architect with explicit technical decisions
4. **⚡ Execute** - Build exactly what was specified
5. **📊 Track** - Maintain transparent progress at every step

No shortcuts. No assumptions. No regrets.

## System Architecture

```
.claude/
├── CLAUDE.md          # Always-on instructions (copy content to your project's CLAUDE.md file)
├── agents/            # Task-oriented agents (for context preservation)
├── commands/          # Command definitions
│   ├── context/       # Create, update, and prime context
│   ├── pm/            # ← Project management commands (this system)
│   └── testing/       # Prime and execute tests (edit this)
├── context/           # Project-wide context files
├── epics/             # ← PM's local workspace (place in .gitignore)
│   └── [epic-name]/   # Epic and related tasks
│       ├── epic.md    # Implementation plan
│       ├── [#].md     # Individual task files
│       └── updates/   # Work-in-progress updates
├── prds/              # ← PM's PRD files
├── rules/             # Place any rule files you'd like to reference here
└── scripts/           # Place any script files you'd like to use here
```

## Workflow Phases

### 1. Product Planning Phase

```bash
/pm:prd-new feature-name
```
Launches comprehensive brainstorming to create a Product Requirements Document capturing vision, user stories, success criteria, and constraints.

**Output:** `.claude/prds/feature-name.md`

### 2. Implementation Planning Phase

```bash
/pm:prd-parse feature-name
```
Transforms PRD into a technical implementation plan with architectural decisions, technical approach, and dependency mapping.

**Output:** `.claude/epics/feature-name/epic.md`

### 3. Task Decomposition Phase

```bash
/pm:epic-decompose feature-name
```
Breaks epic into concrete, actionable tasks with acceptance criteria, effort estimates, and parallelization flags.

**Output:** `.claude/epics/feature-name/[task].md`

### 4. GitHub Synchronization

```bash
/pm:epic-sync feature-name
# Or for confident workflows:
/pm:epic-oneshot feature-name
```
Pushes epic and tasks to GitHub as issues with appropriate labels and relationships.

### 5. Execution Phase

```bash
/pm:issue-start 1234  # Launch specialized agent
/pm:issue-sync 1234   # Push progress updates
/pm:next             # Get next priority task
```
Specialized agents implement tasks while maintaining progress updates and an audit trail.

## Command Reference

> [!TIP]
> Type `/pm:help` for a concise command summary

### Initial Setup
- `/pm:init` - Install dependencies and configure GitHub

### Idea Validation Commands ✨ NEW
- `/pm:validate-idea <idea_file>` - **Transform raw idea into validated concept using fully automated AI-driven lean startup methodology**
  - ⚡ **Autonomous validation** - Zero user interaction required  
  - 🔍 **15+ web searches** - Market trends, competitive analysis, problem validation
  - 📊 **Evidence-based scoring** - GO/NO-GO decisions with confidence levels
  - ⏱️ **18-minute process** - Complete validation in under 20 minutes
  - 📋 **Ready for PRD** - Output directly integrates with `/pm:prd-new`

### PRD Commands  
- `/pm:prd-new` - Launch brainstorming for new product requirement
- `/pm:prd-new --from-idea <file>` - Enhanced brainstorming starting from raw idea file
- `/pm:prd-parse` - Convert PRD to implementation epic
- `/pm:prd-list` - List all PRDs
- `/pm:prd-edit` - Edit existing PRD
- `/pm:prd-status` - Show PRD implementation status

### Epic Commands
- `/pm:epic-decompose` - Break epic into task files
- `/pm:epic-sync` - Push epic and tasks to GitHub
- `/pm:epic-oneshot` - Decompose and sync in one command
- `/pm:epic-list` - List all epics
- `/pm:epic-show` - Display epic and its tasks
- `/pm:epic-close` - Mark epic as complete
- `/pm:epic-edit` - Edit epic details
- `/pm:epic-refresh` - Update epic progress from tasks

### Issue Commands
- `/pm:issue-show` - Display issue and sub-issues
- `/pm:issue-status` - Check issue status
- `/pm:issue-start` - Begin work with specialized agent
- `/pm:issue-sync` - Push updates to GitHub
- `/pm:issue-close` - Mark issue as complete
- `/pm:issue-reopen` - Reopen closed issue
- `/pm:issue-edit` - Edit issue details

### Workflow Commands
- `/pm:next` - Show next priority issue with epic context
- `/pm:status` - Overall project dashboard
- `/pm:standup` - Daily standup report
- `/pm:blocked` - Show blocked tasks
- `/pm:in-progress` - List work in progress

### Sync Commands
- `/pm:sync` - Full bidirectional sync with GitHub
- `/pm:import` - Import existing GitHub issues

### Maintenance Commands
- `/pm:validate` - Check system integrity
- `/pm:clean` - Archive completed work
- `/pm:search` - Search across all content

## The Parallel Execution System

### Issues Aren't Atomic

Traditional thinking: One issue = One developer = One task

**Reality: One issue = Multiple parallel work streams**

A single "Implement user authentication" issue isn't one task. It's...

- **Agent 1**: Database tables and migrations
- **Agent 2**: Service layer and business logic
- **Agent 3**: API endpoints and middleware
- **Agent 4**: UI components and forms
- **Agent 5**: Test suites and documentation

All running **simultaneously** in the same worktree.

### The Math of Velocity

**Traditional Approach:**
- Epic with 3 issues
- Sequential execution

**This System:**
- Same epic with 3 issues
- Each issue splits into ~4 parallel streams
- **12 agents working simultaneously**

We're not assigning agents to issues. We're **leveraging multiple agents** to ship faster.

### Context Optimization

**Traditional single-thread approach:**
- Main conversation carries ALL the implementation details
- Context window fills with database schemas, API code, UI components
- Eventually hits context limits and loses coherence

**Parallel agent approach:**
- Main thread stays clean and strategic
- Each agent handles its own context in isolation
- Implementation details never pollute the main conversation
- Main thread maintains oversight without drowning in code

Your main conversation becomes the conductor, not the orchestra.

### GitHub vs Local: Perfect Separation

**What GitHub Sees:**
- Clean, simple issues
- Progress updates
- Completion status

**What Actually Happens Locally:**
- Issue #1234 explodes into 5 parallel agents
- Agents coordinate through Git commits
- Complex orchestration hidden from view

GitHub doesn't need to know HOW the work got done – just that it IS done.

### The Command Flow

```bash
# Analyze what can be parallelized
/pm:issue-analyze 1234

# Launch the swarm
/pm:epic-start memory-system

# Watch the magic
# 12 agents working across 3 issues
# All in: ../epic-memory-system/

# One clean merge when done
/pm:epic-merge memory-system
```

## Key Features & Benefits

### 🧠 **Context Preservation**
Never lose project state again. Each epic maintains its own context, agents read from `.claude/context/`, and updates locally before syncing.

### ⚡ **Parallel Execution**
Ship faster with multiple agents working simultaneously. Tasks marked `parallel: true` enable conflict-free concurrent development.

### 🔗 **GitHub Native**
Works with tools your team already uses. Issues are the source of truth, comments provide history, and there is no dependency on the Projects API.

### 🤖 **Agent Specialization**
Right tool for every job. Different agents for UI, API, and database work. Each reads requirements and posts updates automatically.

### 💡 **Idea-to-PRD Enhancement**
Transform raw ideas into structured PRDs through guided brainstorming. `/pm:prd-new --from-idea` uses your initial concept as a foundation for comprehensive product planning, asking targeted questions to build complete requirements.

### 📊 **Full Traceability**
Every decision is documented. Idea → PRD → Epic → Task → Issue → Code → Commit. Complete audit trail from concept to production.

### 🚀 **Developer Productivity**
Focus on building, not managing. Intelligent prioritization, automatic context loading, and incremental sync when ready.

## Proven Results

Teams using this system report:
- **89% less time** lost to context switching – you'll use `/compact` and `/clear` a LOT less
- **5-8 parallel tasks** vs 1 previously – editing/testing multiple files at the same time
- **75% reduction** in bug rates – due to the breaking down features into detailed tasks 
- **Up to 3x faster** feature delivery – based on feature size and complexity

## Example Flow

```bash
# Start with idea validation
echo "AI coding assistant for mobile apps" > IDEA.md
/pm:validate-idea IDEA.md
# → Generates market research and GO/NO-GO decision

# Setup new project structure
/pm:new-project mobile-ai-assistant

# Create PRD from validated research
/pm:prd-new project-foundation --from-idea VALIDATED-IDEA.md
# → Comprehensive product requirements

# Generate technical implementation plan
/pm:prd-parse project-foundation
# → Technical architecture and approach

# Push to GitHub and start parallel development
/pm:epic-oneshot project-foundation
# Creates issues: #1234 (epic), #1235, #1236 (tasks)

# Begin implementation
/pm:issue-start 1235
# Specialized agent begins work

# Monitor progress
/pm:epic-show project-foundation
```

## Get Started

> 📖 **Quick Reference**: See [QUICKSTART-GUIDE.md](QUICKSTART-GUIDE.md) for a condensed guide

### Prerequisites

- **Claude Code** - This system runs as commands within Claude Code
- **Git** - For version control
- **GitHub CLI** (optional) - Automatically installed by `/pm:init`

Choose your scenario:

### 🚀 Starting a New Project from an Idea

**Full automated workflow (32 minutes):**

```bash
# 1. Clone CCPM system
mkdir my-project && cd my-project
git clone https://github.com/Bias93/ccpm.git .

# 2. Write your idea
echo "My app idea: A platform that..." > IDEA.md

# 3. Validate idea (18 min, fully automated)
/pm:validate-idea IDEA.md

# 4. Setup project (2 min)
/pm:new-project my-project

# 5. Create PRD from validated idea (8 min)
/pm:prd-new project-foundation --from-idea VALIDATED-IDEA.md

# 6. Generate technical plan (4 min)
/pm:prd-parse project-foundation
/pm:epic-oneshot project-foundation

# 7. Start development
/pm:issue-start 1234
```

### 🏢 Adding CCPM to Existing Project

**Simple integration (5 minutes):**

```bash
# 1. Install CCPM
cd your-existing-project/
git clone https://github.com/Bias93/ccpm.git temp-ccpm
cp -r temp-ccpm/.claude ./ && rm -rf temp-ccpm

# 2. Initialize system
/pm:init

# 3. Create project context
/init include rules from .claude/CLAUDE.md
/context:create

# 4. Start first feature
/pm:prd-new your-feature-name
```

### 🎯 Just Validate an Idea

**Research-only workflow (18 minutes):**

```bash
# Clone anywhere temporarily
git clone https://github.com/Bias93/ccpm.git temp-validation
cd temp-validation

# Write your idea
echo "My idea: An AI tool that..." > IDEA.md

# Get automated validation report
/pm:validate-idea IDEA.md
# → Generates VALIDATED-IDEA.md with GO/NO-GO decision

# Review results and decide
cat VALIDATED-IDEA.md
```

### What Happens Next?

- **New projects**: Your repository is ready with clean structure
- **Existing projects**: CCPM integrates without disrupting your code  
- **Idea validation**: You get evidence-based GO/NO-GO decision with market research

### Need Help?

- **Commands**: Type `/pm:help` for full command reference
- **Issues**: Check [GitHub Issues](https://github.com/Bias93/ccpm/issues)
- **Quick Guide**: See [QUICKSTART-GUIDE.md](QUICKSTART-GUIDE.md)

## Local vs Remote

| Operation | Local | GitHub |
|-----------|-------|--------|
| PRD Creation | ✅ | — |
| Implementation Planning | ✅ | — |
| Task Breakdown | ✅ | ✅ (sync) |
| Execution | ✅ | — |
| Status Updates | ✅ | ✅ (sync) |
| Final Deliverables | — | ✅ |

## Technical Notes

### GitHub Integration
- Uses **gh-sub-issue extension** for proper parent-child relationships
- Falls back to task lists if extension not installed
- Epic issues track sub-task completion automatically
- Labels provide additional organization (`epic:feature`, `task:feature`)

### File Naming Convention
- Tasks start as `001.md`, `002.md` during decomposition
- After GitHub sync, renamed to `{issue-id}.md` (e.g., `1234.md`)
- Makes it easy to navigate: issue #1234 = file `1234.md`

### Design Decisions
- Intentionally avoids GitHub Projects API complexity
- All commands operate on local files first for speed
- Synchronization with GitHub is explicit and controlled
- Worktrees provide clean git isolation for parallel work
- GitHub Projects can be added separately for visualization

---

## Contributing to This Enhanced Fork

This is an enhanced version of the original CCPM with improvements for new projects and fixed initialization scripts.

**Original project**: [automazeio/ccpm](https://github.com/automazeio/ccpm) by [@aroussi](https://x.com/aroussi)

**Enhancements in this fork**:
- Fixed `/pm:init` script for automatic setup without sudo
- Added complete workflow for brand new projects  
- Enhanced error handling and validation
- Project foundation PRD template
- Improved git remote handling

## Support This Project

Claude Code PM was developed at [Automaze](https://automaze.io) **for developers who ship, by developers who ship**.

If Claude Code PM helps your team ship better software:

- ⭐ **[Star the original repository](https://github.com/automazeio/ccpm)** to support the creator
- ⭐ **[Star this enhanced fork](https://github.com/Bias93/ccpm)** for the improvements
- 🐦 **[Follow @aroussi on X](https://x.com/aroussi)** for updates and tips


---

> [!TIP]
> **Ship faster with Automaze.** We partner with founders to bring their vision to life, scale their business, and optimize for success.
> **[Visit Automaze to book a call with me ›](https://automaze.io)**
