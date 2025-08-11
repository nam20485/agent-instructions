# Feedback on the Modular AI Instruction Framework

This document provides a framework for analyzing and improving the modular instruction files located in the `ai_instruction_modules/` directory. The modular system you've designed is an excellent and scalable approach. The key to its success is ensuring each module is clear, distinct, and actionable.

## General Principles for Modular Instructions

For each file in the `ai_instruction_modules` directory, consider the following:

1.  **Clear Purpose:** Does the file have a single, clearly defined purpose that is accurately reflected in its filename?
2.  **No Overlap:** Does the content of this file overlap significantly with another module? If so, consider merging them or more clearly defining their boundaries.
3.  **Actionability:** Are the instructions specific and directive? Avoid vague statements. For example, instead of "Follow good coding practices," specify *what* those practices are (e.g., "All public methods must have XML documentation comments").
4.  **Use Examples:** Just like in the main instruction file, few-shot examples are incredibly powerful. For a module like `ai-testing-validation.md`, include a small, complete example of a well-written unit test.
5.  **Negative Constraints:** What should the AI *not* do within the context of this module? For `ai-deployment-environment.md`, a good negative constraint would be, "Do not use any Google Cloud services that are in pre-GA (beta, alpha) stages."

## Analysis of Specific Modules (Based on Filenames)

Here are specific points to consider for your modules.

*   **`ai-quick-reference.md`**
    *   **Purpose:** This should be a very concise summary of the most critical, high-level instructions. Think of it as the "cheat sheet." It should probably contain the core persona and the interactive workflow loop.

*   **`ai-workflow-config.md` & `ai-task-based-workflow.md`**
    *   **Potential Overlap:** The names suggest these are closely related. Review them to ensure their roles are distinct. Perhaps `ai-workflow-config.md` defines the *tools* and *settings* for the workflow (e.g., terminal behavior, file access), while `ai-task-based-workflow.md` defines the *process* (e.g., "When asked to add a feature, first create a new branch...").

*   **`ai-workflow-roles.md` & `ai-workflow-assignments.md`**
    *   **Clarity is Key:** This is a very advanced concept. Ensure the roles (e.g., "Developer," "Tester," "Reviewer") are explicitly defined with their responsibilities. The `assignments.md` file should provide clear triggers for when the AI should adopt a specific role. For example: "When the user prompt includes the phrase 'review this PR', you will adopt the 'Code Reviewer' role."

*   **`ai-application-guidelines.md`, `ai-design-principles.md`, `ai-instructions-aspnet-guidelines.md`**
    *   **Potential Overlap:** These three files risk containing redundant or conflicting information. Consider defining clear boundaries:
        *   `ai-design-principles.md`: High-level, abstract principles (e.g., SOLID, DRY, YAGNI).
        *   `ai-application-guidelines.md`: Concrete project-level rules (e.g., naming conventions, project folder structure, logging standards).
        *   `ai-instructions-aspnet-guidelines.md`: Technology-specific rules (e.g., "Use Minimal APIs for new endpoints," "Prefer Data Transfer Objects (DTOs) over exposing domain models directly," "Use the Community Toolkit MVVM library for observable properties").

*   **`ai-testing-validation.md`**
    *   **Be Specific:** This file should specify the exact testing frameworks to use (e.g., xUnit, Moq, bUnit). It should define the scope of testing (e.g., "All new business logic must have at least 80% unit test coverage"). Include a template or example of a good test class.

*   **`ai-new-app-template.md`**
    *   **Provide the Template:** This file should contain the literal `dotnet new` command (or script) to be used, including all desired parameters, to ensure every new application is created identically.

*   **`ai-tools-config.md`**
    *   **Create an "Allowlist":** This is the perfect place to list all approved NuGet packages, CLI tools, and their preferred versions. This is a powerful way to enforce consistency. You can also create a "Denylist" of packages to avoid.

## Next Steps

1.  Review each modular file against the principles above.
2.  Refine the content to make it more specific, actionable, and distinct.
3.  Add concrete examples and negative constraints where appropriate.

By applying this structured analysis, you can further enhance your already impressive AI instruction framework, leading to even more consistent and high-quality results.

I have created the two feedback documents. Please let me know if you'd like me to apply any of the suggested changes to your instruction files.

Gemini Code Assist supports plain-text files. Other file types, like PDFs and images, are not directly supported at this time. If a version of the file is available in a plain text format, please use that instead, or copy the relevant contents from the file into your prompt.
