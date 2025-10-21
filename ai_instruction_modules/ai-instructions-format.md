<format_guide>
# AI Instructions Format Guide

<overview>
## Overview

This document serves as the **canonical reference** for formatting all AI instruction module files in this repository. It defines the standards, conventions, and best practices that ensure optimal parsing, context retention, and multi-agent compatibility.

**Purpose:** 
- Guide AI agents on how to interpret instruction files correctly
- Provide humans with formatting standards for creating or modifying instruction modules
- Ensure consistency across all instruction files for better AI performance

**Audience:**
- AI Agents (GitHub Copilot, Claude, Gemini, Qwen, etc.)
- Human developers and maintainers
- Anyone creating new instruction modules
</overview>

<formatting_principles>
## Core Formatting Principles

### 1. XML Semantic Tags

All instruction files MUST use XML tags to structure content into logical sections. This improves parsing accuracy and context retention across all AI models.

<formatting_rules>
#### **Why XML Tags?**
- **Research-backed:** Anthropic states XML tags "help Claude parse your prompts more accurately, leading to higher-quality outputs"
- **Improved parsing:** Clear boundaries prevent mixing instructions with examples or context
- **Better retention:** Semantic tags help models understand relationships between sections
- **Multi-agent compatible:** Works consistently across different AI platforms

#### **XML Tag Guidelines**

**Consistency:**
- Use the same tag names throughout all instruction files
- Refer to tag names when discussing content (e.g., "Using the guidelines in `<validation>`...")

**Semantic Naming:**
- Tag names should clearly describe their content
- Use underscores for multi-word tags: `<core_behaviors>`, `<security_config>`
- Be descriptive: `<persona>` not `<p>`, `<constraints>` not `<c>`

**Nesting:**
- Nest tags for hierarchical content when appropriate
- Example:
  ```xml
  <workflow>
    <validation>
      <!-- nested validation rules -->
    </validation>
  </workflow>
  ```

**Complete Wrapping:**
- Always close tags properly
- Each major section gets opening and closing tags
- Tags should wrap entire sections, not just headings

#### **Standard Tags by Section Type**

Common tag patterns used across instruction files:

| Tag Name | Purpose | Example Content |
|----------|---------|-----------------|
| `<persona>` | Defines AI agent role/expertise | Technical skills, knowledge domains |
| `<hierarchy>` | Priority/conflict resolution | Order of precedence for instructions |
| `<core_behaviors>` | Expected agent behaviors | How agent should act/respond |
| `<constraints>` | What NOT to do | Limitations, forbidden actions |
| `<tools>` | Available tools/utilities | MCP servers, APIs, frameworks |
| `<workflow>` | Process flows | Step-by-step procedures |
| `<validation>` | Testing/verification rules | Build, test, validation requirements |
| `<output_style>` | Response formatting | How to structure responses |
| `<error_handling>` | Error response patterns | How to handle failures |
| `<security_config>` | Security guidelines | Authentication, secrets, permissions |
| `<performance>` | Performance considerations | Optimization guidelines |
| `<documentation>` | Documentation standards | Comment styles, API docs |
| `<principles>` | Design principles | SOLID, DRY, architectural patterns |
| `<requirements>` | Application requirements | Must-have features, capabilities |
| `<standards>` | Code quality standards | Formatting, warnings as errors |
| `<technology_stack>` | Tech specifications | Languages, frameworks, versions |
| `<testing_approach>` | Testing methodology | TDD, coverage requirements |
| `<frameworks>` | Testing frameworks | xUnit, Moq, Jest, etc. |
| `<ci_cd>` | CI/CD requirements | Pipeline, automation rules |
| `<resources>` | External references | Links, documentation |
| `<additional_modules>` | Related instruction files | Links to other modules |
| `<examples>` | Few-shot examples | Demonstration of desired behavior |

#### **Tag Example: Complete File Structure**

```markdown
# Instruction File Title

<persona>
## Agent Role
- Define expertise areas
- Specify knowledge domains
</persona>

<core_behaviors>
## Core Behaviors
- Behavior 1
- Behavior 2
</core_behaviors>

<constraints>
## Constraints (Do Not)
- Constraint 1
- Constraint 2
</constraints>

<workflow>
## Process Flow
1. Step 1
2. Step 2
3. Step 3
</workflow>

<validation>
## Validation Requirements
- Build successfully
- Tests pass
- Linting clean
</validation>

<additional_modules>
## Related Modules
- [other-module.md](./other-module.md)
</additional_modules>
```
</formatting_rules>

### 2. Markdown Structure

<markdown_rules>
#### **Heading Hierarchy**

- **H1 (`#`)**: File title only (one per file)
- **H2 (`##`)**: Major sections (within XML tags)
- **H3 (`###`)**: Subsections
- **H4 (`####`)**: Sub-subsections

