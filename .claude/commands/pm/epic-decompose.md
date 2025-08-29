---
allowed-tools: Bash, Read, Write, LS, Task, WebSearch, mcp__context7__resolve-library-id, mcp__context7__get-library-docs
---

# Epic Decompose

Break epic into concrete, actionable tasks optimized for solo developers.

## Usage
```
/pm:epic-decompose <feature_name>
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- `.claude/rules/datetime.md` - For getting real current date/time
- Tech stack validation with WebSearch for 2025 versions

## Preflight Checklist

Before proceeding, complete these validation steps:

1. **Verify epic exists:**
   - Check if `.claude/epics/$ARGUMENTS/epic.md` exists
   - If not found, tell user: "❌ Epic not found: $ARGUMENTS. First create it with: /pm:prd-parse $ARGUMENTS"
   - Stop execution if epic doesn't exist

2. **Check for existing tasks:**
   - Check if any numbered task files (001.md, 002.md, etc.) already exist in `.claude/epics/$ARGUMENTS/`
   - If tasks exist, list them and ask: "⚠️ Found {count} existing tasks. Delete and recreate all tasks? (yes/no)"
   - Only proceed with explicit 'yes' confirmation
   - If user says no, suggest: "View existing tasks with: /pm:epic-show $ARGUMENTS"

3. **Validate epic frontmatter:**
   - Verify epic has valid frontmatter with: name, status, created, prd
   - If invalid, tell user: "❌ Invalid epic frontmatter. Please check: .claude/epics/$ARGUMENTS/epic.md"

4. **Check epic status:**
   - If epic status is already "completed", warn user: "⚠️ Epic is marked as completed. Are you sure you want to decompose it again?"

## Instructions

You are decomposing an epic into specific, actionable tasks for: **$ARGUMENTS**

### 1. Read the Epic
- Load the epic from `.claude/epics/$ARGUMENTS/epic.md`
- Understand the technical approach and requirements
- Review the task breakdown preview

### 2. Prepare for Task Creation

```bash
# Get current timestamp for all operations
CURRENT_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "Starting epic-decompose at: $CURRENT_DATE"
```

### 3. Create Tasks Using Project-Specific Agents

**Use project-specific agents created by agent-generate:**

Before decomposing tasks, verify that project-specific agents exist:
- Check for agents in `.claude/agents/{project-name}-*-specialist.md`
- If not found, suggest running: `/pm:agent-generate $ARGUMENTS` first

**Task Creation Strategy:**
```yaml
# Backend Tasks (using project-specific agent)
Task:
  description: "Design backend architecture tasks"
  subagent_type: "{project-name}-backend-specialist"  # Project-specific agent
  prompt: |
    Create backend tasks for epic: $ARGUMENTS
    
    You have full context of this project's:
    - Technology stack decisions
    - Architecture patterns
    - Requirements from PRD
    
    Solo-Dev Strategy:
    - Use the established project stack
    - Follow the project's architectural decisions
    - Focus on rapid development with your known tools
    - Leverage the cost-effective choices already made
    
    Return: Backend task specifications with:
    - Task name and description
    - Implementation approach using project stack
    - Dependencies and order
    - Estimated effort (XS/S/M/L/XL)
    - Project-specific considerations

# Frontend Tasks (using project-specific agent)  
Task:
  description: "Design frontend development tasks"
  subagent_type: "{project-name}-frontend-specialist"  # Project-specific agent
  prompt: |
    Create frontend tasks for epic: $ARGUMENTS
    
    You understand this project's:
    - UI framework and component choices
    - Design system decisions
    - User experience requirements
    
    Solo-Dev Frontend Strategy:
    - Use the project's chosen UI framework
    - Follow established component patterns
    - Implement the specific UX requirements
    - Optimize for the project's target users
    
    Return: Frontend task specifications with:
    - Component/page/feature breakdown using project stack
    - User experience based on project requirements
    - Performance requirements for project scope
    - Accessibility requirements
    - Mobile responsiveness for project target

