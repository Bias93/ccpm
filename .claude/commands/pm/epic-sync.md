---
allowed-tools: Bash, Read, Write, LS, Task
---

# Epic Sync Enhanced 2025

Push epic and tasks to GitHub as issues with improved reliability and solo-dev optimizations.

## Usage
```
/pm:epic-sync <feature_name>
```

## Solo-Dev Enhancements

This enhanced version provides:
- **Robust error handling** with fail-fast approach
- **Smart labeling** for GitHub project management  
- **Sequential processing** for reliability over speed
- **Professional workflow** optimized for solo developers

## Quick Check

```bash
# Verify epic exists
test -f .claude/epics/$ARGUMENTS/epic.md || echo "❌ Epic not found. Run: /pm:prd-parse $ARGUMENTS"

# Count task files
ls .claude/epics/$ARGUMENTS/*.md 2>/dev/null | grep -v epic.md | wc -l
```

If no tasks found: "❌ No tasks to sync. Run: /pm:epic-decompose $ARGUMENTS"

## Instructions

### 1. Enhanced GitHub Authentication Check

```bash
# Robust authentication validation with clear error messages
echo "🔄 Starting GitHub sync for epic: $ARGUMENTS"

# Validate GitHub CLI authentication
if ! gh auth status >/dev/null 2>&1; then
  echo "❌ GitHub CLI not authenticated"
  echo "   Please run: gh auth login"
  echo "   Then retry: /pm:epic-sync $ARGUMENTS"
  exit 1
fi

# Get current repository info for validation
REPO_INFO=$(gh repo view --json nameWithOwner,name,owner -q '{nameWithOwner: .nameWithOwner, name: .name, owner: .owner.login}' 2>/dev/null) || {
  echo "❌ Not in a valid GitHub repository"
  echo "   Ensure you're in a repository with remote origin"
  exit 1
}

REPO_NAME=$(echo "$REPO_INFO" | jq -r '.nameWithOwner')
echo "✅ Authenticated for repository: $REPO_NAME"

# Get real current datetime for timestamps
CURRENT_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
```

### 2. Create Epic Issue with Professional Standards

Strip frontmatter and prepare GitHub issue body:
```bash
# Extract content without frontmatter
sed '1,/^---$/d; 1,/^---$/d' .claude/epics/$ARGUMENTS/epic.md > /tmp/epic-body-raw.md

# Remove "## Tasks Created" section and replace with Stats
awk '
  /^## Tasks Created/ { 
    in_tasks=1
    next
  }
  /^## / && in_tasks { 
    in_tasks=0
    # When we hit the next section after Tasks Created, add Stats
    if (total_tasks) {
      print "## Stats\n"
      print "Total tasks: " total_tasks
      print "Parallel tasks: " parallel_tasks " (can be worked on simultaneously)"
      print "Sequential tasks: " sequential_tasks " (have dependencies)"
      if (total_effort) print "Estimated total effort: " total_effort " hours"
      print ""
    }
  }
  /^Total tasks:/ && in_tasks { total_tasks = $3; next }
  /^Parallel tasks:/ && in_tasks { parallel_tasks = $3; next }
  /^Sequential tasks:/ && in_tasks { sequential_tasks = $3; next }
  /^Estimated total effort:/ && in_tasks { 
    gsub(/^Estimated total effort: /, "")
    total_effort = $0
    next 
  }
  !in_tasks { print }
  END {
    # If we were still in tasks section at EOF, add stats
    if (in_tasks && total_tasks) {
      print "## Stats\n"
      print "Total tasks: " total_tasks
      print "Parallel tasks: " parallel_tasks " (can be worked on simultaneously)"
      print "Sequential tasks: " sequential_tasks " (have dependencies)"
      if (total_effort) print "Estimated total effort: " total_effort
    }
  }
' /tmp/epic-body-raw.md > /tmp/epic-body.md

# Determine epic type (feature vs bug) from content
if grep -qi "bug\|fix\|issue\|problem\|error" /tmp/epic-body.md; then
  epic_type="bug"
else
  epic_type="feature"
fi

# Create epic issue with enhanced labels for solo-dev workflow
epic_number=$(gh issue create \
  --title "🚀 Epic: $ARGUMENTS" \
  --body-file /tmp/epic-body.md \
  --label "epic,solo-dev,enhancement,epic:$ARGUMENTS" \
  --json number -q .number) || {
  echo "❌ Failed to create epic issue"
  echo "   Check repository permissions and try again"
  exit 1
}
```

