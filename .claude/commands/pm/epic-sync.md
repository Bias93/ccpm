---
allowed-tools: Bash
---

# Epic Sync Enhanced 2025

Push epic and tasks to GitHub as issues with improved reliability and solo-dev optimizations.

## Usage
```
/pm:epic-sync <feature_name>
```

## Instructions

Execute the dedicated bash script that handles all epic sync operations:

```bash
bash .claude/scripts/pm/epic-sync.sh "$ARGUMENTS"
```

## Features

This enhanced version provides:
- **Robust error handling** with fail-fast approach
- **Smart labeling** for GitHub project management  
- **Sequential processing** for reliability over speed
- **Professional workflow** optimized for solo developers
- **Dedicated bash script** to prevent command parsing issues

## Error Handling

The script provides:
- Authentication validation before operations
- Individual task error handling (continues on failures)
- Clear error messages with actionable guidance
- Partial success handling (reports what succeeded)

## Smart Features

- **Smart labeling** based on task content (backend/frontend/testing/deployment)
- **File renaming** from 001.md to {issue_number}.md
- **Frontmatter updates** with GitHub URLs and timestamps
- **Worktree creation** for development workflow

## Next Steps

After successful sync:
- Start development: `/pm:epic-start {feature_name}`
- Work on single task: `/pm:issue-start {issue_number}`
- View epic on GitHub