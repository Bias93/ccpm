---
allowed-tools: Bash, Read, Write, LS
---

# PRD New

Launch brainstorming for new product requirement document.

## Usage
```
/pm:prd-new <feature_name>
/pm:prd-new <feature_name> --from-idea <idea_file>
```

### Options
- `--from-idea <file>`: Start brainstorming with an existing idea file as context

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- `.claude/rules/datetime.md` - For getting real current date/time

## Preflight Checklist

Before proceeding, complete these validation steps:

### Input Validation

1. **Parse arguments and options:**
   - Extract feature name from first argument
   - Check for `--from-idea` flag and extract idea file path if present
   - Set variables: `FEATURE_NAME` and `IDEA_FILE` (if provided)

2. **Validate feature name format:**
   - Must contain only lowercase letters, numbers, and hyphens
   - Must start with a letter
   - No spaces or special characters allowed
   - If invalid, tell user: "❌ Feature name must be kebab-case (lowercase letters, numbers, hyphens only). Examples: user-auth, payment-v2, notification-system"

3. **Validate idea file (if provided):**
   - Check if idea file exists and is readable
   - If not found: "❌ Idea file not found: [file_path]"
   - If not readable: "❌ Cannot read idea file: [file_path]"
   - If file is empty or very short (< 10 words): "⚠️ Idea file seems very short. Consider adding more detail about your idea."

4. **Check for existing PRD:**
   - Check if `.claude/prds/$FEATURE_NAME.md` already exists
   - If it exists, ask user: "⚠️ PRD '$FEATURE_NAME' already exists. Do you want to overwrite it? (yes/no)"
   - Only proceed with explicit 'yes' confirmation
   - If user says no, suggest: "Use a different name or run: /pm:prd-parse $FEATURE_NAME to create an epic from the existing PRD"

5. **Verify directory structure:**
   - Check if `.claude/prds/` directory exists
   - If not, create it first
   - If unable to create, tell user: "❌ Cannot create PRD directory. Please manually create: .claude/prds/"

## Instructions

You are a product manager creating a comprehensive Product Requirements Document (PRD) for: **$FEATURE_NAME**

Follow this structured approach:

### 1. Initial Context Setup

**If idea file is provided (`--from-idea` flag):**
- Read and analyze the idea file content
- Present a summary: "🧠 **Starting with your idea:** [brief summary of the idea]"
- Use the idea as the foundation for deeper exploration

**If no idea file provided:**
- Start fresh with the feature name as the only context

### 2. Discovery & Guided Brainstorming

**For ideas from file:**
- "Based on your idea, let me ask some clarifying questions to help structure this into a comprehensive PRD..."
- Ask targeted questions that build on the existing idea:
  - "Your idea mentions [specific aspect], who specifically would benefit from this?"
  - "What specific problem does this solve that current solutions don't address?"
  - "What would success look like for users of this feature?"
  - Dig deeper into technical considerations mentioned or implied in the idea

**For fresh features:**
- Ask open-ended discovery questions:
  - "What problem are we solving with '$FEATURE_NAME'?"
  - "Who are the target users?"
  - "What's the core value proposition?"

**In both cases, explore:**
- Problem validation and user pain points
- Target user personas and use cases
- Success criteria and measurable outcomes
- Technical constraints and requirements
- Dependencies and timeline considerations

### 3. PRD Structure
Create a comprehensive PRD with these sections:

#### Executive Summary
- Brief overview and value proposition

#### Problem Statement
- What problem are we solving?
- Why is this important now?

#### User Stories
- Primary user personas
- Detailed user journeys
- Pain points being addressed

#### Requirements
**Functional Requirements**
- Core features and capabilities
- User interactions and flows

**Non-Functional Requirements**
- Performance expectations
- Security considerations
- Scalability needs

#### Success Criteria
- Measurable outcomes
- Key metrics and KPIs

#### Constraints & Assumptions
- Technical limitations
- Timeline constraints
- Resource limitations

#### Out of Scope
- What we're explicitly NOT building

#### Dependencies
- External dependencies
- Internal team dependencies

### 4. File Format with Frontmatter
Save the completed PRD to: `.claude/prds/$FEATURE_NAME.md` with this exact structure:

```markdown
---
name: $FEATURE_NAME
description: [Brief one-line description of the PRD]
status: backlog
created: [Current ISO date/time]
idea_source: [If --from-idea used: "Generated from idea file: [filename]" | Otherwise: "Created from scratch"]
---

# PRD: $FEATURE_NAME

## Executive Summary
[Content...]

## Problem Statement
[Content...]

[Continue with all sections...]
```

### 5. Frontmatter Guidelines
- **name**: Use the exact feature name (same as $FEATURE_NAME)
- **description**: Write a concise one-line summary of what this PRD covers
- **status**: Always start with "backlog" for new PRDs
- **created**: Get REAL current datetime by running: `date -u +"%Y-%m-%dT%H:%M:%SZ"`
  - Never use placeholder text
  - Must be actual system time in ISO 8601 format
- **idea_source**: 
  - If `--from-idea` was used: "Generated from idea file: [filename]"
  - If created from scratch: "Created from scratch"

### 6. Quality Checks

Before saving the PRD, verify:
- [ ] All sections are complete (no placeholder text)
- [ ] User stories include acceptance criteria
- [ ] Success criteria are measurable
- [ ] Dependencies are clearly identified
- [ ] Out of scope items are explicitly listed

### 7. Post-Creation

After successfully creating the PRD:
1. Confirm: "✅ PRD created: .claude/prds/$FEATURE_NAME.md"
2. If idea file was used: "✅ Successfully expanded your initial idea into a comprehensive PRD"
3. Show brief summary of what was captured
4. Suggest next step: "Ready to create implementation epic? Run: /pm:prd-parse $FEATURE_NAME"

## Error Recovery

If any step fails:
- Clearly explain what went wrong
- Provide specific steps to fix the issue
- Never leave partial or corrupted files

Conduct a thorough brainstorming session before writing the PRD. Ask questions, explore edge cases, and ensure comprehensive coverage of the feature requirements for "$FEATURE_NAME".

**Remember**: If an idea file is provided, use it as a rich starting point for deeper exploration, not as a replacement for thorough discovery. The goal is to transform a raw idea into a structured, comprehensive PRD through guided brainstorming.
