<examples>
  <example id="xml-tag-structure">
    <description>Example of a complete file structure with XML tags.</description>
    <content>
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
    </content>
  </example>

  <example id="few-shot-template">
    <description>Template for few-shot examples.</description>
    <content>
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
    </content>
  </example>

  <example id="new-file-template">
    <description>Starter template for new instruction files.</description>
    <content>
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
    </content>
  </example>
</examples>
