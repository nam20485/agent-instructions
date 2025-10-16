# Assignment: Initiate New Repository

## (initiate-new-repository)

### Goal

Your goal is to initiate a new repository for a project. This involves creating the repository, copying the provided files to the repository, configuring the necessary settings, and creating the initial administrative structure.

### Inputs

- `$context.repo_name`: New repository name (string)
- `$context.app_plan_docs`: App creation plan documents (list of file paths)

### Acceptance Criteria

1. Git repository created with proper configuration
2. App creation plan documents copied to `plan_docs/` directory
3. Git Project created for issue tracking
4. Milestones created based on application plan phases
5. Labels imported for issue management
6. Filenames changed to match project name

### Assignment
 
Your assignment is to initiate and set up a new repository for a project. This involves creating the repository and configuring the necessary settings. You will copy the provided app creation documents to the `plan_docs/` directory. You will create a new issue-tracking project, import labels, and create milestones. You will rename workspace and devcontainer files to match the project name.

### Detailed Steps

1. **Create Repository**
   - Let the new repo name be `$new_repo_name` = `${context.repo_name}_<random_word><random-2-digit-number>`
   - Example: `new-repo_sparrow23`
   - Create a new repository named `$new_repo_name`
   - New repository will be created from the `nam20485/ai-new-app-template` template repository
   - New repository will be created under the `nam20485` organization
   - Example: `nam20485/new-repo_sparrow23`
   - Public visibility   
   - GNU Affero license

2. **Clone Repository**- 
   - Let the new repo path be `$local_repo_path` = `./../dynamic_workflows/$new_repo_name`
   - Example: `./../dynamic_workflows/new-repo_sparrow23`
   - Clone the new repository to your local machine at destination `$local_repo_path`
   - Change directory to the new repository location path: `$local_repo_path`
   - Example: `$ cd $local_repo_path`

3. **Copy App Creation Plan Documents**
   - A list of app creation documents will be provided as an input to this assignment
   - The list of documents will be in the `$context.app_plan_docs` variable
   - Copy those files into the `plan_docs/` directory of the new repository

4. **Create GitHub Project for Issue Tracking**
   - Create a new GitHub Project for issue tracking
   - Name the project the same as the repository
   - Set the project to `Basic Kanban` template

5. **Import Labels**
   - Import the labels from the `.labels.json` file in the root of the repository
   - Use the `import-labels.ps1` script to import the labels

6. **Create Milestones**
   - Create milestones based on the application plan phases
   - Use the `create-milestones.ps1` script to create the milestones

7.  **Rename Workspace and Devcontainer Files**
   - Inside the `.devcontainer/devcontainer.json` file rename the `name` property to use the new repository name as the prefix, preserving the "devcontainer" suffix. Template: `<repo-name>-devcontainer`
   - Rename the `ai-new-app-template.code-workspace` file to use the new repository name as the prefix, preserving the ".code-workspace" extension. Template: `<repo-name>.code-workspace`

### Completion

After all steps have been completed, notify the orchestrator that the repository and obtain approval to move to the next step. The repository has been initiated and is ready for the next step.