Store the returned issue number for epic frontmatter update.

### 3. Create Task Sub-Issues (Simplified & Reliable)

**Enhanced approach**: Sequential creation for maximum reliability:

```bash
echo "✅ Created epic issue: #$epic_number"
echo "🔄 Creating task sub-issues..."

# Count tasks for progress tracking
task_files=($(ls .claude/epics/$ARGUMENTS/[0-9][0-9][0-9].md 2>/dev/null))
task_count=${#task_files[@]}

if [ $task_count -eq 0 ]; then
  echo "⚠️ No tasks found to sync"
  echo "   Run: /pm:epic-decompose $ARGUMENTS"
  exit 1
fi

echo "   Processing $task_count tasks..."

# Sequential task creation with smart labeling and error handling
created_count=0
failed_count=0

> /tmp/task-mapping.txt  # Clear mapping file

for task_file in "${task_files[@]}"; do
  [ -f "$task_file" ] || continue
  
  # Extract task information from frontmatter
  task_name=$(grep '^name:' "$task_file" | sed 's/^name: *//')
  task_body=$(sed '1,/^---$/d; 1,/^---$/d' "$task_file")
  
  # Determine task type for smart labeling (solo-dev optimization)
  case "$task_name" in
    *"backend"*|*"api"*|*"server"*|*"database"*) task_type="backend" ;;
    *"frontend"*|*"ui"*|*"component"*|*"page"*) task_type="frontend" ;;
    *"test"*|*"spec"*|*"testing"*) task_type="testing" ;;
    *"deploy"*|*"ci"*|*"cd"*|*"infra"*) task_type="deployment" ;;
    *"docs"*|*"documentation"*) task_type="documentation" ;;
    *) task_type="general" ;;
  esac
  
  # Create task issue with enhanced labeling
  task_number=$(gh issue create \
    --title "$task_name" \
    --body "$task_body" \
    --label "task,solo-dev,$task_type,epic:$ARGUMENTS" \
    --json number -q .number 2>/dev/null) || {
    echo "   ❌ Failed to create: $task_name"
    failed_count=$((failed_count + 1))
    continue
  }
  
  # Success - record mapping and update file immediately
  echo "$task_file:$task_number" >> /tmp/task-mapping.txt
  
  # Update task file with GitHub URL and current timestamp  
  github_url="https://github.com/$REPO_NAME/issues/$task_number"
  
  # Create new file with issue number as filename
  new_file=".claude/epics/$ARGUMENTS/${task_number}.md"
  
  # Update frontmatter in new file
  sed "/^github:/c\github: $github_url" "$task_file" | \
  sed "/^updated:/c\updated: $CURRENT_DATE" > "$new_file"
  
  # Remove old file if different name
  [ "$task_file" != "$new_file" ] && rm "$task_file"
  
  created_count=$((created_count + 1))
  echo "   ✅ #$task_number: $task_name"
done

# Summary of task creation
if [ $created_count -eq $task_count ]; then
  echo "✅ All $created_count tasks created successfully"
elif [ $created_count -gt 0 ]; then
  echo "⚠️ Created $created_count/$task_count tasks ($failed_count failed)"
  echo "   You can manually retry failed tasks or continue"
else
  echo "❌ Failed to create any tasks"
  echo "   Check repository permissions and GitHub CLI authentication"
  exit 1
fi

### 4. Update Epic Frontmatter and Create Worktree

```bash
# Update epic frontmatter with GitHub URL and timestamp
echo "🔄 Updating epic frontmatter..."

epic_url="https://github.com/$REPO_NAME/issues/$epic_number"

