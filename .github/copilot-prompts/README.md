# GitHub Copilot Custom Prompts

This directory contains custom prompts for GitHub Copilot agents to use when working with specific aspects of the agent-instructions system.

## Available Prompts

### Workflow Orchestration & Assignment Management
**File**: `workflow-orchestration-and-assignments.prompt.md`

**Use this prompt when**:
- Creating or modifying workflow assignment files
- Creating or modifying dynamic workflow scripts
- Orchestrating dynamic workflows end-to-end
- Validating dynamic workflow syntax
- Adding event-driven behaviors to workflows
- Understanding workflow assignment structure and conventions
- Troubleshooting workflow execution issues

**Key Features**:
- Lightweight prompt that references the comprehensive workflow development guide
- Links to all essential reference files
- Quick access to DSL syntax and event system documentation
- Direct links to templates and troubleshooting resources

**Important**: This prompt activates the comprehensive [ai-workflow-development-guide.md](../../ai_instruction_modules/ai-workflow-development-guide.md) instruction module, which contains the full reference material. The guide is also discoverable by all agents through the core instructions.

**How to Use**:
1. Open this prompt file in GitHub Copilot Chat
2. Reference it when working on workflow-related tasks
3. Follow the linked files for detailed specifications
4. Use the quick reference sections for syntax and patterns
5. Consult the troubleshooting section when issues arise

## Prompt Format

All custom prompts in this directory follow this structure:

1. **Description** - What the prompt is for
2. **When to Use** - Specific scenarios where this prompt applies
3. **Core Files** - Essential reference files to read
4. **Key Concepts** - Important concepts and patterns
5. **Common Workflows** - Step-by-step guides for typical tasks
6. **Troubleshooting** - Common issues and solutions
7. **Examples** - Quick start examples
8. **Summary** - Key takeaways

## Adding New Custom Prompts

To add a new custom prompt to this directory:

1. Create a new `.prompt.md` file with a descriptive kebab-case name
2. Follow the standard prompt format structure above
3. Include comprehensive links to relevant files in the repository
4. Add practical examples and troubleshooting guidance
5. Update this README with the new prompt information

## Repository Context

These prompts are part of the `nam20485/agent-instructions` repository, which contains:
- AI instruction modules for agent behavior
- Workflow assignment definitions
- Dynamic workflow scripts
- Role-based workflow definitions
- Process and guideline documentation

For more information, see the main repository structure and the [ai-core-instructions.md](../ai_instruction_modules/ai-core-instructions.md) file.

---

**Last Updated**: 2025-10-17  
**Maintainer**: AI Workflow System
