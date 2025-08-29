---
allowed-tools: Bash, Read, Write, LS, Task
---

# Epic Oneshot

Complete epic workflow: decompose into tasks and sync to GitHub in one operation.
Optimized for solo developers with professional standards.

## Usage
```
/pm:epic-oneshot <feature_name>
```

## Instructions

This streamlined workflow now leverages the new CCPM project-specific agent system.

### 0. Initialize and Validate

```bash
# Get current date for timestamp
CURRENT_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "Starting epic-oneshot at: $CURRENT_DATE"

# Epic must exist
test -f .claude/epics/$ARGUMENTS/epic.md || {
  echo "❌ Epic not found. Run: /pm:prd-parse $ARGUMENTS"
  exit 1
}

# Check for existing tasks
if ls .claude/epics/$ARGUMENTS/[0-9]*.md 2>/dev/null | grep -q .; then
  echo "⚠️ Tasks already exist. This will overwrite them."
  echo "Continue? (yes/no)"
  read -r response
  [ "$response" != "yes" ] && exit 1
fi
```

### 1. Task Decomposition

**Run epic-decompose to create tasks:**

```bash
echo "🔄 Decomposing epic into tasks..."

# Check if project-specific agents exist (optional, for better task assignment)
if ls .claude/agents/$ARGUMENTS-*-specialist.md 2>/dev/null | grep -q .; then
  echo "✅ Project-specific agents found - tasks will be assigned to them"
else
  echo "ℹ️ No project-specific agents - using generic assignments"
  echo "   TIP: Run '/pm:agent-generate $ARGUMENTS' first for better results"
fi

# Decompose epic into tasks using task-planner agent
/pm:epic-decompose $ARGUMENTS

# Verify decomposition succeeded
if [ $? -ne 0 ]; then
  echo "❌ Epic decomposition failed"
  exit 1
fi

echo "✅ Tasks created successfully"
```

### 3. Professional GitHub Sync (Simplified)

**Enhanced reliability with better error handling:**

```bash
# Robust sync approach - fail fast, clear messages
echo "🔄 Syncing to GitHub with professional workflow..."

# 1. Validate GitHub connection
gh auth status || {
  echo "❌ GitHub CLI not authenticated"
  echo "Run: gh auth login"
  exit 1
}

# 2. Create epic issue with proper labeling
epic_body=$(sed '1,/^---$/d; 1,/^---$/d' .claude/epics/$ARGUMENTS/epic.md)
epic_number=$(gh issue create \
  --title "🚀 Epic: $ARGUMENTS" \
  --body "$epic_body" \
  --label "epic,solo-dev,enhancement" \
  --json number -q .number) || {
  echo "❌ Failed to create epic issue"
  exit 1
}

echo "✅ Created epic: #$epic_number"

# 3. Create task sub-issues (sequential for reliability)
task_count=0
for task_file in .claude/epics/$ARGUMENTS/[0-9][0-9][0-9].md; do
  [ -f "$task_file" ] || continue
  
  task_name=$(grep '^name:' "$task_file" | sed 's/^name: *//')
  task_body=$(sed '1,/^---$/d; 1,/^---$/d' "$task_file")
  
  # Determine task type for proper labeling
  case "$task_name" in
    *"backend"*|*"api"*|*"server"*) task_type="backend" ;;
    *"frontend"*|*"ui"*|*"component"*) task_type="frontend" ;;
    *"test"*|*"spec"*) task_type="testing" ;;
    *"deploy"*|*"ci"*|*"cd"*) task_type="deployment" ;;
    *) task_type="general" ;;
  esac
  
  task_number=$(gh issue create \
    --title "$task_name" \
    --body "$task_body" \
    --label "task,solo-dev,$task_type" \
    --json number -q .number) || {
    echo "⚠️ Failed to create task: $task_name"
    continue
  }
  
  # Update task file with GitHub URL immediately
  repo=$(gh repo view --json nameWithOwner -q .nameWithOwner)
  github_url="https://github.com/$repo/issues/$task_number"
  
  # Rename file to issue number and update frontmatter
  new_file=".claude/epics/$ARGUMENTS/${task_number}.md"
  sed "/^github:/c\github: $github_url" "$task_file" > "$new_file"
  sed -i "/^updated:/c\updated: $CURRENT_DATE" "$new_file"
  
  [ "$task_file" != "$new_file" ] && rm "$task_file"
  
  task_count=$((task_count + 1))
  echo "✅ Created task #$task_number: $task_name"
done

# 4. Update epic with GitHub URL
repo=$(gh repo view --json nameWithOwner -q .nameWithOwner)
epic_url="https://github.com/$repo/issues/$epic_number"
sed -i "/^github:/c\github: $epic_url" .claude/epics/$ARGUMENTS/epic.md
sed -i "/^updated:/c\updated: $CURRENT_DATE" .claude/epics/$ARGUMENTS/epic.md

# 5. Create development worktree
git worktree add ../epic-$ARGUMENTS -b epic/$ARGUMENTS 2>/dev/null || {
  echo "⚠️ Worktree may already exist: ../epic-$ARGUMENTS"
}

echo "✅ GitHub sync complete: $task_count tasks created"
```

