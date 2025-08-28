# Commands

Complete reference of all commands available in the Claude Code PM system.

> **Note**: Project Management commands (`/pm:*`) are documented in the main [README.md](README.md#command-reference).

## Table of Contents

- [Project Management Commands](#project-management-commands)
- [Context Commands](#context-commands)
- [Testing Commands](#testing-commands)
- [Utility Commands](#utility-commands)
- [Review Commands](#review-commands)

## Project Management Commands

Core PM commands for idea validation and PRD creation.

### `/pm:validate-idea`
- **Purpose**: Transform raw idea into validated concept using fully automated AI-driven lean startup methodology
- **Usage**: `/pm:validate-idea <idea_file>`
- **Description**: Executes completely autonomous validation with zero user interaction. Performs 15+ web searches across market trends, competitive analysis, problem validation, and solution demand. Generates evidence-based GO/NO-GO decisions with comprehensive research backing.
- **Process**: 
  - Phase 1 (2 min): Automated idea analysis + research keyword generation
  - Phase 2 (15 min): Autonomous web research execution
  - Phase 3 (1 min): Evidence synthesis + lean startup framework application
- **Output**: `VALIDATED-IDEA.md` with complete market research, competitive analysis, and strategic recommendations
- **Features**:
  - Zero user interaction required
  - 15-20 automated web searches
  - Evidence-based scoring (1-10 scale)
  - GO/NO-GO decision with confidence levels
  - Ready for PRD development integration

### `/pm:prd-new`
- **Purpose**: Launch brainstorming for new product requirement document
- **Usage**: `/pm:prd-new <feature_name> [--from-idea <idea_file>]`
- **Description**: Creates comprehensive PRD through guided brainstorming. Can start from validated idea file for enhanced context.
- **Options**:
  - `--from-idea <file>`: Start with existing idea file as foundation (works with both raw ideas and validated ideas)
- **Output**: `.claude/prds/<feature_name>.md` with complete PRD structure
- **Integration**: Works seamlessly with validated ideas from `/pm:validate-idea`
- **Best Practice**: Use after `/pm:new-project` for separation of concerns

## Context Commands

Commands for managing project context in `.claude/context/`.

### `/context:create`
- **Purpose**: Create initial project context documentation
- **Usage**: `/context:create`
- **Description**: Analyzes the project structure and creates comprehensive baseline documentation in `.claude/context/`. Includes project overview, architecture, dependencies, and patterns.
- **When to use**: At project start or when context needs full rebuild
- **Output**: Multiple context files covering different aspects of the project

### `/context:update`
- **Purpose**: Update existing context with recent changes
- **Usage**: `/context:update`
- **Description**: Refreshes context documentation based on recent code changes, new features, or architectural updates. Preserves existing context while adding new information.
- **When to use**: After significant changes or before major work sessions
- **Output**: Updated context files with change tracking

### `/context:prime`
- **Purpose**: Load context into current conversation
- **Usage**: `/context:prime`
- **Description**: Reads all context files and loads them into the current conversation's memory. Essential for maintaining project awareness.
- **When to use**: At the start of any work session
- **Output**: Confirmation of loaded context

## Testing Commands

Commands for test configuration and execution.

### `/testing:prime`
- **Purpose**: Configure testing setup
- **Usage**: `/testing:prime`
- **Description**: Detects and configures the project's testing framework, creates testing configuration, and prepares the test-runner agent.
- **When to use**: Initial project setup or when testing framework changes
-  **Output**: `.claude/testing-config.md` with test commands and patterns

### `/testing:run`
- **Purpose**: Execute tests with intelligent analysis
- **Usage**: `/testing:run [test_target]`
- **Description**: Runs tests using the test-runner agent which captures output to logs and returns only essential results to preserve context.
- **Options**:
   - No arguments: Run all tests
   - File path: Run specific test file
   - Pattern: Run tests matching pattern
- **Output**: Test summary with failures analyzed, no verbose output in main thread

## Utility Commands

General utility and maintenance commands.

### `/prompt`
- **Purpose**: Handle complex prompts with multiple references
- **Usage**: Write your prompt in the file, then type `/prompt`
- **Description**: Ephemeral command for when complex prompts with numerous @ references fail in direct input. The prompt is written to the command file first, then executed.
- **When to use**: When Claude's UI rejects complex prompts
- **Output**: Executes the written prompt

### `/re-init`
- **Purpose**: Update or create CLAUDE.md with PM rules
- **Usage**: `/re-init`
- **Description**: Updates the project's CLAUDE.md file with rules from `.claude/CLAUDE.md`, ensuring Claude instances have proper instructions.
- **When to use**: After cloning PM system or updating rules
- **Output**: Updated CLAUDE.md in project root

## Review Commands

Commands for handling external code review tools.

### `/code-rabbit`
- **Purpose**: Process CodeRabbit review comments intelligently
- **Usage**: `/code-rabbit` then paste comments
- **Description**: Evaluates CodeRabbit suggestions with context awareness, accepting valid improvements while ignoring context-unaware suggestions. Spawns parallel agents for multi-file reviews.
- **Features**:
   - Understands CodeRabbit lacks full context
   - Accepts: Real bugs, security issues, resource leaks
   - Ignores: Style preferences, irrelevant patterns
   - Parallel processing for multiple files
- **Output**: Summary of accepted/ignored suggestions with reasoning

## Command Patterns

All commands follow consistent patterns:

### Allowed Tools
Each command specifies its required tools in frontmatter:
- `Read, Write, LS` - File operations
- `Bash` - System commands
- `Task` - Sub-agent spawning
- `Grep` - Code searching

### Error Handling
Commands follow fail-fast principles:
- Check prerequisites first
- Clear error messages with solutions
- Never leave partial state

### Context Preservation
Commands that process lots of information:
- Use agents to shield main thread from verbose output
- Return summaries, not raw data
- Preserve only essential information

## Creating Custom Commands

To add new commands:

1. **Create file**: `commands/category/command-name.md`
2. **Add frontmatter**:
   ```yaml
   ---
   allowed-tools: Read, Write, LS
   ---
   ```
3. **Structure content**:
   - Purpose and usage
   - Preflight checks
   - Step-by-step instructions
   - Error handling
   - Output format

4. **Follow patterns**:
   - Keep it simple (no over-validation)
   - Fail fast with clear messages
   - Use agents for heavy processing
   - Return concise output

## Integration with Agents

Commands often use agents for heavy lifting:

- **idea-validator**: Fully automated idea validation with web research
- **test-runner**: Executes tests, analyzes results
- **file-analyzer**: Summarizes verbose files
- **code-analyzer**: Hunts bugs across codebase
- **parallel-worker**: Coordinates parallel execution

This keeps the main conversation context clean while doing complex work.

## Notes

- Commands are markdown files interpreted as instructions
- The `/` prefix triggers command execution
- Commands can spawn agents for context preservation
- All PM commands (`/pm:*`) are documented in the main README
- Commands follow rules defined in `/rules/`