# Data Tasks (using project-specific agent)
Task:
  description: "Design data layer tasks"
  subagent_type: "{project-name}-data-specialist"  # Project-specific agent
  prompt: |
    Create data tasks for epic: $ARGUMENTS
    
    You know this project's:
    - Database technology choice
    - Schema patterns and relationships
    - Data requirements from PRD
    
    Solo-Dev Data Strategy:
    - Use the project's chosen database solution
    - Follow established schema patterns
    - Implement the specific data requirements
    - Optimize for the project's scale and usage
    
    Return: Data task specifications with:
    - Schema design using project database
    - Migration strategy for project
    - Data validation and relationships
    - Performance considerations for project scale

# Testing Strategy Tasks (using project-specific agent)
Task:
  description: "Plan comprehensive testing strategy"
  subagent_type: "{project-name}-testing-specialist"  # Project-specific agent
  prompt: |
    Create testing tasks for epic: $ARGUMENTS
    
    You understand this project's:
    - Testing framework choices
    - Quality requirements
    - Critical user paths
    
    Solo-Dev Testing Strategy:
    - Use the project's testing stack
    - Focus on the project's critical paths
    - Balance coverage with development speed for this project
    - Test the project's specific business logic
    
    Return: Testing task specifications with:
    - Test strategy using project testing stack
    - Coverage for project-specific features
    - CI/CD integration with project pipeline
    - Performance testing for project requirements

# Setup Tasks (using project-specific agent)
Task:
  description: "Design project setup and configuration tasks"
  subagent_type: "{project-name}-setup-specialist"  # Project-specific agent
  prompt: |
    Create setup tasks for epic: $ARGUMENTS
    
    You know this project's:
    - Technology stack and versions
    - Configuration requirements
    - Development environment needs
    
    Solo-Dev Setup Strategy:
    - Configure the project's chosen stack
    - Set up the specific tools and dependencies
    - Prepare the development environment for this project
    - Ensure consistency with project decisions
    
    Return: Setup task specifications with:
    - Environment configuration for project stack
    - Dependency installation and setup
    - Configuration files for project needs
    - Development workflow setup

# Deployment Tasks (using project-specific agent)
Task:
  description: "Design deployment and infrastructure tasks"
  subagent_type: "{project-name}-deployment-specialist"  # Project-specific agent
  prompt: |
    Create deployment tasks for epic: $ARGUMENTS
    
    You understand this project's:
    - Deployment target and strategy
    - Infrastructure requirements
    - Monitoring and maintenance needs
    
    Solo-Dev Deployment Strategy:
    - Use the project's chosen hosting/deployment solution
    - Implement the project's infrastructure requirements
    - Set up monitoring for project-specific metrics
    - Optimize costs for project scale
    
    Return: Deployment task specifications with:
    - CI/CD setup for project stack
    - Infrastructure configuration for project needs
    - Monitoring and logging for project requirements
    - Deployment strategy for project scale
```

### 4. Task File Format with Frontmatter
For each task, create a file with this exact structure:

```markdown
---
name: [Task Title]
status: open
created: [Current ISO date/time]
updated: [Current ISO date/time]
github: [Will be updated when synced to GitHub]
depends_on: []  # List of task numbers this depends on, e.g., [001, 002]
parallel: true  # Can this run in parallel with other tasks?
conflicts_with: []  # Tasks that modify same files, e.g., [003, 004]
subagent_type: {project-name}-{role}-specialist  # Project-specific agent to handle this task
subagent_context: |  # Project context for the agent
  Project Stack: [Include stack from agent-generate]
  Key Requirements: [Relevant PRD requirements]
  Implementation Notes: [Task-specific guidance]
---

# Task: [Task Title]

## Description
Clear, concise description of what needs to be done

## Acceptance Criteria
- [ ] Specific criterion 1
- [ ] Specific criterion 2
- [ ] Specific criterion 3

## Technical Details
- Implementation approach
- Key considerations
- Code locations/files affected

## Dependencies
- [ ] Task/Issue dependencies
- [ ] External dependencies

## Effort Estimate
- Size: XS/S/M/L/XL
- Hours: estimated hours
- Parallel: true/false (can run in parallel with other tasks)

