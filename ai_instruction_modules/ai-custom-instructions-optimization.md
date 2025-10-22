<optimization_plan>
# Custom Instructions Optimization to Improve Context Retention

<canonical_reference>
## Canonical Format Reference

All optimization strategies are documented and enforced in the canonical format guide:
- [ai-instructions-format.md](./ai-instructions-format.md) - Complete formatting standards and guidelines

This document tracks the implementation plan for these strategies.
</canonical_reference>

<strategies>
## Explicit Strategies

The following strategies will be employed. **Do not worry or waste time on any other strategies not listed here.**

Given these strategies:

- Implement XML tags for better structure and clarity
- Maintain consistent formatting for improved parsing

- Consolidate related instructions into fewer, longer files
    - This is two techniques in one: 
        - Convert multiple short files into fewer longer files
        - Remove redundant or overlapping instructions from multiple files

- Curate diverse few-shot examples to guide model behavior
- Use explicit, positive instructions to reduce ambiguity
</strategies>

<important_notes>
## Important notes:

- Remember that mulitple agents all use these same instrcution files:
    - GitHub Copilot
    - Claude Code CLI
    - Gemini Code Asssist
    - Gemini CLI
    - Qwen Code CLI
    - Opencode.ai
</important_notes>

<task>
## Your Task

- STEP 1
Analyze the exiting custom instruction files to create a plan to implement the above strategies. 

- You will not change anything yet.
- You will only create a plan. 

Use the promtpt below to guide your analysis.

## Files to Analyze

`ai_instruction_modules/`

- everything except:
    `ai-workflow-assignments/`
    - anything in a `.wip/` folder


**YOU USE THINKING STEPS TO BREAK DOWN THE PROBLEM AND REACH A SOLUTION. DO NOT RUSH.**
**YOU MUST USE SEQUENTIAL REASONING and MEMORY TOOLS**


## PROMPT

```
Do some research on the internet re: context & custom instruction optimization.

-List, document the techniques you find
-Analyze the options wrt implementation complexity vs. performance gain
-Identify a set of those with a good ratio of easily-implemented to performance gain

-Example: Anthropic's site states that using a form of formatted/marked up text like XML can help the model process the text more easily
-Example 2: fewer, longer files are better than many short ones

Refer to the [ai-custom-instructions-optimization.md](/ai_instruction_modules/ai-custom-instructions-optimization.md) file for the strategies to be implemented.
```
</task>
</optimization_plan>