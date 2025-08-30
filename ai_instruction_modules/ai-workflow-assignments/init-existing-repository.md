# Assignment: Initiate Existing Repository

## (init-existing-repository)

### Goal

Your goal is to initiate a new repository for a project. This involves creating the repository, copying the provided files to the repository, configuring the necessary settings, and creating the initial administrative structure.

### Inputs

### Acceptance Criteria

1. Git Project created for issue tracking
2. Milestones created based on application plan phases
3. Labels imported for issue management
4. Filenames changed to match project name

### Assignment
 
Your assignment is to set up am existing repository for a project. This involves configuring the necessary settings. You will create a new issue-tracking project, import labels, and create milestones. You will rename workspace and devcontainer files to match the project name.

### Detailed Steps

1. **Create GitHub Project for Issue Tracking**
   - Create a new GitHub Project for issue tracking
   - Name the project the same as the repository
   - Set the project to `Basic Kanban` template

2. **Import Labels**
   - Import the labels from the `.labels.json` file in the root of the repository
   - Use the `import-labels.ps1` script to import the labels

3. **Create Milestones**
   - Create milestones based on the application plan phases
   - Use the `create-milestones.ps1` script to create the milestones

4.  **Rename Workspace and Devcontainer Files**
   - Inside the `.devcontainer/devcontainer.json` file rename the `name` property to use the repository name as the prefix, preserving the "devcontainer" suffix. Template: `<repo-name>-devcontainer`
   - Rename the `ai-new-app-template.code-workspace` file to use the repository name as the prefix, preserving the ".code-workspace" extension. Template: `<repo-name>.code-workspace`

### Completion

After all steps have been completed, notify the orchestrator that the repository and obtain approval to move to the next step. The repository has been initiated and is ready for the next step.