# Update epic file frontmatter
sed -i.bak "/^github:/c\github: $epic_url" .claude/epics/$ARGUMENTS/epic.md
sed -i.bak "/^updated:/c\updated: $CURRENT_DATE" .claude/epics/$ARGUMENTS/epic.md
rm .claude/epics/$ARGUMENTS/epic.md.bak 2>/dev/null || true

echo "✅ Epic frontmatter updated"

# Create development worktree for solo-dev workflow
echo "🔄 Creating development worktree..."

# Ensure we're on main and up to date
git checkout main >/dev/null 2>&1 || {
  echo "⚠️ Could not switch to main branch"
  echo "   Current branch will be used as base"
}

git pull origin main >/dev/null 2>&1 || {
  echo "⚠️ Could not pull latest main"
  echo "   Using current branch state"
}

# Create worktree for epic development
if git worktree add "../epic-$ARGUMENTS" -b "epic/$ARGUMENTS" >/dev/null 2>&1; then
  echo "✅ Created worktree: ../epic-$ARGUMENTS"
  echo "   Branch: epic/$ARGUMENTS"
else
  echo "⚠️ Worktree may already exist or there was an issue"
  echo "   You can manually create it or use existing: ../epic-$ARGUMENTS"
fi

### 5. Solo-Dev Success Output

```bash
echo ""
echo "🚀 Epic Sync Complete (Enhanced 2025)!"
echo ""
echo "✅ GitHub Integration:"
echo "   Epic: #$epic_number - https://github.com/$REPO_NAME/issues/$epic_number"
echo "   Tasks: $created_count issues created with smart labels"
echo ""
echo "🏷️  Smart Labeling Applied:"
echo "   - epic, solo-dev, enhancement (epic level)"
echo "   - task, solo-dev, [type] (task level: backend/frontend/testing/deployment)"
echo ""
echo "📁 Development Environment:"
echo "   Worktree: ../epic-$ARGUMENTS"
echo "   Branch: epic/$ARGUMENTS"
echo ""
echo "💰 Cost-Effective Workflow Ready:"
echo "   - All issues properly labeled for GitHub Projects"
echo "   - Sequential processing for reliability"
echo "   - Professional standards maintained"
echo ""
echo "🚀 Next Steps:"
echo "   Start development: /pm:epic-start $ARGUMENTS"
echo "   Work on single task: /pm:issue-start [task_number]"
echo "   View epic: https://github.com/$REPO_NAME/issues/$epic_number"
```

## Enhanced Reliability Features

This improved sync process provides:

### Error Handling
- **Fail-fast authentication** checks before any operations
- **Individual task error handling** (continues on failures)
- **Clear error messages** with actionable guidance
- **Partial success handling** (reports what succeeded)

### Solo-Dev Optimizations
- **Smart labeling** for GitHub project management
- **Sequential processing** for maximum reliability  
- **Professional workflow** without complexity overhead
- **Cost-effective** approach (no premium tools required)

### Robustness Improvements
- **Real-time GitHub URL updates** in frontmatter
- **Immediate file renaming** after successful issue creation
- **Timestamp consistency** across all operations
- **Worktree integration** for development workflow

## Migration from Old epic-sync

The old approach had these issues:
- ❌ Complex parallel agents prone to failures
- ❌ Weak error handling leaving partial state
- ❌ gh-sub-issue dependency
- ❌ Complex file renaming process

This enhanced version:
- ✅ Sequential processing for reliability
- ✅ Robust error handling with clear messages
- ✅ No external dependencies beyond GitHub CLI
- ✅ Immediate updates prevent inconsistent state
- ✅ Smart labeling for solo-dev project management

