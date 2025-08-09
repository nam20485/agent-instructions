# Feedback on Custom Instructions for GitHub Copilot and Gemini Chat Agents

## Overview

I've analyzed your custom instructions for GitHub Copilot and Gemini Chat agents. These instructions are comprehensive and well-structured, providing detailed guidance across multiple aspects of development work. Below is my analysis and feedback organized by strengths, areas for improvement, and specific recommendations.

## Strengths

### 1. Comprehensive Technical Focus

- **Clear expertise definition**: Instructions clearly establish the AI as an expert in ASP.NET Core, Blazor WebAssembly, Docker, and Google Cloud.
- **Technology-specific guidance**: Detailed guidance for frameworks, design patterns, and best practices.
- **Documentation links**: References to official documentation sources improve accuracy.

### 2. Modular Structure

- **Well-organized modules**: Breaking instructions into focused modules (deployment, testing, workflow, etc.) makes maintenance easier.
- **Selective inclusion**: Comment-based inclusion system allows for customizing which modules are active.
- **Cross-referencing**: Modules reference each other effectively.

### 3. Process Definition

- **Task-based workflow**: Clearly defined issue-driven development process.
- **Memory management**: Structured approach to maintaining context across sessions.
- **Role-based workflows**: Differentiated responsibilities for orchestrators vs. collaborators.

### 4. Quality Assurance

- **Testing guidelines**: Strong emphasis on TDD approach and test coverage.
- **Code quality standards**: SOLID principles, design patterns, and naming conventions.
- **Validation steps**: Clear requirements for validating changes before completion.

## Areas for Improvement

### 1. Clarity and Conciseness

- **Verbose sections**: Some modules contain lengthy explanations that could be condensed.
- **Redundancy**: Overlap between modules (e.g., design principles appear in multiple places).
- **Active file issues**: The `ai_instruction_modules/ai-workflow-assignments/breakdown-issue.md` file contains numerous typos and unclear instructions.

### 2. Prioritization and Conflict Resolution

- **Guidance hierarchy**: No clear system for resolving conflicts between different instruction modules.
- **Critical vs. optional**: Limited distinction between must-follow rules and guidelines.

### 3. Personalization and Learning

- **Personal preferences**: Limited guidance on your individual preferences beyond technical requirements.
- **Feedback incorporation**: No explicit mechanism for the AI to improve based on your feedback.

### 4. Real-world Contextualization

- **Examples**: Limited concrete examples of desired outputs or interactions.
- **Counter-examples**: Few examples of what to avoid or common mistakes.

## Specific Recommendations

### 1. Add an Executive Summary Module

```markdown
# Executive Summary: Core Principles

As an AI assistant for this workspace, always prioritize:

1. **Task-based workflow**: Document work in GitHub issues, break down complex tasks
2. **Quality-first approach**: TDD, 80%+ test coverage, SOLID principles
3. **Technology stack**: ASP.NET Core, Blazor WASM, Docker, Google Cloud
4. **Documentation**: README.md, OpenAPI, XML comments

When conflicting guidance exists between modules, follow this priority order:
1. User's explicit instructions in the current session
2. Project-specific guidelines (if established)
3. Technology-specific best practices from [`ai_instruction_modules/ai-instructions-aspnet-guidelines.md`](ai_instruction_modules/ai-instructions-aspnet-guidelines.md )
4. General design principles from [`ai_instruction_modules/ai-design-principles.md`](ai_instruction_modules/ai-design-principles.md )
```

### 2. Clean Up the Active File

The `breakdown-issue.md` file contains numerous typos and unclear instructions. I recommend revising it to:

