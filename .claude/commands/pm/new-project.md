---
allowed-tools: Bash, Read, Write, LS
---

# Create New Project

Automated setup for brand new projects using enhanced CCPM.

## Usage
```
/pm:new-project <project-name> [options]
```

Options:
- `--github-user <username>` - GitHub username (auto-detected from git config if not provided)
- `--email <email>` - Git email (uses existing git config if not provided)  
- `--name <name>` - Git display name (uses existing git config if not provided)
- `--from-idea <file>` - Create PRD from idea file

Examples:
```
# Simple setup (uses existing git config):
/pm:new-project my-awesome-app

# With GitHub username override:
/pm:new-project my-awesome-app --github-user Bias93

# Complete custom setup:
/pm:new-project my-awesome-app --github-user Bias93 --email custom@email.com --name "Custom Name"

# From idea file:
echo "My app idea: A tool that..." > IDEA.md
/pm:new-project my-awesome-app --from-idea IDEA.md
```

## Instructions

### 1. Parameter Detection and Validation

**Auto-detect git configuration:**
```bash
# Try to get GitHub username from git config
github_user=$(git config --get user.github || git config --get github.user || "")
if [ -z "$github_user" ]; then
    github_user=$(git config --get remote.origin.url | sed -n 's/.*github.com[:/]\([^/]*\).*/\1/p' || "")
fi

# Get git identity
user_email=$(git config user.email || "")
user_name=$(git config user.name || "")

echo "🔍 Auto-detected configuration:"
echo "  GitHub user: ${github_user:-"not found"}"
echo "  Email: ${user_email:-"not found"}"  
echo "  Name: ${user_name:-"not found"}"
```

**Validation:**
- Validate project-name: alphanumeric, dashes, underscores only
- If GitHub username missing and not provided: prompt for it
- If email missing and not provided: prompt for it
- If name missing and not provided: prompt for it
- If --from-idea provided: validate idea file exists and is readable

### 2. Setup Git Config
```bash
# Set git identity for this project
git config user.email "{user-email}"
git config user.name "{user-name}"

echo "✅ Git identity configured"
```

### 3. Fix Git Remote
```bash
# Remove CCPM remote
git remote remove origin

# Add user's project remote
git remote add origin https://github.com/{github-username}/{project-name}.git

echo "✅ Git remote configured for your project"
```

### 4. Clean Up Project Structure
```bash
# Remove CCPM-specific files that shouldn't be in user projects
rm -f LICENSE  # Remove CCMP license
rm -f screenshot.webp  # Remove CCPM screenshot

echo "✅ Cleaned up CCPM-specific files"
```

### 5. Update Project Files
Update README.md to replace placeholders:
- Replace `TUO-USERNAME` with actual github-username
- Replace `my-new-project` with actual project-name

### 6. Initialize CCPM
```bash
# Run standard CCPM initialization
bash .claude/scripts/pm/init.sh

echo "✅ CCPM system initialized"
```

### 7. Process Idea File (if provided)
If --from-idea flag is used:
```bash
# Read and process idea file into project-foundation PRD
echo "🧠 Processing idea file: {idea-file}"

# Use Claude to transform raw idea into structured PRD
# This should create .claude/prds/project-foundation.md
# Based on the template in .claude/templates/project-foundation.md

echo "✅ Created project-foundation PRD from idea"
```

### 8. Create Initial Commit
```bash
# Commit the configured setup
git add .
commit_msg="Initial project setup with enhanced CCPM

- Configured for {project-name}
- Git remote set to {github-username}/{project-name}
- CCPM system initialized"

# Add idea processing info if applicable
if [ -n "$idea_file" ]; then
  commit_msg="$commit_msg
- Project foundation PRD created from $idea_file"
fi

commit_msg="$commit_msg

🤖 Generated with Claude Code"

git commit -m "$commit_msg"

echo "✅ Initial commit created"
echo "📝 Next: Run 'git push -u origin main' to push to GitHub"
```

### 8. Next Steps Guide
```
🎉 Project Setup Complete!
========================

📁 Project: {project-name}
🔗 Remote: https://github.com/{github-username}/{project-name}.git
👤 Git User: {user-name} <{user-email}>

🎯 Next Steps:
1. Create GitHub repository: https://github.com/new
2. Push initial commit: git push -u origin main
3. {If idea file used}: Continue with: /pm:prd-new project-foundation --from-idea VALIDATED-IDEA.md
4. {If no idea file}: Validate your idea first: /pm:validate-idea IDEA.md, then /pm:prd-new project-foundation --from-idea VALIDATED-IDEA.md
5. Generate technical plan: /pm:prd-parse project-foundation && /pm:epic-oneshot project-foundation
6. Start development: /pm:issue-start 1234
7. After implementing 2-3 basic tasks: /init include rules from .claude/CLAUDE.md && /context:create

📚 Documentation: README.md
```

## Error Handling

- **Invalid project name**: "❌ Project name must be alphanumeric with dashes/underscores only"
- **Invalid email**: "❌ Please provide a valid email address"
- **Git remote exists**: Ask user to confirm overwrite
- **No GitHub connection**: Warn but continue (they can push later)

## Security Notes

- This command operates entirely locally
- No data is sent to external services except standard git operations
- User controls when to push to their own repository