#### 5b. Update Tasks Created Section
```bash
# Create a temporary file with the updated Tasks Created section
cat > /tmp/tasks-section.md << 'EOF'
## Tasks Created
EOF

# Add each task with its real issue number
for task_file in .claude/epics/$ARGUMENTS/[0-9]*.md; do
  [ -f "$task_file" ] || continue
  
  # Get issue number (filename without .md)
  issue_num=$(basename "$task_file" .md)
  
  # Get task name from frontmatter
  task_name=$(grep '^name:' "$task_file" | sed 's/^name: *//')
  
  # Get parallel status
  parallel=$(grep '^parallel:' "$task_file" | sed 's/^parallel: *//')
  
  # Add to tasks section
  echo "- [ ] #${issue_num} - ${task_name} (parallel: ${parallel})" >> /tmp/tasks-section.md
done

# Add summary statistics
total_count=$(ls .claude/epics/$ARGUMENTS/[0-9]*.md 2>/dev/null | wc -l)
parallel_count=$(grep -l '^parallel: true' .claude/epics/$ARGUMENTS/[0-9]*.md 2>/dev/null | wc -l)
sequential_count=$((total_count - parallel_count))

cat >> /tmp/tasks-section.md << EOF

Total tasks: ${total_count}
Parallel tasks: ${parallel_count}
Sequential tasks: ${sequential_count}
EOF

# Replace the Tasks Created section in epic.md
# First, create a backup
cp .claude/epics/$ARGUMENTS/epic.md .claude/epics/$ARGUMENTS/epic.md.backup

# Use awk to replace the section
awk '
  /^## Tasks Created/ { 
    skip=1
    while ((getline line < "/tmp/tasks-section.md") > 0) print line
    close("/tmp/tasks-section.md")
  }
  /^## / && !/^## Tasks Created/ { skip=0 }
  !skip && !/^## Tasks Created/ { print }
' .claude/epics/$ARGUMENTS/epic.md.backup > .claude/epics/$ARGUMENTS/epic.md

# Clean up
rm .claude/epics/$ARGUMENTS/epic.md.backup
rm /tmp/tasks-section.md
```

### 6. Create Mapping File

Create `.claude/epics/$ARGUMENTS/github-mapping.md`:
```bash
# Create mapping file
cat > .claude/epics/$ARGUMENTS/github-mapping.md << EOF
# GitHub Issue Mapping

Epic: #${epic_number} - https://github.com/${repo}/issues/${epic_number}

Tasks:
EOF

# Add each task mapping
for task_file in .claude/epics/$ARGUMENTS/[0-9]*.md; do
  [ -f "$task_file" ] || continue
  
  issue_num=$(basename "$task_file" .md)
  task_name=$(grep '^name:' "$task_file" | sed 's/^name: *//')
  
  echo "- #${issue_num}: ${task_name} - https://github.com/${repo}/issues/${issue_num}" >> .claude/epics/$ARGUMENTS/github-mapping.md
done

# Add sync timestamp
echo "" >> .claude/epics/$ARGUMENTS/github-mapping.md
echo "Synced: $(date -u +"%Y-%m-%dT%H:%M:%SZ")" >> .claude/epics/$ARGUMENTS/github-mapping.md
```

### 7. Create Worktree

Follow `/rules/worktree-operations.md` to create development worktree:

```bash
# Ensure main is current
git checkout main
git pull origin main

# Create worktree for epic
git worktree add ../epic-$ARGUMENTS -b epic/$ARGUMENTS

echo "✅ Created worktree: ../epic-$ARGUMENTS"
```

### 8. Output

```
✅ Synced to GitHub
  - Epic: #{epic_number} - {epic_title}
  - Tasks: {count} sub-issues created
  - Labels applied: epic, task, epic:{name}
  - Files renamed: 001.md → {issue_id}.md
  - References updated: depends_on/conflicts_with now use issue IDs
  - Worktree: ../epic-$ARGUMENTS

Next steps:
  - Start parallel execution: /pm:epic-start $ARGUMENTS
  - Or work on single issue: /pm:issue-start {issue_number}
  - View epic: https://github.com/{owner}/{repo}/issues/{epic_number}
```

## Error Handling

Follow `/rules/github-operations.md` for GitHub CLI errors.

If any issue creation fails:
- Report what succeeded
- Note what failed
- Don't attempt rollback (partial sync is fine)

## Important Notes

- Trust GitHub CLI authentication
- Don't pre-check for duplicates
- Update frontmatter only after successful creation
- Keep operations simple and atomic