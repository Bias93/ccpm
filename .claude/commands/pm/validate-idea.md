---
allowed-tools: Bash, Read, Write, LS
---

# Validate Idea

Transform raw idea into validated concept using fully automated AI-driven lean startup methodology.

## Usage
```
/pm:validate-idea <idea_file>
```

### Example
```
/pm:validate-idea IDEA.md
```

## Required Rules

**IMPORTANT:** Before executing this command, read and follow:
- `.claude/rules/datetime.md` - For getting real current date/time

## Automated Process Overview

This command executes a **fully automated validation process** requiring **ZERO user interaction**:
- Complete autonomous web research (15+ searches)
- Automated competitive analysis 
- Evidence-based GO/NO-GO decision
- Comprehensive VALIDATED-IDEA.md generation
- Total time: ~18 minutes

## Preflight Checklist

Before proceeding, complete these validation steps:

### Input Validation

1. **Parse arguments:**
   - Extract idea file path from first argument
   - Set variable: `IDEA_FILE`

2. **Validate idea file:**
   - Check if idea file exists and is readable
   - If not found: "❌ Idea file not found: [file_path]"
   - If not readable: "❌ Cannot read idea file: [file_path]"
   - If file is empty or very short (< 50 words): "⚠️ Idea file seems very short. The automated validation will work with available content, but more detail improves analysis quality."

3. **Check for existing validation:**
   - Check if `VALIDATED-IDEA.md` already exists in current directory
   - If it exists, ask user: "⚠️ VALIDATED-IDEA.md already exists. Do you want to overwrite it? (yes/no)"
   - Only proceed with explicit 'yes' confirmation

4. **Verify template availability:**
   - Check if `./.claude/templates/validated-idea.md` exists in current directory
   - If not found: "❌ Template not found. Please ensure ./.claude/templates/validated-idea.md exists in your project"

## Instructions

**IMPORTANT**: Use the idea-validator subagent to execute this validation process. The idea-validator is a **fully automated validation engine** trained in lean startup methodology and web research.

Execute validation by immediately launching the idea-validator subagent:

```
I'll launch the idea-validator agent for fully automated validation using comprehensive web research and lean startup methodology.
```

## Automated Validation Process

The idea-validator subagent executes **complete autonomous validation**:

### Phase 1: Automated Idea Analysis (2 minutes)
- Extract core problem, solution, target users from raw idea
- Generate research keywords and competitive search terms
- Auto-generate research strategy for market validation

### Phase 2: Autonomous Web Research (15 minutes)
**Executes 15-20 web searches automatically:**
- **Market Trend Analysis** (4 min): Search volume, growth indicators, demand signals
- **Competitive Intelligence** (6 min): Competitor discovery, feature analysis, positioning gaps
- **Problem Validation** (3 min): Pain point evidence, user frustration data
- **Solution Demand Analysis** (2 min): Adoption trends, willingness to pay signals

### Phase 3: Automated Evidence Synthesis (1 minute)
**Apply Lean Startup Framework:**
- Automated scoring (1-10 scale) for Market Problem Evidence, Solution-Market Fit, Business Viability, Technical Feasibility
- **GO Criteria**: 3+ scores ≥7/10 AND no critical blockers
- **NO-GO Criteria**: <3 scores ≥7/10 OR critical market/technical blocker
- Evidence-based confidence level assessment

## Automated Output Generation

Creates complete `VALIDATED-IDEA.md` with:
- **Executive Summary**: Automated GO/NO-GO decision with confidence level
- **Research Findings**: All web research data with sources
- **Validation Scores**: Framework-based scoring with reasoning
- **Strategic Recommendations**: Next actions for GO or pivot options for NO-GO

## Success Criteria
✅ **Zero user interaction required**
✅ **Comprehensive web research completed** (15+ searches)
✅ **Evidence-based decision generated**
✅ **Complete VALIDATED-IDEA.md file created**
✅ **Research completed in ≤18 minutes**

**Expected Outcome:**
Automatically generated VALIDATED-IDEA.md file with thorough market research, competitive analysis, and data-driven GO/NO-GO recommendation ready for PRD development or iteration.