## Definition of Done
- [ ] Code implemented
- [ ] Tests written and passing
- [ ] Documentation updated
- [ ] Code reviewed
- [ ] Deployed to staging
```

### 3. Task Naming Convention
Save tasks as: `.claude/epics/$ARGUMENTS/{task_number}.md`
- Use sequential numbering: 001.md, 002.md, etc.
- Keep task titles short but descriptive

### 4. Frontmatter Guidelines
- **name**: Use a descriptive task title (without "Task:" prefix)
- **status**: Always start with "open" for new tasks
- **created**: Get REAL current datetime by running: `date -u +"%Y-%m-%dT%H:%M:%SZ"`
- **updated**: Use the same real datetime as created for new tasks
- **github**: Leave placeholder text - will be updated during sync
- **depends_on**: List task numbers that must complete before this can start (e.g., [001, 002])
- **parallel**: Set to true if this can run alongside other tasks without conflicts
- **conflicts_with**: List task numbers that modify the same files (helps coordination)

### 5. Task Types to Consider
- **Setup tasks**: Environment, dependencies, scaffolding
- **Data tasks**: Models, schemas, migrations
- **API tasks**: Endpoints, services, integration
- **UI tasks**: Components, pages, styling
- **Testing tasks**: Unit tests, integration tests
- **Documentation tasks**: README, API docs
- **Deployment tasks**: CI/CD, infrastructure

### 6. Parallelization
Mark tasks with `parallel: true` if they can be worked on simultaneously without conflicts.

### 7. Execution Strategy

Choose based on task count and complexity:

**Small Epic (< 5 tasks)**: Create sequentially for simplicity

**Medium Epic (5-10 tasks)**: 
- Batch into 2-3 groups
- Spawn agents for each batch
- Consolidate results

**Large Epic (> 10 tasks)**:
- Analyze dependencies first
- Group independent tasks
- Launch parallel agents (max 5 concurrent)
- Create dependent tasks after prerequisites

Example for parallel execution:
```markdown
Spawning 3 agents for parallel task creation:
- Agent 1: Creating tasks 001-003 (Database layer)
- Agent 2: Creating tasks 004-006 (API layer)
- Agent 3: Creating tasks 007-009 (UI layer)
```

### 8. Task Dependency Validation

When creating tasks with dependencies:
- Ensure referenced dependencies exist (e.g., if Task 003 depends on Task 002, verify 002 was created)
- Check for circular dependencies (Task A → Task B → Task A)
- If dependency issues found, warn but continue: "⚠️ Task dependency warning: {details}"

### 9. Update Epic with Task Summary
After creating all tasks, update the epic file by adding this section:
```markdown
## Tasks Created
- [ ] 001.md - {Task Title} (parallel: true/false)
- [ ] 002.md - {Task Title} (parallel: true/false)
- etc.

Total tasks: {count}
Parallel tasks: {parallel_count}
Sequential tasks: {sequential_count}
Estimated total effort: {sum of hours}
```

Also update the epic's frontmatter progress if needed (still 0% until tasks actually start).

### 9. Quality Validation

Before finalizing tasks, verify:
- [ ] All tasks have clear acceptance criteria
- [ ] Task sizes are reasonable (1-3 days each)
- [ ] Dependencies are logical and achievable
- [ ] Parallel tasks don't conflict with each other
- [ ] Combined tasks cover all epic requirements

### 10. Post-Decomposition

After successfully creating tasks:
1. Confirm: "✅ Created {count} tasks for epic: $ARGUMENTS"
2. Show summary:
   - Total tasks created
   - Parallel vs sequential breakdown
   - Total estimated effort
3. Suggest next step: "Ready to sync to GitHub? Run: /pm:epic-sync $ARGUMENTS"

## Error Recovery

If any step fails:
- If task creation partially completes, list which tasks were created
- Provide option to clean up partial tasks
- Never leave the epic in an inconsistent state

Aim for tasks that can be completed in 1-3 days each. Break down larger tasks into smaller, manageable pieces for the "$ARGUMENTS" epic.
