# PM Agent Generator - /pm:agent-generate

**Status:** ✅ Fully Implemented  
**Version:** 2.0  
**Type:** Solo Developer Command  
**Model:** Sonnet  

## Command Overview

Generates project-specific subagents based on PRD requirements and auto-detected/decided technology stack. Creates 5-7 specialized agents that understand the exact project context, requirements, and technical choices.

## Syntax

```bash
/pm:agent-generate <project-name>
```

## Parameters

- `<project-name>`: Name of the project (must have existing PRD file)

## Prerequisites

- Existing PRD file at `docs/prds/{project-name}.md`
- CCPM project structure initialized

## Execution Flow

1. **Load Project Context**
   - Read PRD file for requirements and constraints
   - Analyze project scope and complexity
   - Identify key technical decisions from PRD

2. **Stack Decision Matrix**
   - **Web App**: Next.js 15 + Prisma + PostgreSQL (full-stack, type-safe, Vercel deploy)
   - **API Service**: Fastify + SQLite (lightweight, fast, zero config)
   - **Mobile App**: React Native + Expo (cross-platform, single codebase)
   - **Desktop App**: Electron + React (familiar, extensible)
   - **CLI Tool**: Node.js + Commander (simple, npm distribution)
   - **Data Pipeline**: Node.js + Zod + SQLite (type-safe, embedded)
   - **Chrome Extension**: React + Vite + Manifest V3

3. **Generate Core Subagents (5-7)**
   - `{project}-setup-specialist`: Project initialization, boilerplate, config
   - `{project}-backend-specialist`: API, database, business logic
   - `{project}-frontend-specialist`: UI, components, state management
   - `{project}-data-specialist`: Schema, migrations, models
   - `{project}-testing-specialist`: Test setup, unit/integration/e2e
   - `{project}-deployment-specialist`: CI/CD, hosting, monitoring
   - `{project}-integration-specialist`: (conditional) External APIs, services

4. **Model Assignment Strategy**
   - **Haiku**: Simple tasks (setup, basic config)
   - **Sonnet**: Development tasks (backend, frontend, data)
   - **Opus**: Complex tasks (testing strategy, deployment)

5. **Create Agent Files**
   - Generate in `.claude/agents/` directory
   - Use project-specific naming: `{project}-{role}-specialist.md`
   - Include full project context in each agent

## Example Usage

```bash
/pm:agent-generate taskapp
```

**Generated Agents:**
- `taskapp-setup-specialist.md`
- `taskapp-backend-specialist.md` 
- `taskapp-frontend-specialist.md`
- `taskapp-data-specialist.md`
- `taskapp-testing-specialist.md`
- `taskapp-deployment-specialist.md`

## Agent Template Structure

```yaml
---
name: {project}-{role}-specialist
description: {Role} specialist for {project} using {stack}
tools: Read, Write, Edit, Bash
model: sonnet  # or haiku/opus based on complexity
---

You are a {role} specialist for the {project} project.

Project Context:
- Stack: {detected stack}
- Requirements: {key requirements from PRD}
- Architecture: {architectural decisions}
- Patterns: {coding conventions}

Responsibilities:
1. {specific responsibility 1}
2. {specific responsibility 2}
3. {specific responsibility 3}

Guidelines:
- Follow project conventions and patterns
- Optimize for solo developer workflow
- Balance quality with development speed
- Use cost-effective, proven solutions
- Maintain consistency across project
```

## Integration Points

### With Other Commands

- **prd-parse**: Suggests agent-generate after PRD creation
- **epic-decompose**: Uses generated agents for task assignment
- **epic-sync**: Includes agent files in repository

### With Task Templates

Task templates reference project-specific agents:

```yaml
---
name: Setup Database Schema
subagent_type: taskapp-data-specialist
subagent_context: |
  Create initial database schema for task management:
  - Users table with authentication
  - Tasks with status, priority, due dates
  - Categories for organization
---
```

## Benefits

✅ **Zero Assumptions**: Each agent knows exact stack and requirements  
✅ **Context Isolation**: Agents work within defined project boundaries  
✅ **Stack Consistency**: Single source of truth for technology decisions  
✅ **Solo Optimization**: Balanced for individual developer productivity  
✅ **Cost Efficiency**: Right model for each task complexity  
✅ **Best Practices**: Follows 2025 patterns from wshobson/agents  

## Success Criteria

- [ ] Generated 5-7 project-specific agents
- [ ] Each agent has clear, focused responsibilities  
- [ ] Stack decisions documented and consistent
- [ ] Model assignments optimized for task complexity
- [ ] Integration ready for epic-decompose
- [ ] All agent files valid and runnable

## Error Handling

- Missing PRD file → Suggest running `/pm:prd-new` first
- Invalid project name → Provide naming guidelines
- Existing agents → Confirm overwrite or skip
- Template errors → Validate YAML frontmatter

## Next Steps

After generation:
1. Review generated agents for project fit
2. Customize agents if needed for specific requirements  
3. Run `/pm:epic-decompose {project}` to create tasks
4. Begin implementation with project-specific specialists

---

*Part of the CCPM Enhanced workflow - optimized for solo developers building 2025.*