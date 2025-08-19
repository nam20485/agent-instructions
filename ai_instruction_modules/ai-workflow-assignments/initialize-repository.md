# Assignment: Initialize Repository

## (initialize-repository)

### Goal

Your goal is to initialize a new repository for a project. This involves creating the repository, copying the provided files to the repository, configuring the necessary settings, and creating the intitial administrative structure.

### Inputs

1. New repository name (string)
2. App creation plan documents (list, file)

### Acceptance Criteria

1. Git repository created with proper configuration
2. App creation plan documents copied to `docs/` directory
3. Git Project created for issue tracking
4. Milestones created based on application plan phases
5. Labels imported for issue management
6. Filenames changed to match project name

### Assignment

Your assignment is to initialize and setup a new repository for a project. This involves creating the repository, configuring the necessary settings. You will copy the provided app creation documents to the `docs/` directory. You wil create a new issue-trackng project, import labels, and create milestones. You will rename workspace and devcontainer files to match the project name. You will 

### Detailed Steps

1. **Create Repository**
   - Create a new repository with the provided name
   - New repository will be created from the `nam20485/ai-new-app-template` template repository
   - New repository wil be created under the `nam20485` organization
   - Public visibility
   - GNU Affero license

2. **Copy App Creation Plan Documents**
   - A list of app creation documents will be provided as an input to this assignment
   - Copy those files into the `docs/` directory of the new repository

3. **Create GitHub Project for Issue Tracking**
   - Create a new GitHub Project for issue tracking
   - Name the project the same as the repository
   - Set the project to `Basic Kanban` template

4. **Import Labels**
   - Import the labels from the `.labels.json` file in the root of the repository
   - Use the `import-labels.ps1` script to import the labels

5. **Create Milestones**
   - Create milestones based on the application plan phases
   - Use the `create-milestones.ps1` script to create the milestones

6. **Rename Workspace and Devcontainer Files**
   - Inside the `.devcontainer/devcontainer.json` file rename the `name` property to use the new repository name as the prefix,preseving the "devcontainer" suffix. Template: `<repo-name>-devcontainer`
   -  Rename the `ai-new-app-template.code-workspace` file to use the new repository name as the prefix, preseving the ".workspace" extension. Template: `<repo-name>.code-workspace`

### Completion
After all steps have been completed, notify the orchestrator that the repository and obtain approval to move to the next step. The repository has been initialized and is ready for the next step.
