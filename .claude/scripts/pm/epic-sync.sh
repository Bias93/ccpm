#!/bin/bash

# CCPM Epic Sync Script - Fixed Version 2025
# Pushes epic and tasks to GitHub as issues with improved reliability

set -euo pipefail

EPIC_NAME="$1"

if [ -z "$EPIC_NAME" ]; then
    echo "Usage: $0 <epic_name>"
    exit 1
fi

echo "🔄 Starting GitHub sync for epic: $EPIC_NAME"

# Validate GitHub CLI authentication
if ! gh auth status >/dev/null 2>&1; then
    echo "❌ GitHub CLI not authenticated"
    echo "   Please run: gh auth login"
    exit 1
fi

# Get repository name
REPO_NAME=$(gh repo view --json nameWithOwner -q '.nameWithOwner' 2>/dev/null) || {
    echo "❌ Not in a valid GitHub repository"
    echo "   Ensure you're in a repository with remote origin"
    exit 1
}

echo "✅ Authenticated for repository: $REPO_NAME"

# Check epic exists
EPIC_FILE=".claude/epics/$EPIC_NAME/epic.md"
if [ ! -f "$EPIC_FILE" ]; then
    echo "❌ Epic not found: $EPIC_FILE"
    echo "   Run: /pm:prd-parse $EPIC_NAME"
    exit 1
fi

# Get current timestamp
CURRENT_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Create epic issue
echo "🔄 Creating epic issue..."

# Extract content without frontmatter
sed '1,/^---$/d; 1,/^---$/d' "$EPIC_FILE" > /tmp/epic-body.md

# Create epic issue
EPIC_NUMBER=$(gh issue create \
    --title "🚀 Epic: $EPIC_NAME" \
    --body-file /tmp/epic-body.md \
    --label "epic,solo-dev,enhancement,epic:$EPIC_NAME" \
    --json number -q .number)

echo "✅ Created epic issue: #$EPIC_NUMBER"

# Update epic frontmatter
EPIC_URL="https://github.com/$REPO_NAME/issues/$EPIC_NUMBER"
cp "$EPIC_FILE" "$EPIC_FILE.bak"

if grep -q '^github:' "$EPIC_FILE"; then
    sed -i "s|^github:.*|github: $EPIC_URL|" "$EPIC_FILE"
else
    sed -i "/^---$/a\\github: $EPIC_URL" "$EPIC_FILE"
fi

if grep -q '^updated:' "$EPIC_FILE"; then
    sed -i "s/^updated:.*/updated: $CURRENT_DATE/" "$EPIC_FILE"
else
    sed -i "/^---$/a\\updated: $CURRENT_DATE" "$EPIC_FILE"
fi

rm "$EPIC_FILE.bak"

# Process tasks
echo "🔄 Creating task sub-issues..."

TASK_COUNT=0
CREATED_COUNT=0
FAILED_COUNT=0

# Count tasks
for task_file in ".claude/epics/$EPIC_NAME/"[0-9][0-9][0-9].md; do
    [ -f "$task_file" ] && TASK_COUNT=$((TASK_COUNT + 1))
done

if [ $TASK_COUNT -eq 0 ]; then
    echo "⚠️ No tasks found to sync"
    echo "   Run: /pm:epic-decompose $EPIC_NAME"
    exit 1
fi

echo "   Processing $TASK_COUNT tasks..."

# Create each task issue
for task_file in ".claude/epics/$EPIC_NAME/"[0-9][0-9][0-9].md; do
    [ -f "$task_file" ] || continue
    
    # Extract task name from frontmatter
    TASK_NAME=$(grep '^name:' "$task_file" | head -1 | sed 's/^name: *//')
    
    # Extract task body without frontmatter
    sed '1,/^---$/d; 1,/^---$/d' "$task_file" > /tmp/task-body.md
    
    # Determine task type for labeling
    TASK_TYPE="general"
    case "$TASK_NAME" in
        *backend*|*api*|*server*|*database*) TASK_TYPE="backend" ;;
        *frontend*|*ui*|*component*|*page*) TASK_TYPE="frontend" ;;
        *test*|*spec*|*testing*) TASK_TYPE="testing" ;;
        *deploy*|*ci*|*cd*|*infra*) TASK_TYPE="deployment" ;;
        *docs*|*documentation*) TASK_TYPE="documentation" ;;
    esac
    
    # Create task issue as sub-issue of epic using gh-sub-issue extension
    TASK_NUMBER=$(gh sub-issue $EPIC_NUMBER \
        --title "$TASK_NAME" \
        --body-file /tmp/task-body.md \
        --label "task,solo-dev,$TASK_TYPE,epic:$EPIC_NAME" \
        --json number -q .number 2>/dev/null) || {
        echo "   ❌ Failed to create: $TASK_NAME"
        FAILED_COUNT=$((FAILED_COUNT + 1))
        continue
    }
    
    # Update task file with GitHub info
    TASK_URL="https://github.com/$REPO_NAME/issues/$TASK_NUMBER"
    NEW_FILE=".claude/epics/$EPIC_NAME/${TASK_NUMBER}.md"
    
    # Copy and update frontmatter
    cp "$task_file" "$NEW_FILE"
    
    if grep -q '^github:' "$NEW_FILE"; then
        sed -i "s|^github:.*|github: $TASK_URL|" "$NEW_FILE"
    else
        sed -i "/^---$/a\\github: $TASK_URL" "$NEW_FILE"
    fi
    
    if grep -q '^updated:' "$NEW_FILE"; then
        sed -i "s/^updated:.*/updated: $CURRENT_DATE/" "$NEW_FILE"
    else
        sed -i "/^---$/a\\updated: $CURRENT_DATE" "$NEW_FILE"
    fi
    
    # Remove old file if different name
    [ "$task_file" != "$NEW_FILE" ] && rm "$task_file"
    
    CREATED_COUNT=$((CREATED_COUNT + 1))
    echo "   ✅ #$TASK_NUMBER: $TASK_NAME"
done

# Create worktree
echo "🔄 Creating development worktree..."

git checkout main >/dev/null 2>&1 || {
    echo "⚠️ Could not switch to main branch"
}

git pull origin main >/dev/null 2>&1 || {
    echo "⚠️ Could not pull latest main"
}

if git worktree add "../epic-$EPIC_NAME" -b "epic/$EPIC_NAME" >/dev/null 2>&1; then
    echo "✅ Created worktree: ../epic-$EPIC_NAME"
else
    echo "⚠️ Worktree may already exist: ../epic-$EPIC_NAME"
fi

# Final summary
echo ""
echo "🚀 Epic Sync Complete!"
echo ""
echo "✅ GitHub Integration:"
echo "   Epic: #$EPIC_NUMBER - $EPIC_URL"
echo "   Tasks: $CREATED_COUNT/$TASK_COUNT issues created"
[ $FAILED_COUNT -gt 0 ] && echo "   Failed: $FAILED_COUNT tasks"
echo ""
echo "📁 Development Environment:"
echo "   Worktree: ../epic-$EPIC_NAME"
echo "   Branch: epic/$EPIC_NAME"
echo ""
echo "🚀 Next Steps:"
echo "   Start development: /pm:epic-start $EPIC_NAME"
echo "   View epic: $EPIC_URL"

# Cleanup
rm -f /tmp/epic-body.md /tmp/task-body.md