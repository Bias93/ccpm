#!/bin/bash

echo "Initializing..."
echo ""
echo ""

echo " ██████╗ ██████╗██████╗ ███╗   ███╗"
echo "██╔════╝██╔════╝██╔══██╗████╗ ████║"
echo "██║     ██║     ██████╔╝██╔████╔██║"
echo "╚██████╗╚██████╗██║     ██║ ╚═╝ ██║"
echo " ╚═════╝ ╚═════╝╚═╝     ╚═╝     ╚═╝"

echo "┌─────────────────────────────────┐"
echo "│ Claude Code Project Management  │"
echo "│ by https://x.com/aroussi        │"
echo "└─────────────────────────────────┘"
echo "https://github.com/automazeio/ccpm"
echo ""
echo ""

echo "🚀 Initializing Claude Code PM System"
echo "======================================"
echo ""

# Check for required tools
echo "🔍 Checking dependencies..."

# Check gh CLI
if command -v gh &> /dev/null; then
  echo "  ✅ GitHub CLI (gh) installed"
else
  echo "  ❌ GitHub CLI (gh) not found"
  echo ""
  echo "  Installing gh..."
  
  # Try snap first (no sudo required)
  if command -v snap &> /dev/null; then
    echo "  📦 Installing via snap..."
    if snap install gh; then
      echo "  ✅ GitHub CLI installed via snap"
    else
      echo "  ❌ Snap installation failed"
    fi
  # Try brew
  elif command -v brew &> /dev/null; then
    echo "  🍺 Installing via brew..."
    if brew install gh; then
      echo "  ✅ GitHub CLI installed via brew"
    else
      echo "  ❌ Brew installation failed"
    fi
  # Try direct binary download
  else
    echo "  📥 Installing binary directly..."
    GH_VERSION=$(curl -s https://api.github.com/repos/cli/cli/releases/latest | grep -o '"tag_name": "v[^"]*"' | cut -d'"' -f4)
    if [ -n "$GH_VERSION" ]; then
      wget -O /tmp/gh.tar.gz "https://github.com/cli/cli/releases/download/${GH_VERSION}/gh_${GH_VERSION#v}_linux_amd64.tar.gz"
      tar -xzf /tmp/gh.tar.gz -C /tmp
      mkdir -p ~/.local/bin
      cp "/tmp/gh_${GH_VERSION#v}_linux_amd64/bin/gh" ~/.local/bin/
      chmod +x ~/.local/bin/gh
      export PATH="$HOME/.local/bin:$PATH"
      # Add to bashrc only if not already present
      if ! grep -q '\.local/bin' ~/.bashrc 2>/dev/null; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
      fi
      echo "  ✅ GitHub CLI installed to ~/.local/bin/gh"
    else
      echo "  ❌ Could not download GitHub CLI"
      echo "  Please install manually: https://cli.github.com/"
      echo "  Then run /pm:init again"
      exit 1
    fi
  fi
  
  # Verify installation
  if ! command -v gh &> /dev/null; then
    echo "  ❌ GitHub CLI installation failed"
    echo "  Please install manually: https://cli.github.com/"
    echo "  Then run /pm:init again"
    exit 1
  fi
fi

# Check gh auth status
echo ""
echo "🔐 Checking GitHub authentication..."
if gh auth status &> /dev/null; then
  echo "  ✅ GitHub authenticated"
else
  echo "  ⚠️ GitHub not authenticated"
  echo "  Running: gh auth login"
  if ! gh auth login; then
    echo "  ❌ GitHub authentication failed"
    echo "  Please run 'gh auth login' manually"
    exit 1
  fi
  echo "  ✅ GitHub authentication completed"
fi

# Check for gh-sub-issue extension
echo ""
echo "📦 Checking gh extensions..."
if gh extension list | grep -q "yahsan2/gh-sub-issue"; then
  echo "  ✅ gh-sub-issue extension installed"
else
  echo "  📥 Installing gh-sub-issue extension..."
  if ! gh extension install yahsan2/gh-sub-issue; then
    echo "  ❌ Failed to install gh-sub-issue extension"
    echo "  Will use fallback task lists instead"
  else
    echo "  ✅ gh-sub-issue extension installed"
  fi
fi

# Create directory structure
echo ""
echo "📁 Creating directory structure..."
mkdir -p .claude/prds
mkdir -p .claude/epics
mkdir -p .claude/context
mkdir -p .claude/rules
mkdir -p .claude/agents
mkdir -p .claude/scripts/pm
echo "  ✅ Directories created"

# Update .gitignore
echo ""
echo "📝 Updating .gitignore..."
if [ ! -f ".gitignore" ]; then
  touch .gitignore
fi

# Add CCPM entries to .gitignore if not present
if ! grep -q ".claude/epics" .gitignore; then
  echo "" >> .gitignore
  echo "# Claude Code PM" >> .gitignore
  echo ".claude/epics/" >> .gitignore
  echo ".claude/context/cache/" >> .gitignore
  echo "  ✅ .gitignore updated"
else
  echo "  ✅ .gitignore already configured"
fi

# Copy scripts if in main repo
if [ -d "scripts/pm" ] && [ ! "$(pwd)" = *"/.claude"* ]; then
  echo ""
  echo "📝 Copying PM scripts..."
  cp -r scripts/pm/* .claude/scripts/pm/
  chmod +x .claude/scripts/pm/*.sh
  echo "  ✅ Scripts copied and made executable"
fi

# Check for git
echo ""
echo "🔗 Checking Git configuration..."
if git rev-parse --git-dir > /dev/null 2>&1; then
  echo "  ✅ Git repository detected"

  # Check remote
  if git remote -v | grep -q origin; then
    remote_url=$(git remote get-url origin)
    echo "  ✅ Remote configured: $remote_url"
  else
    echo "  ⚠️ No remote configured"
    echo "  Add with: git remote add origin <url>"
  fi
else
  echo "  ⚠️ Not a git repository"
  echo "  Initialize with: git init"
fi

# Create project-specific CLAUDE.md
echo ""
echo "📄 Setting up CLAUDE.md..."
if [ ! -f "CLAUDE.md" ]; then
  echo "  📝 Creating project-specific CLAUDE.md template..."
  
  # Create comprehensive project template
  cat > CLAUDE.md << 'EOF'
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

> Think carefully and implement the most concise solution that changes as little code as possible.

## Project Overview

[Describe what this project does and its main purpose]

## Architecture

[Describe the key architectural decisions and patterns used]

## Development Setup

[How to set up the development environment]
```bash
# Example setup commands
git clone <repo>
cd <project>
npm install  # or equivalent
```

## Testing Strategy

[Describe testing approach and commands]
- Run all tests: `[your test command]`
- Run specific test: `[command for single test]`
- Test coverage: `[coverage command]`

## Build & Deployment

[How to build and deploy this project]
- Build: `[build command]`
- Deploy: `[deploy command]`

## Code Style & Conventions

[Project-specific coding standards]
- File naming: [convention]
- Function naming: [convention]
- Code organization: [structure]

## Important Notes

[Critical project-specific information]
- [Important gotcha or consideration]
- [Special requirements or constraints]
EOF
  echo "  ✅ CLAUDE.md created with project template"
  echo "  💡 Tip: Run '/init include rules from .claude/CLAUDE.md' to add CCPM rules"
else
  echo "  ✅ CLAUDE.md already exists"
  echo "  💡 Tip: Run '/re-init' to integrate latest CCPM rules"
fi

# Summary
echo ""
echo "✅ Initialization Complete!"
echo "=========================="
echo ""
echo "📊 System Status:"
gh --version | head -1
echo "  Extensions: $(gh extension list | wc -l) installed"
echo "  Auth: $(gh auth status 2>&1 | grep -o 'Logged in to [^ ]*' || echo 'Not authenticated')"
echo ""
echo "🎯 Next Steps:"
echo "  1. Create your first PRD: /pm:prd-new <feature-name>"
echo "  2. View help: /pm:help"
echo "  3. Check status: /pm:status"
echo ""
echo "📚 Documentation: README.md"

exit 0