**Example:**
```markdown
# File Title

<section_tag>
## Major Section

### Subsection

#### Details
</section_tag>
```

#### **Lists**

**Unordered Lists:**
- Use `-` for consistency (not `*` or `+`)
- Indent with 2 spaces for nested items

```markdown
- Top level item
  - Nested item
  - Nested item
- Top level item
```

**Ordered Lists:**
- Use `1.`, `2.`, `3.` for sequential steps
- Maintain numbering accuracy

```markdown
1. First step
2. Second step
3. Third step
```

#### **Code Blocks**

**Inline Code:**
- Use single backticks for: `commands`, `file.names`, `variables`, `functions()`

**Block Code:**
- Use triple backticks with language identifier
- Always specify language for syntax highlighting

````markdown
```csharp
public class Example 
{
    // C# code
}
```

```bash
dotnet build
dotnet test
```

```json
{
  "key": "value"
}
```
````

#### **Links**

**Relative Links:**
- Use relative paths for internal files: `[other-module](./other-module.md)`
- Use `../` to go up directories: `[repo-summary](../ai-repo-summary.md)`

**External Links:**
- Use absolute URLs: `[Microsoft Docs](https://learn.microsoft.com/)`
- Include descriptive text, not bare URLs

#### **Emphasis**

- **Bold** (`**text**`): Important terms, emphasis, labels
- *Italic* (`*text*`): Slight emphasis, examples in prose
- `Code` (`` `text` ``): Technical terms, commands, file names
- ~~Strikethrough~~ (`~~text~~`): Deprecated content (avoid, remove instead)

#### **Tables**

Use tables for comparison, options, or structured data:

```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Value 1  | Value 2  | Value 3  |
| Value A  | Value B  | Value C  |
```

**Table Guidelines:**
- Keep tables simple and readable
- Use for comparisons, not long prose
- Include header row with clear labels
</markdown_rules>

### 3. Content Organization

<content_organization>
#### **File Structure Template**

Every instruction file should follow this general structure:

```markdown
# [Descriptive Title]

[Brief overview paragraph explaining file purpose]

<primary_section_1>
## [Section Name]
[Content following markdown rules]
</primary_section_1>

<primary_section_2>
## [Section Name]
[Content following markdown rules]
</primary_section_2>

<examples>
## Examples
[Few-shot examples if applicable]
</examples>

<additional_modules>
## Related Modules
[Links to related instruction files]
</additional_modules>
```

#### **Section Ordering**

Typical order (adjust based on content):

1. **Title & Overview** (no tag, just H1 + paragraph)
2. **Persona/Role** (if applicable)
3. **Core Instructions/Behaviors**
4. **Constraints/Limitations**
5. **Workflow/Process**
6. **Standards/Requirements**
7. **Examples** (if applicable)
8. **Validation/Testing**
9. **Resources/Links**
10. **Related Modules**

#### **Content Density**

