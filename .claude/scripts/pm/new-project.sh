#!/bin/bash

# New Project Setup Script
# Usage: bash .claude/scripts/pm/new-project.sh <project-name> <github-username> <user-email> <user-name> [--from-idea <idea-file>]

PROJECT_NAME="$1"
GITHUB_USERNAME="$2"
USER_EMAIL="$3"
USER_NAME="$4"

# Parse optional --from-idea flag
IDEA_FILE=""
if [ "$5" = "--from-idea" ] && [ -n "$6" ]; then
    IDEA_FILE="$6"
fi

# Validation
if [ -z "$PROJECT_NAME" ] || [ -z "$GITHUB_USERNAME" ] || [ -z "$USER_EMAIL" ] || [ -z "$USER_NAME" ]; then
    echo "❌ Usage: /pm:new-project <project-name> <github-username> <user-email> <user-name> [--from-idea <idea-file>]"
    echo "   Example: /pm:new-project my-app davide123 davide@example.com \"Davide Rossi\""
    echo "   With idea: /pm:new-project my-app davide123 davide@example.com \"Davide Rossi\" --from-idea IDEA.md"
    exit 1
fi

# Validate idea file if provided
if [ -n "$IDEA_FILE" ]; then
    if [ ! -f "$IDEA_FILE" ]; then
        echo "❌ Idea file not found: $IDEA_FILE"
        exit 1
    fi
    if [ ! -r "$IDEA_FILE" ]; then
        echo "❌ Cannot read idea file: $IDEA_FILE"
        exit 1
    fi
fi

# Validate project name
if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "❌ Project name must be alphanumeric with dashes/underscores only"
    exit 1
fi

# Validate email format
if [[ ! "$USER_EMAIL" =~ ^[^@]+@[^@]+\.[^@]+$ ]]; then
    echo "❌ Please provide a valid email address"
    exit 1
fi

echo "🚀 Setting up new project: $PROJECT_NAME"
if [ -n "$IDEA_FILE" ]; then
    echo "🧠 Using idea from: $IDEA_FILE"
fi
echo "=================================="
echo ""

# 1. Setup Git Config
echo "⚙️ Checking git identity..."
if ! git config user.email &>/dev/null || ! git config user.name &>/dev/null; then
    echo "  📝 Setting git identity for this project..."
    git config user.email "$USER_EMAIL"
    git config user.name "$USER_NAME"
    echo "  ✅ Git identity set: $USER_NAME <$USER_EMAIL>"
else
    current_email=$(git config user.email)
    current_name=$(git config user.name)
    echo "  ✅ Using existing git identity: $current_name <$current_email>"
fi

# 2. Fix Git Remote
echo ""
echo "🔗 Configuring git remote..."
if git remote get-url origin &>/dev/null; then
    git remote remove origin
    echo "  🗑️ Removed CCPM remote"
fi

git remote add origin "https://github.com/$GITHUB_USERNAME/$PROJECT_NAME.git"
echo "  ✅ Remote set to: https://github.com/$GITHUB_USERNAME/$PROJECT_NAME.git"

# 3. Update README placeholders
echo ""
echo "📝 Updating project files..."
if [ -f "README.md" ]; then
    sed -i "s/TUO-USERNAME/$GITHUB_USERNAME/g" README.md
    sed -i "s/my-new-project/$PROJECT_NAME/g" README.md
    echo "  ✅ README.md updated with your details"
fi

# 4. Initialize CCPM System  
echo ""
echo "🛠️ Initializing CCPM system..."
if bash .claude/scripts/pm/init.sh; then
    echo "  ✅ CCPM system initialized successfully"
else
    echo "  ⚠️ CCPM initialization had some issues - check output above"
fi

# 5. Process Idea File (if provided)
if [ -n "$IDEA_FILE" ]; then
    echo ""
    echo "🧠 Processing idea file..."
    
    # Create PRD directory if it doesn't exist
    mkdir -p .claude/prds
    
    # Read idea file content
    IDEA_CONTENT=$(cat "$IDEA_FILE")
    
    # Create project-foundation PRD based on template and idea
    cat > .claude/prds/project-foundation.md << EOF
---
name: $PROJECT_NAME Foundation
type: project-foundation
status: draft
priority: high
author: $USER_NAME
created: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
updated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
---

# $PROJECT_NAME - Project Foundation

## Original Idea

$IDEA_CONTENT

## Project Vision

**What is this project?**
[Based on the idea above, define what this project will become]

**Why does this project exist?**
[Problem being solved or opportunity being addressed based on the idea]

**What success looks like?**
[Clear success metrics and outcomes]

## Core Features

**MVP Feature Set:**
[Extract key features from the original idea]
1. [Essential feature 1]
2. [Essential feature 2] 
3. [Essential feature 3]

**Future Features (Post-MVP):**
[Additional ideas for later development]
- [Feature for later]
- [Feature for later]

## Technical Foundation

**Architecture Decisions:**
[To be determined based on requirements]
- Frontend: [React/Vue/Angular/Vanilla]
- Backend: [Node.js/Python/Go/etc]
- Database: [PostgreSQL/MongoDB/SQLite]
- Deployment: [Vercel/AWS/Docker]

## Success Criteria

**Technical Metrics:**
- [ ] Project builds successfully
- [ ] All tests pass
- [ ] Core user journey works end-to-end

**Functional Metrics:**
[Based on the original idea]
- [ ] [Key functionality from idea works]
- [ ] [User can achieve main goal]

## Next Steps

1. Refine this PRD based on the original idea
2. Add specific technical requirements
3. Define detailed user stories
4. Create implementation plan with /pm:prd-parse project-foundation
EOF
    
    echo "  ✅ Created project-foundation PRD from idea file"
fi

# 6. Create Initial Commit
echo ""
echo "📦 Creating initial commit..."
git add .

# Build commit message
commit_msg="Initial project setup with enhanced CCPM

- Configured for $PROJECT_NAME
- Git remote set to $GITHUB_USERNAME/$PROJECT_NAME  
- CCPM system initialized"

# Add idea processing info if applicable
if [ -n "$IDEA_FILE" ]; then
    commit_msg="$commit_msg
- Project foundation PRD created from $IDEA_FILE"
fi

commit_msg="$commit_msg
- Project ready for development

🤖 Generated with Claude Code"

if git commit -m "$commit_msg"; then
    echo "  ✅ Initial commit created"
else
    echo "  ❌ Failed to create initial commit"
    exit 1
fi

# 7. Success Summary
echo ""
echo "🎉 Project Setup Complete!"
echo "========================"
echo ""
echo "📁 Project: $PROJECT_NAME"
echo "🔗 Remote: https://github.com/$GITHUB_USERNAME/$PROJECT_NAME.git"
echo "👤 Git User: $USER_NAME <$USER_EMAIL>"
echo ""
echo "🎯 Next Steps:"
echo "1. Create GitHub repository: https://github.com/new"
echo "   Repository name: $PROJECT_NAME"
echo "2. Push initial commit: git push -u origin main"
echo "3. Create project context: /context:create"

if [ -n "$IDEA_FILE" ]; then
    echo "4. Continue with implementation plan: /pm:prd-parse project-foundation"
    echo "5. Then: /pm:epic-oneshot project-foundation"
else
    echo "4. Start with foundation PRD: /pm:prd-new project-foundation"
fi

echo ""
echo "📚 Documentation: README.md"
echo ""
echo "🚀 Your enhanced CCPM system is ready!"