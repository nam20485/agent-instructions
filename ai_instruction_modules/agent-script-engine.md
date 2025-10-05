# Agent Script Engine

## Description
The Agent Script Engine is a powerful tool designed to extend custom prompt and command features of AI agents/chat clients such as VS Code, Claude Code, Gemini, and others. It provides a structured way to declare instructions that can be executed by these agents, allowing for more complex interactions and workflows.

## Features

The agent script is unique in that it does not require definition of the functions that are declared and used in the script. Instead, the script engine will automatically map the declared functions to the corresponding commands or actions supported by the target AI agent or chat client. This allows for a more seamless integration and reduces the need for boilerplate code. 

- The only requirement is that the functions and their signature are declared in the `declarations` section of the script prior to use.
- Once declared, the functions can be used directly in the `script` section of the agent script.
- When the script is executed, the engine will interpret the function calls and map them to the appropriate commands or actions supported by the target AI agent or chat client.
- The script can be executed using two strategies: JIT (Just-In-Time) or AOT (Ahead-Of-Time).
  - JIT execution means that the script is interpreted and executed line by line as it is encountered. This allows for more dynamic and flexible execution, as the script can adapt to changing conditions or inputs.
  - AOT execution means that the entire script is compiled and executed as a single unit. This can be more efficient for scripts that are static and do not require dynamic behavior.

### AOT vs JIT Execution

#### AOT (Ahead-Of-Time) Execution
- The entire script is compiled and executed as a single unit.
- The script is pre-compiled before execution, which can lead to faster performance for static scripts.
- During the pre-compilation phase, the engine processes the script, fills in the missing function definitions with agent executable instructions/tasks and then writes the compiled script out to a file named with the original filename with an `.aot` extension.
- The compiled script can then be executed directly by the target AI agent or chat client without the need for further interpretation or processing.
- A second pass is executed by the engine to ensure validity, documenting any errors found during the pre-compilation phase, and asking the user to fix them before attempting to re-compile the script, or if automatic fixing is possible, the engine will attempt to do so and notify the user of the changes made.
- A third phase is executed after the validity and fixes check, where the engine can perform optimizations. 
- In the optimization phase, the engine analyzes the script for any potential improvements or enhancements that can be made to improve performance or efficiency. This may include reordering instructions, removing redundant operations, or applying other optimization techniques to streamline the execution of the script.
- Optimizations are optional and can be enabled or disabled based on presenting to the user a list of potential optimizations that can be applied to the script, along with their expected impact on performance or efficiency. The user can then choose which optimizations to apply based on their specific needs and requirements.   
- Once the script has been optimized, a third file is written out with the original filename, an `.aot` and an `.opt` extension, containing the optimized version of the script.

#### JIT (Just-In-Time) Execution
- The script is interpreted and executed line by line as it is encountered.
- The script is executed dynamically, allowing for more flexibility and adaptability to changing conditions or inputs.
- The engine processes the script in real-time, interpreting each line and executing the corresponding commands or actions supported by the target AI agent or chat client.
- JIT execution is well-suited for scripts that require dynamic behavior or need to adapt to changing conditions or inputs during execution.
- JIT execution does not involve pre-compilation or optimization phases, as the script is executed directly as it is encountered.

### Script Structure

An agent script consists of three main sections: `inputs`, `declarations` and `script`.

- The `inputs` section is where the input parameters for the script are defined. This includes any variables or data that the script will use during execution.
- The `declarations` section is where the functions that will be used in the script are declared. Each function declaration includes the function name, parameters, and a brief description of its purpose.
- The `script` section is where the actual script logic is written. This is where the declared functions are used to perform various tasks and operations.

#### Syntax

See the dynamic workflow script syntax for details on the syntax used in the agent script engine.

- [dynamic workflow script syntax](./ai-workflow-assignments/dynamic-workflows/dynamic-workflow-syntax.md)

## Examples

### Example 1: Simple File Operations

This example demonstrates basic file operations like creating and reading files.

```markdown
# Simple File Operations Script

## Inputs
- filename: string - The name of the file to create
- content: string - The content to write to the file

## Declarations
function createFile(filename: string, content: string): void
function readFile(filename: string): string
function logMessage(message: string): void

## Script
logMessage("Creating file: " + filename)
createFile(filename, content)
logMessage("File created successfully")

result = readFile(filename)
logMessage("File contents: " + result)
```

### Example 2: Data Processing Pipeline

This example shows how to process data through multiple steps.

```markdown
# Data Processing Pipeline

## Inputs
- dataSource: string - The source of the data
- outputFormat: string - The desired output format

## Declarations
function fetchData(source: string): array
function filterData(data: array, condition: string): array
function transformData(data: array, format: string): object
function saveResults(data: object, destination: string): void

## Script
rawData = fetchData(dataSource)
filteredData = filterData(rawData, "status == active")
transformedData = transformData(filteredData, outputFormat)
saveResults(transformedData, "output/results.json")
```

### Example 3: Automated Testing Workflow

This example demonstrates a simple testing workflow.

```markdown
# Automated Testing Workflow

## Inputs
- testSuite: string - The test suite to run
- environment: string - The environment to test in

## Declarations
function setupEnvironment(env: string): void
function runTests(suite: string): object
function generateReport(results: object): string
function notifyTeam(message: string): void

## Script
setupEnvironment(environment)
testResults = runTests(testSuite)

if (testResults.failed > 0) {
    report = generateReport(testResults)
    notifyTeam("Tests failed! Report: " + report)
} else {
    notifyTeam("All tests passed successfully!")
}
```

### Example 4: Basic Code Analysis

This example shows how to analyze code files.

```markdown
# Code Analysis Script

## Inputs
- sourceDirectory: string - The directory containing source files

## Declarations
function listFiles(directory: string, pattern: string): array
function analyzeFile(filepath: string): object
function summarizeResults(results: array): object
function displayReport(summary: object): void

## Script
files = listFiles(sourceDirectory, "*.js")
results = []

for (file in files) {
    analysis = analyzeFile(file)
    results.append(analysis)
}

summary = summarizeResults(results)
displayReport(summary)
```

### Example 5: Simple Deployment Script

This example demonstrates a basic deployment workflow.

```markdown
# Simple Deployment Script

## Inputs
- applicationName: string - The name of the application
- targetEnvironment: string - The deployment target (dev, staging, prod)
- version: string - The version to deploy

## Declarations
function validateEnvironment(env: string): boolean
function buildApplication(app: string, ver: string): string
function deployToEnvironment(buildPath: string, env: string): boolean
function runHealthCheck(env: string): boolean
function rollback(env: string, previousVersion: string): void
function notifyDeployment(status: string, details: string): void

## Script
isValid = validateEnvironment(targetEnvironment)

if (!isValid) {
    notifyDeployment("failed", "Invalid environment: " + targetEnvironment)
    exit(1)
}

buildPath = buildApplication(applicationName, version)
deployed = deployToEnvironment(buildPath, targetEnvironment)

if (deployed) {
    healthy = runHealthCheck(targetEnvironment)
    if (healthy) {
        notifyDeployment("success", "Deployment completed successfully")
    } else {
        notifyDeployment("warning", "Deployment completed but health check failed")
        rollback(targetEnvironment, "previous")
    }
} else {
    notifyDeployment("failed", "Deployment failed")
}
```

## Additional Notes

- Function declarations do not need implementations - the engine maps them to agent capabilities
- Variables are dynamically typed and don't need explicit declarations
- Control flow structures (if/else, for loops) follow standard programming conventions
- The engine automatically handles type conversions and error handling
- Scripts can be as simple or complex as needed, from single-function calls to multi-step workflows
