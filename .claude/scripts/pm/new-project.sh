#!/bin/bash

# New Project Setup Script
# Usage: bash .claude/scripts/pm/new-project.sh <project-name> [--github-user <user>] [--email <email>] [--name <name>] [--from-idea <file>]

PROJECT_NAME="$1"
GITHUB_USERNAME=""
USER_EMAIL=""
USER_NAME=""
IDEA_FILE=""

# Parse arguments
shift # Remove project name
while [[ $# -gt 0 ]]; do
    case $1 in
        --github-user)
            GITHUB_USERNAME="$2"
            shift 2
            ;;
        --email)
            USER_EMAIL="$2"
            shift 2
            ;;
        --name)
            USER_NAME="$2"
            shift 2
            ;;
        --from-idea)
            IDEA_FILE="$2"
            shift 2
            ;;
        *)
            echo "❌ Unknown option: $1"
            echo "Usage: /pm:new-project <project-name> [--github-user <user>] [--email <email>] [--name <name>] [--from-idea <file>]"
            exit 1
            ;;
    esac
done

# Validation
if [ -z "$PROJECT_NAME" ]; then
    echo "❌ Usage: /pm:new-project <project-name> [options]"
    echo "   Example: /pm:new-project my-app"
    echo "   With options: /pm:new-project my-app --github-user Bias93 --from-idea IDEA.md"
    exit 1
fi

# Auto-detect git configuration if not provided
if [ -z "$GITHUB_USERNAME" ]; then
    GITHUB_USERNAME=$(git config --get user.github 2>/dev/null || git config --get github.user 2>/dev/null || "")
    if [ -z "$GITHUB_USERNAME" ]; then
        GITHUB_USERNAME=$(git config --get remote.origin.url 2>/dev/null | sed -n 's/.*github.com[:/]\([^/]*\).*/\1/p' || "")
    fi
fi

if [ -z "$USER_EMAIL" ]; then
    USER_EMAIL=$(git config user.email 2>/dev/null || "")
fi

if [ -z "$USER_NAME" ]; then
    USER_NAME=$(git config user.name 2>/dev/null || "")
fi

echo "🔍 Configuration detection:"
echo "  GitHub user: ${GITHUB_USERNAME:-"❌ not found"}"
echo "  Email: ${USER_EMAIL:-"❌ not found"}"  
echo "  Name: ${USER_NAME:-"❌ not found"}"

# Check required parameters
if [ -z "$GITHUB_USERNAME" ]; then
    echo "❌ GitHub username required. Use --github-user option or set git config user.github"
    exit 1
fi

if [ -z "$USER_EMAIL" ]; then
    echo "❌ Email required. Use --email option or set git config user.email"
    exit 1
fi

if [ -z "$USER_NAME" ]; then
    echo "❌ Name required. Use --name option or set git config user.name"
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

# Validate and normalize project name
ORIGINAL_PROJECT_NAME="$PROJECT_NAME"
PROJECT_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')

if [[ "$ORIGINAL_PROJECT_NAME" != "$PROJECT_NAME" ]]; then
    echo "📝 Project name converted to lowercase: $PROJECT_NAME"
fi

if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "❌ Project name must be alphanumeric with dashes/underscores only"
    exit 1
fi

# Validate idea file (if provided)
if [ -n "$IDEA_FILE" ]; then
    if [ ! -f "$IDEA_FILE" ]; then
        echo "❌ Idea file not found: $IDEA_FILE"
        exit 1
    fi
    if [ ! -r "$IDEA_FILE" ]; then
        echo "❌ Cannot read idea file: $IDEA_FILE"
        exit 1
    fi
    echo "✅ Idea file validated: $IDEA_FILE"
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

# 3. Create Clean Project Files
echo ""
echo "📝 Creating project files..."

# Remove CCPM-specific files that shouldn't be in new projects
rm -f screenshot.webp LICENSE

# Create project-specific README
cat > README.md << EOF
# $PROJECT_NAME

Project created with enhanced CCPM system.

## Getting Started

This project uses Claude Code PM for project management and development workflow.

### Quick Start