### 4. Solo-Dev Output (Enhanced)

```
🚀 Epic Oneshot Complete (2025 Tech Stack): $ARGUMENTS

✅ Tech Stack Validation:
  - Next.js: 15.5+ ✓ (App Router, Server Actions)
  - React: 19.1+ ✓ (Server Components)
  - TypeScript: 5.7+ ✓ (strict mode)
  - Node.js: 22 LTS ✓

✅ Smart Decomposition:
  - Backend tasks: {backend_count} (serverless-ready)
  - Frontend tasks: {frontend_count} (responsive, accessible)
  - Testing tasks: {test_count} (essential coverage)
  - Total estimated effort: {total_hours}h

✅ GitHub Sync:
  - Epic: #{epic_number} 
  - Tasks: {task_count} issues created with smart labels
  - Worktree: ../epic-$ARGUMENTS (ready for development)

💰 Cost-Effective Stack:
  - Hosting: Vercel/Netlify (free tier)
  - UI: shadcn/ui + Tailwind CSS (no license fees)
  - Icons: Lucide React (free, tree-shakeable)
  - Testing: Vitest + Playwright (fast, minimal setup)

🚀 Ready for Solo Development:
  Start work: /pm:epic-start $ARGUMENTS
  Single task: /pm:issue-start {task_number}
  
  Epic URL: {github_epic_url}
```

## CCPM Solo-Dev Philosophy

This enhanced workflow embodies the CCPM principles for solo developers:

### Professional Standards, Economical Approach
- **Latest tech stack** (2025 versions) for future-proofing
- **Free/open-source tools** to minimize costs
- **Proven patterns** to reduce risk
- **Minimal dependencies** to reduce maintenance burden

### Solo-Dev Optimizations
- **Sequential task creation** (reliable vs. parallel complexity)
- **Smart labeling** for easy GitHub project management
- **Domain expert agents** instead of generic parallel workers
- **Fail-fast validation** to catch issues early

### Speed to Market
- **Serverless-first** approach (no infrastructure management)
- **Built-in solutions** over third-party libraries
- **Essential testing** (comprehensive but not gold-plated)
- **Immediate deployment readiness** (Vercel/Netlify compatible)

## Migration from Old epic-oneshot

The old approach had these issues:
- ❌ Generic `parallel-worker` caused empty/broken tasks
- ❌ Outdated tech versions (Next.js 14 vs 15.5)
- ❌ Complex GitHub sync prone to failures
- ❌ No validation of current tech versions

This enhanced version:
- ✅ Domain expert agents (`backend-architect`, `frontend-developer`)
- ✅ Real-time tech stack validation with WebSearch
- ✅ Simplified, robust GitHub sync
- ✅ Solo-dev cost optimization built-in

## Usage Recommendation

Use `/pm:epic-oneshot` when:
- Epic is well-defined and ready for implementation
- You want to leverage 2025 modern tech stack
- Solo-dev cost efficiency is important  
- You need reliable GitHub issue creation

For complex epics requiring iteration, use the separate commands:
1. `/pm:epic-decompose` (with tech validation)
2. Review and adjust tasks
3. `/pm:epic-sync` (with enhanced reliability)