```markdown
# Breakdown Issue Assignment

## Description

Create sub-issues for each phase's remaining implementation in the parent issue. For each phase:

1. Create a sub-issue that addresses the implementation tasks left to complete
2. Break down implementation into detailed, step-by-step plans
3. Include comprehensive information:
   - Explanation of what needs to be done
   - Tools and technologies to use
   - Overall goals and acceptance criteria
   - Potential risks and mitigation strategies
   - Prerequisites, dependencies, and potential roadblocks

## Inputs

- __repo: Repository where issues will be created
- __issue: Parent issue number to reference in sub-issues

## Example Sub-Issue Structure

```yaml
title: "Phase 2: Implement User Authentication"
body: |
  This sub-issue addresses the remaining implementation tasks for Phase 2 (User Authentication) from parent issue #42.
  
  ## Goals
  - Complete Google OAuth integration for user authentication
  - Implement secure token storage and validation
  - Add role-based authorization
  
  ## Step-by-Step Implementation Plan
  1. [ ] Configure Google OAuth client credentials
     - Create credentials in Google Cloud Console
     - Add redirect URIs for local development and production
  
  2. [ ] Implement authentication flow in Blazor client
     - Add authentication state provider
     - Create login/logout components
     - Handle token storage securely
  
  3. [ ] Configure backend authentication middleware
     - Validate tokens on protected endpoints
     - Implement role-based policies
  
  ## Acceptance Criteria
  - Users can log in using Google account
  - Authentication state persists across page refreshes
  - Protected resources require valid authentication
  - Authorization rules enforce proper access control
  
  ## Dependencies
  - Requires Google Cloud project setup (completed in Phase 1)
  
  ## Risks and Mitigations
  - Risk: Token expiration could lead to poor UX
    Mitigation: Implement silent refresh mechanism
  
  Parent: #42
```
```

### 3. Add Personalization Module

Create a new module called `ai-personal-preferences.md`:

```markdown
# Personal Preferences

## Communication Style
- Prefer concise explanations with technical depth over lengthy general explanations
- Present code changes in small, logical chunks with explanations for each change
- Use comparisons to illustrate trade-offs between different approaches
- Always validate changes by running appropriate commands before suggesting application

## Decision Points
- When multiple approaches exist, present 2-3 options with pros/cons before implementing
- For architectural decisions, prefer maintainability and testability over premature optimization
- For UI/UX suggestions, prioritize functionality first, then enhance with usability improvements
- When uncertain about a preference, ask specific questions rather than making assumptions

## Learning and Improvement
- When I provide feedback on your suggestions, incorporate these learnings into future interactions
- If I reference specific patterns or approaches I've used before, adapt to match those patterns
- Note when I consistently choose certain approaches over others and prioritize those in future recommendations
```

### 4. Consolidate Redundant Information

Several modules contain overlapping information. Consider:

1. Merging redundant sections in design principles and ASP.NET guidelines
2. Creating a clear hierarchy of which guidelines take precedence
3. Using a "core principles" vs "detailed guidelines" structure to separate essential rules from expansive guidance

### 5. Add Examples of Desired Outputs

For key workflows, include examples of what good output looks like:

```markdown
## Example: Good Task Breakdown

### ✅ GOOD EXAMPLE - Specific and Actionable
```
title: "Implement User Authentication with Google OAuth"
body: |
  ## Description
  Add Google OAuth-based authentication to the web application to secure user access and enable personalized features.
  
  ## Steps
  1. [ ] Create Google OAuth credentials in Google Cloud Console
     - Set up OAuth consent screen with appropriate scopes
     - Configure authorized redirect URIs
     - Store client ID and secret in appropriate configuration
  
  2. [ ] Implement authentication in Blazor WebAssembly client
     - Add Microsoft.AspNetCore.Components.WebAssembly.Authentication package
     - Configure AuthenticationStateProvider
     - Create login/logout UI components
  
  ...
```

### ✅ GOOD EXAMPLE - Task Issue Comment Update
```
I've completed steps 1-3:

1. ✅ Created Google OAuth credentials
   - Added project to Google Cloud Console
   - Configured consent screen with "email" and "profile" scopes
   - Added localhost and production redirect URIs

2. ✅ Implemented authentication in Blazor client
   - Added Microsoft.AspNetCore.Components.WebAssembly.Authentication v7.0.5
   - Created AuthenticationService implementation
   - Added login/logout components to MainLayout

3. ✅ Configured backend middleware
   - Added JWT validation middleware
   - Configured required claims

The implementation passes all authentication tests. Moving on to step 4 (role-based authorization).
```

### ❌ BAD EXAMPLE - Too Vague
```
title: "Add authentication"
body: |
  Need to add user login to the application.
  
  ## Steps
  1. [ ] Set up OAuth
  2. [ ] Add login to frontend
  3. [ ] Make backend secure
```
```

## Conclusion

Your custom instructions provide an excellent foundation for guiding AI assistants in your development workflow. They demonstrate a sophisticated understanding of how to effectively structure AI interactions for software development. With the suggested improvements, you can make these instructions even more effective by:

1. Improving clarity and reducing redundancy
2. Adding clear prioritization for conflicting guidance
3. Incorporating personalization and learning mechanisms
4. Providing concrete examples of desired outputs

These enhancements will help the AI better understand your expectations and deliver more consistent, high-quality assistance aligned with your development practices.
