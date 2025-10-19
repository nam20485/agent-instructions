# Creating Repository Custom Instructions

This file contains instructions for creating a custom summary of a repository.

## Goal

- Create custom summary of a repository.
- Place the custom instructions in the `.ai-repository-summary.md` file, located at the root of the repository.
- Link to other instruction files as needed.

## Documentation

- [Writing effective repository custom instructions](https://docs.github.com/en/copilot/how-tos/configure-custom-instructions/add-repository-instructions?tool=webui#creating-a-repository-custom-instructions-file)

* Note: You are not to write or include any instructions in this file, but to only use the instructions from the documentation that are relevant to creating a summary of the properties of a repository.

## Formatting Standards

When creating the repository summary file, follow the formatting standards defined in:
- [ai-instructions-format.md](./ai-instructions-format.md) - Canonical format reference for all instruction files

**Key Requirements:**
- Use XML semantic tags to structure major sections
- Follow markdown formatting guidelines
- Keep file under 32K tokens (preferably 8-16K)
- Use positive instructions (what TO do)
- Include examples where helpful
- See format guide for complete standards

## Instructions for Creating Repository Summary

Your task is to "onboard" this repository to Copilot coding agent by adding a `.ai-repository-summary.md` file in the repository that contains information describing how a coding agent seeing it for the first time can work most efficiently.

You will do this task only one time per repository and doing a good job can SIGNIFICANTLY improve the quality of the agent's work, so take your time, think carefully, and search thoroughly before writing the instructions.

- If file already exists, review it and update it as needed to ensure it is complete and accurate. 
- This assignment will be called successively in each stage, so you can add to it iteratively over time as you learn more about the repository.
- Whenever you make an update, before doing so, make a backup copy of the existing file so you can refer to it later if needed.
- Backup copy can be called `.ai-repository-summary-backup-<date-time>.md` and placed in the same directory as the original file.   

<Goals>
- Reduce the likelihood of a coding agent pull request getting rejected by the user due to
generating code that fails the continuous integration build, fails a validation pipeline, or
having misbehavior.
- Minimize bash command and build failures.
- Allow the agent to complete its task more quickly by minimizing the need for exploration using grep, find, str_replace_editor, and code search tools.
</Goals>

<Limitations>
- Instructions must be no longer than 2 pages.
- Instructions must not be task specific.
- Instructions MUST be specific to the repository.
</Limitations>

<WhatToAdd>

Add the following high level details about the codebase to reduce the amount of searching the agent has to do to understand the codebase each time:
<HighLevelDetails>

- A summary of what the repository does.
- High level repository information, such as the size of the repo, the type of the project, the languages, frameworks, or target runtimes in use.
</HighLevelDetails>

Add information about how to build and validate changes so the agent does not need to search and find it each time.
<BuildInstructions>

- For each of bootstrap, build, test, run, lint, and any other scripted step, document the sequence of steps to take to run it successfully as well as the versions of any runtime or build tools used.
- Each command should be validated by running it to ensure that it works correctly as well as any preconditions and postconditions.
- Try cleaning the repo and environment and running commands in different orders and document errors and and misbehavior observed as well as any steps used to mitigate the problem.
- Run the tests and document the order of steps required to run the tests.
- Make a change to the codebase. Document any unexpected build issues as well as the workarounds.
- Document environment setup steps that seem optional but that you have validated are actually required.
- Document the time required for commands that failed due to timing out.
- When you find a sequence of commands that work for a particular purpose, document them in detail.
- Use language to indicate when something should always be done. For example: "always run npm install before building".
- Record any validation steps from documentation.
</BuildInstructions>

List key facts about the layout and architecture of the codebase to help the agent find where to make changes with minimal searching.
<ProjectLayout>

- A description of the major architectural elements of the project, including the relative paths to the main project files, the location
of configuration files for linting, compilation, testing, and preferences.
- A description of the checks run prior to check in, including any GitHub workflows, continuous integration builds, or other validation pipelines.
- Document the steps so that the agent can replicate these itself.
- Any explicit validation steps that the agent can consider to have further confidence in its changes.
- Dependencies that aren't obvious from the layout or file structure.
- Finally, fill in any remaining space with detailed lists of the following, in order of priority: the list of files in the repo root, the
contents of the README, the contents of any key source files, the list of files in the next level down of directories, giving priority to the more structurally important and snippets of code from key source files, such as the one containing the main method.
</ProjectLayout>
</WhatToAdd>

<StepsToFollow>
- Perform a comprehensive inventory of the codebase. Search for and view:
   - README.md, CONTRIBUTING.md, and all other documentation files.
   - Search the codebase for build steps and indications of workarounds like 'HACK', 'TODO', etc.
   - All scripts, particularly those pertaining to build and repo or environment setup.
   - All build and actions pipelines.
   - All project files.
   - All configuration and linting files.
- For each file:
   - Think: is the content (or existence) something the coding agent will need to implement, build, test, validate, or demo a code change?
   - If yes:
      - Document the command or information in detail.
      - Explicitly indicate which commands work and which do not and the order in which commands should be run.
      - Document any errors encountered and the steps taken to work around them.
- Document any other steps or information that the agent can use to reduce time spent exploring or running failing commands.
- Finally, explicitly instruct the agent to trust the instructions and only perform a search if the information in the instructions is incomplete or found to be in error.
</StepsToFollow>

## Writing effective repository custom instructions
The instructions you add to your custom instruction file(s) should be short, self-contained statements that provide Copilot with relevant information to help it work in this repository. Because the instructions are sent with every chat message, they should be broadly applicable to most requests you will make in the context of the repository.

The exact structure you utilize for your instructions file(s) will vary by project and need, but the following guidelines provide a good starting point:

- Provide an overview of the project you're working on, including its purpose, goals, and any relevant background information.
- Include the folder structure of the repository, including any important directories or files that are relevant to the project.
- Specify the coding standards and conventions that should be followed, such as naming conventions, formatting rules, and best practices.
- Include any specific tools, libraries, or frameworks that are used in the project, along with any relevant version numbers or configurations.

### Example

The following instructions file(s) is an example of these practices in action:

```markdown
# Project Overview

This project is a web application that allows users to manage their tasks and to-do lists. It is built using React and Node.js, and uses MongoDB for data storage.

## Folder Structure

- `/src`: Contains the source code for the frontend.
- `/server`: Contains the source code for the Node.js backend.
- `/docs`: Contains documentation for the project, including API specifications and user guides.

## Libraries and Frameworks

- React and Tailwind CSS for the frontend.
- Node.js and Express for the backend.
- MongoDB for data storage.
```