- **Keep files under 32K tokens** to avoid performance degradation
- Research shows model performance drops significantly beyond 32K tokens
- If file exceeds limit, consider splitting into logical sub-files
- See [consolidation guidelines](#file-consolidation) for details

#### **Redundancy**

- **Remove duplicate instructions** across files
- If multiple files need same info, create shared module and link to it
- Consolidation improves token efficiency and reduces costs
</content_organization>

### 4. Positive Instructions

<positive_instructions>
Research shows AI models respond better to **positive instructions** (what TO do) rather than **negative instructions** (what NOT to do).

#### **Why Positive Instructions?**
- Reduces ambiguity
- Provides clearer guidance
- Helps models understand goals better
- Leads to more targeted responses

#### **Conversion Examples**

❌ **Negative (Less Effective):**
```markdown
- Do not use ellipses
- Never skip validation
- Don't make large refactors
```

✅ **Positive (More Effective):**
```markdown
- Use complete sentences with proper punctuation
- Always run validation steps after changes
- Propose incremental changes with approval gates
```

#### **When to Use Negative Instructions**

Negative instructions are acceptable for `<constraints>` sections that explicitly define boundaries:

```markdown
<constraints>
## Constraints (Do Not)
- Large refactors without approval
- Skip validation steps
- Print secret values
</constraints>
```

But even in constraints, provide context:

```markdown
<constraints>
## Constraints (Do Not)
- Large refactors without approval → Propose incremental changes instead
- Skip validation steps → Always run build and tests
- Print secret values → Use environment variables, never log credentials
</constraints>
```
</positive_instructions>

### 5. Few-Shot Examples

<few_shot_examples>
Few-shot examples are **the most important prompting tool** according to research. They demonstrate desired behavior patterns through concrete examples.

#### **When to Include Examples**

Include few-shot examples when:
- Instructions are complex or abstract
- Multiple valid approaches exist
- Format/style needs demonstration
- Edge cases need clarification

#### **Example Guidelines**

**Quality over Quantity:**
- Start with 1-2 examples
- Add more only if needed for coverage
- Aim for 3-5 examples maximum per concept

**Diverse Examples:**
- Cover different scenarios/edge cases
- Show various input/output patterns
- Include both simple and complex cases

**Consistent Formatting:**
- Use identical structure across examples
- Label clearly: `❌ Bad:`, `✅ Good:`, `Example 1:`, etc.
- Include explanations of why each example works

#### **Example Template**

```markdown
<examples>
## Examples

### Example 1: [Scenario Name]

**Context:** [Brief description of scenario]

❌ **Ineffective Approach:**
```[language]
[code or text showing wrong way]
```
**Why this doesn't work:** [Explanation]

✅ **Effective Approach:**
```[language]
[code or text showing right way]
```
**Why this works:** [Explanation]

### Example 2: [Another Scenario]
[Repeat pattern]
</examples>
```

#### **Example Ordering**

Research shows **order matters** - example sequence affects AI performance:
- Start with simplest, clearest example
- Progress to more complex cases
- End with edge cases or exceptions
- Maintain consistent ordering across similar instruction files
</few_shot_examples>

### 6. Consistent Formatting

<consistent_formatting>
#### **Naming Conventions**

**File Names:**
- Use lowercase with hyphens: `ai-core-instructions.md`
- Prefix with `ai-` for agent instruction files
- Be descriptive: `ai-testing-validation.md` not `ai-test.md`

**XML Tags:**
- Use lowercase with underscores: `<core_behaviors>`
- Match section purpose: `<validation>` for validation rules
- Be consistent across all files

**Heading Text:**
- Use Title Case for H1: `# Core Instructions`
- Use Title Case for H2: `## Validation Requirements`
- Use sentence case for H3/H4 if needed

#### **Spacing and Indentation**

**Between Sections:**
```markdown
</section1>

<section2>
```
One blank line between closing and opening tags.

**Lists:**
- 2-space indentation for nested items
- No blank lines between items unless separating groups

**Code Blocks:**
- Blank line before and after code blocks
- No extra indentation (fence aligns with surrounding text)

#### **Punctuation**

- **Lists:** No periods on single-line items, periods on multi-sentence items
- **Headings:** No periods
- **Links:** Include punctuation outside link syntax: `[link](url).`
</consistent_formatting>

## File Consolidation Guidelines

<consolidation_guidelines>
Based on context optimization research, consolidation improves AI performance while reducing costs.

### **Benefits of Consolidation**

- **80-95% information retention** with 20-50% compression
- **Direct cost savings** through token reduction
- **Improved context cohesion** by grouping related concepts
- **Reduced redundancy** eliminates duplicate instructions

### **When to Consolidate**

Consolidate when:
- Multiple files cover related topics
- Duplicate instructions exist across files
- Files are very short (< 50 lines)
- Related concepts are scattered

### **Consolidation Process**

1. **Identify Related Files**
   - Group by topic/domain
   - Look for overlapping content
   - Consider agent workflow needs

2. **Analyze Redundancy**
   - Find duplicate or overlapping instructions
   - Identify implied vs. explicit rules
   - Note which information is unique

3. **Create Consolidated Structure**
   - Organize by logical sections
   - Use XML tags to separate concerns
   - Maintain all unique information

4. **Validate Token Count**
   - Keep files under 32K tokens
   - Test with token counter if needed
   - Split if approaching limit

5. **Update References**
   - Update links from other files
   - Update core instructions module list
   - Update repository summary

### **Warning: Context Length Limits**

**Critical Research Finding:**
- At 32K tokens, most models drop below 50% performance
- Claude Sonnet 4 shows more degradation than GPT-4 or Gemini 2.5 Pro
- **Target: Keep files well under 32K tokens**
- Consider 8K-16K as safer upper limit for consistent performance

### **Token Estimation**

Rough token estimates:
- 1 token ≈ 4 characters
- 1 token ≈ 0.75 words
- 100 words ≈ 133 tokens
- 1000 words ≈ 1333 tokens

Use OpenAI's tiktoken or similar tool for accurate counts.
</consolidation_guidelines>

## Multi-Agent Compatibility

<multi_agent_compatibility>
These formatting standards work across multiple AI platforms:

### **Supported Agents**
- GitHub Copilot
- Claude (Anthropic)
- Claude Code CLI
- Gemini Code Assist
- Gemini CLI
- Qwen Code CLI
- OpenCode.ai
- Other LLM-based agents

### **Platform-Specific Notes**

**GitHub Copilot:**
- Reads custom instructions from specific locations
- Supports markdown and XML equally well
- Benefits from clear section boundaries

**Claude:**
- Explicitly recommends XML tags (Anthropic documentation)
- Excels with structured prompts
- Supports long context but performance degrades > 32K tokens

**Gemini:**
- Handles long context well (up to 192K tokens in some models)
- XML structure still improves parsing
- Maintains 90%+ performance up to 192K tokens (Gemini 2.5 Pro)

**General Best Practices:**
- Use standard markdown + XML (universal support)
- Avoid platform-specific features
- Test instructions across multiple agents when possible
</multi_agent_compatibility>

## Creating New Instruction Files

<creation_guidelines>
When creating new instruction module files:

### **Step 1: Plan Structure**
- Define the file's purpose and scope
- Identify major sections needed
- Choose appropriate XML tags
- Consider related modules

### **Step 2: Write Content**
- Start with clear title and overview
- Use XML tags to structure sections
- Follow markdown formatting rules
- Include examples where helpful
- Use positive instructions

### **Step 3: Review**
- Check XML tag consistency
- Verify all links work
- Ensure no redundancy with existing files
- Estimate token count
- Test with AI agent if possible

### **Step 4: Integrate**
- Add reference to `ai-core-instructions.md`
- Update `ai-instructions-format.md` if new patterns used
- Update repository summary if significant
- Create pull request with clear description

### **Template for New Files**

Use this starter template:

```markdown
# [Descriptive Title]

[1-2 sentence overview of this module's purpose]

<primary_section>
## [Main Section Name]

[Instructions following positive instruction guidelines]

- Instruction 1
- Instruction 2
- Instruction 3
</primary_section>

<secondary_section>
## [Another Section Name]

[More instructions]
</secondary_section>

<examples>
## Examples

### Example 1: [Scenario]
[Few-shot example showing desired behavior]
</examples>

<additional_modules>
## Related Modules

- [related-file.md](./related-file.md) - Brief description
</additional_modules>
```
</creation_guidelines>

## Validation Checklist

<validation_checklist>
Before committing instruction file changes:

### **Structure**
- [ ] File has clear H1 title
- [ ] Overview paragraph explains purpose
- [ ] All major sections wrapped in XML tags
- [ ] XML tags use semantic naming
- [ ] All XML tags properly closed
- [ ] Consistent tag naming with other files

### **Content**
- [ ] Instructions are clear and specific
- [ ] Positive instructions used (what TO do)
- [ ] No duplicate information from other files
- [ ] Examples included where needed (3-5 diverse examples)
- [ ] Examples show both good and bad approaches
- [ ] File under 32K tokens (preferably 8-16K)

### **Formatting**
- [ ] Markdown follows style guide
- [ ] Code blocks have language identifiers
- [ ] Lists use `-` consistently
- [ ] Proper heading hierarchy (H1 > H2 > H3)
- [ ] Links use relative paths for internal files
- [ ] No trailing whitespace

### **Integration**
- [ ] Referenced in `ai-core-instructions.md` if required module
- [ ] Referenced in repository summary if significant
- [ ] Links from related modules updated
- [ ] No broken links

### **Testing**
- [ ] Read by AI agent successfully (if possible)
- [ ] Instructions clear to human readers
- [ ] No ambiguity or contradictions
- [ ] Tested with sample queries (if applicable)
</validation_checklist>

## References and Resources

<references>
### **Research Sources**

- [Anthropic Prompt Engineering Guide](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview)
- [Anthropic: Use XML Tags](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/use-xml-tags)
- [Anthropic: Claude 4 Best Practices](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/claude-4-best-practices)
- [Anthropic: Context Engineering for AI Agents](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents)
- [Few-Shot Prompting Guide](https://www.promptingguide.ai/techniques/fewshot)
- [Context Window Optimization Research](https://eval.16x.engineer/blog/llm-context-management-guide)
- [Token Optimization for LLMs](https://developer.ibm.com/articles/awb-token-optimization-backbone-of-effective-prompt-engineering/)

### **Related Documentation**

- [ai-core-instructions.md](./ai-core-instructions.md) - Core agent behaviors and guidelines
- [ai-creating-repository-summary.md](./ai-creating-repository-summary.md) - Repository summary creation
- [ai-custom-instructions-optimization.md](./ai-custom-instructions-optimization.md) - Optimization strategies research

### **Tools**

- **Token Counters:** OpenAI's tiktoken, Anthropic's token counter
- **Markdown Linters:** markdownlint, Prettier
- **Link Checkers:** markdown-link-check
</references>

## Version History

<version_history>
### v1.0.0 - 2025-10-18
- Initial creation as part of custom instructions optimization (Item 1)
- Documented XML tag structure and guidelines
- Added formatting rules for markdown
- Included consolidation guidelines
- Added few-shot example best practices
- Established validation checklist
</version_history>

---

**Last Updated:** 2025-10-18  
**Maintained By:** nam20485/agent-instructions repository  
**Status:** Canonical Reference - Active