1. Set up project context: \`/context:create\`
2. Create your first PRD: \`/pm:prd-new project-foundation\`
3. View available commands: \`/pm:help\`

### CCPM Documentation

- **Commands Reference**: \`.claude/docs/COMMANDS.md\`
- **Agents Guide**: \`.claude/docs/AGENTS.md\`
- **Project Management**: Run \`/pm:help\` for PM commands

## Development

[Add your project-specific development instructions here]

## Contributing

[Add your contributing guidelines here]

---

Built with [Claude Code PM](https://github.com/automazeio/ccpm) - Enhanced fork by [Bias93](https://github.com/Bias93/ccpm)
EOF

echo "  ✅ Created clean project README.md"

# 4. Clean Up Project Structure
echo ""
echo "🧹 Cleaning up CCPM-specific files..."
rm -f LICENSE  # Remove CCPM license
rm -f screenshot.webp  # Remove CCPM screenshot
echo "  ✅ Removed CCPM license and assets"
echo "  📝 Note: Add your own LICENSE file if needed"

# 5. Initialize CCPM System  
echo ""
echo "🛠️ Initializing CCPM system..."
if bash .claude/scripts/pm/init.sh; then
    echo "  ✅ CCPM system initialized successfully"
else
    echo "  ⚠️ CCPM initialization had some issues - check output above"
    
    # Ensure critical setup still happens even if init.sh fails
    echo ""
    echo "🔧 Completing essential setup..."
    
    # Create directories
    mkdir -p .claude/{prds,epics,context,rules,agents,scripts/pm}
    echo "  ✅ Created required directories"
    
    # Update .gitignore regardless of init.sh status
    if [ ! -f ".gitignore" ]; then
        touch .gitignore
        echo "  📄 Created .gitignore file"
    fi
    
    if ! grep -q ".claude/epics" .gitignore; then
        echo "" >> .gitignore
        echo "# Claude Code PM" >> .gitignore
        echo ".claude/epics/" >> .gitignore
        echo ".claude/context/cache/" >> .gitignore
        echo "  ✅ Updated .gitignore with CCPM entries"
    else
        echo "  ✅ .gitignore already has CCPM entries"
    fi
fi

# 5. Process Idea File (if provided)
if [ -n "$IDEA_FILE" ]; then
    echo ""
    echo "🧠 Idea file detected..."
    echo "  📄 Idea file: $IDEA_FILE"
    echo "  💡 Your idea will be used as starting point for guided PRD creation"
    echo "  ✅ Ready for enhanced brainstorming with /pm:prd-new"
    
    # Ensure PRD directory exists
    mkdir -p .claude/prds
    
    IDEA_PREVIEW=$(head -n 3 "$IDEA_FILE" | tr '\n' ' ' | cut -c1-100)
    echo "  📝 Idea preview: \"$IDEA_PREVIEW...\""
fi

# 6. GitHub Repository Creation
echo ""
echo "🐙 GitHub Repository Setup"
echo "=========================="
read -p "Do you want to create a GitHub repository now? (y/n): " create_repo
if [[ "$create_repo" =~ ^[Yy]$ ]]; then
    read -p "Should the repository be public or private? (public/private): " repo_visibility
    if [[ "$repo_visibility" == "private" ]]; then
        echo "  📝 Creating private repository..."
        if gh repo create "$PROJECT_NAME" --private --description "Project created with CCPM Enhanced"; then
            echo "  ✅ Private repository created successfully"
            REPO_CREATED=true
        else
            echo "  ❌ Failed to create repository"
            REPO_CREATED=false
        fi
    else
        echo "  📝 Creating public repository..."
        if gh repo create "$PROJECT_NAME" --public --description "Project created with CCPM Enhanced"; then
            echo "  ✅ Public repository created successfully"
            REPO_CREATED=true
        else
            echo "  ❌ Failed to create repository"
            REPO_CREATED=false
        fi
    fi
else
    echo "  ⏭️ Skipping GitHub repository creation"
    REPO_CREATED=false
fi

# 7. Create Initial Commit
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
- Idea file processed: $IDEA_FILE (ready for PRD creation)"
fi

commit_msg="$commit_msg
- Project ready for development

🤖 Generated with Claude Code"

if git commit -m "$commit_msg"; then
    echo "  ✅ Initial commit created"
    
    # Push to GitHub if repository was created
    if [ "$REPO_CREATED" = true ]; then
        echo ""
        echo "📤 Pushing to GitHub..."
        if git push -u origin main; then
            echo "  ✅ Code pushed to GitHub successfully"
        else
            echo "  ❌ Failed to push to GitHub"
        fi
    fi
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
if [ "$REPO_CREATED" = true ]; then
    echo "1. ✅ GitHub repository created and code pushed"
    echo "2. Create project CLAUDE.md:"
else
    echo "1. Create GitHub repository manually: https://github.com/new"
    echo "   Repository name: $PROJECT_NAME"
    echo "2. Push initial commit: git push -u origin main"
    echo "3. Create project CLAUDE.md:"
fi
echo ""
echo "📋 If CCPM setup had issues, complete manually:"
echo "   • Install GitHub CLI: https://cli.github.com/"
echo "   • Authenticate: gh auth login --web"
echo "   • Install extension: gh extension install yahsan2/gh-sub-issue"
echo "   • Verify .gitignore includes .claude/epics/ and .claude/context/cache/"
echo ""
echo "3. Create project CLAUDE.md:"
echo "   /init include rules from .claude/CLAUDE.md"
echo ""

if [ -n "$IDEA_FILE" ]; then
    echo "4. Create PRD from your idea with guided brainstorming:"
    echo "   /pm:prd-new project-foundation --from-idea $IDEA_FILE"
else
    echo "4. Create foundation PRD with guided brainstorming:"
    echo "   /pm:prd-new project-foundation"
fi

echo ""
echo "5. Create technical implementation plan:"
echo "   /pm:prd-parse project-foundation"
echo "   /pm:epic-oneshot project-foundation"
echo ""
echo "6. Start implementing basic project structure:"
echo "   /pm:issue-start 1234  # First setup task"
echo "   # Implement 2-3 initial tasks (package.json, structure, etc.)"
echo ""
echo "7. Create project context (after some implementation):"
echo "   /context:create"
echo "   # Note: More effective after implementing basic structure"

echo ""
echo "📚 Documentation: README.md"
echo ""
echo "🚀 Your enhanced CCPM system is ready!"