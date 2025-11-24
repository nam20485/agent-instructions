---
description: Guidelines for PowerShell cmdlet development, naming, safety, and testing.
scope: powershell-development
prerequisites: ai-development-environment-guide.md
---
# PowerShell Cmdlet Development Guidelines

<xml>
<instructions role="powershell-developer" scope="powershell-development">

<naming_conventions>
## Naming Conventions
- **Verb-Noun:** `Get-Verb` (approved verbs), singular noun, PascalCase.
- **Params:** PascalCase, descriptive, singular (unless array).
- **Vars:** PascalCase (public), camelCase (private).
- **Cmdlets:** Use full names in scripts (`Get-ChildItem` vs `gci`).
</naming_conventions>

<parameter_design>
## Parameter Design
- **Standard:** `Path`, `Name`, `Force`.
- **Types:** Strong typing, `[ValidateSet]`, `[ValidateNotNullOrEmpty]`.
- **Switches:** `[switch]` for flags (default false).
- **Attributes:** `[Parameter(Mandatory)]`, `ValueFromPipeline`.
</parameter_design>

<pipeline_output>
## Pipeline and Output
- **Input:** `ValueFromPipeline` (object), `ValueFromPipelineByPropertyName` (property).
- **Output:** `PSCustomObject` (structured), `Write-Output` (data).
- **No-No:** `Write-Host` for data (UI only).
- **Streaming:** Process one-by-one in `process` block.
- **PassThru:** Return object only if `-PassThru` switch is present.
</pipeline_output>

<safety_error_handling>
## Safety & Error Handling
- **Safety:** `[CmdletBinding(SupportsShouldProcess)]`, `$PSCmdlet.ShouldProcess()`.
- **Streams:** `Write-Verbose`, `Write-Warning`, `Write-Error`.
- **Errors:** `try/catch`, `ErrorActionPreference = 'Stop'`, `throw` (terminating).
- **Non-Interactive:** No `Read-Host`. Use params.
</safety_error_handling>

<documentation_style>
## Documentation & Style
- **Help:** Comment-based help (`.SYNOPSIS`, `.DESCRIPTION`, `.EXAMPLE`).
- **Style:** 4 spaces, OTBS braces, PascalCase.
- **Aliases:** Never in scripts (`Where-Object` vs `?`).
</documentation_style>

<modules>
## Modules
- **Structure:** `MyTools/` (root), `.psd1` (manifest), `.psm1` (loader), `Public/`, `Private/`.
- **Exports:** Explicit `Export-ModuleMember` or manifest `FunctionsToExport`.
- **Versioning:** Semantic versioning in manifest.
- **Loading:** `Import-Module`, `$env:PSModulePath` for autoloading.
</modules>

<testing>
## Testing (Pester)
- **Requirement:** Tests for all shared code.
- **Files:** `*.Tests.ps1` alongside code or in `Tests/`.
- **Pattern:** AAA (Arrange, Act, Assert) with `Should`.
- **Mocking:** `Mock` dependencies, `InModuleScope` for internals.
- **Run:** `Invoke-Pester -CI`.
</testing>

## Examples

<see example="examples/powershell-examples.md" />

</instructions>
</xml>
