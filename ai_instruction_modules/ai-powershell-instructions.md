<powershell_guidelines>
# PowerShell Cmdlet Development Guidelines

This guide provides PowerShell-specific instructions to help GitHub Copilot generate idiomatic, safe, and maintainable scripts. It aligns with Microsoft's PowerShell cmdlet development guidelines.

<naming_conventions>
## Naming Conventions

- **Verb-Noun Format:**
  - Use approved PowerShell verbs (Get-Verb)
  - Use singular nouns
  - PascalCase for both verb and noun
  - Use letters, numbers, and hyphens only

- **Parameter Names:**
  - Use PascalCase
  - Choose clear, descriptive names
  - Use singular form unless always multiple
  - Follow PowerShell standard names

- **Variable Names:**
  - Use PascalCase for public variables
  - Use camelCase for private variables
  - Use complete, descriptive names (no abbreviations)
  - Use meaningful names

- **Cmdlet and Parameter Names:**
  - Use full cmdlet names in scripts (e.g., Get-ChildItem instead of gci)
  - Use full parameter names (not abbreviations)
  - Document any custom aliases
  - Aliases acceptable for interactive shell only

### Example

```powershell
function Get-UserProfile {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Username,

        [Parameter()]
        [ValidateSet('Basic', 'Detailed')]
        [string]$ProfileType = 'Basic'
    )

    process {
        # Logic here
    }
}
```
</naming_conventions>

<parameter_design>
## Parameter Design

- **Standard Parameters:**
  - Use common parameter names (`Path`, `Name`, `Force`)
  - Follow built-in cmdlet conventions
  - Use aliases for specialized terms
  - Document parameter purpose

- **Parameter Names:**
  - Use singular form unless always multiple
  - Choose clear, descriptive names
  - Follow PowerShell conventions
  - Use PascalCase formatting

- **Type Selection:**
  - Use common .NET types
  - Implement proper validation
  - Consider ValidateSet for limited options
  - Enable tab completion where possible

- **Switch Parameters:**
  - Use [switch] for boolean flags
  - Use switch parameters instead of $true/$false parameters
  - Default to $false when omitted
  - Use clear action names

### Example

```powershell
function Set-ResourceConfiguration {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        
        [Parameter()]
        [ValidateSet('Dev', 'Test', 'Prod')]
        [string]$Environment = 'Dev',
        
        [Parameter()]
        [switch]$Force,
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string[]]$Tags
    )
    
    process {
        # Logic here
    }
}
```

## Pipeline and Output

- **Pipeline Input:**
  - Use `ValueFromPipeline` for direct object input
  - Use `ValueFromPipelineByPropertyName` for property mapping
  - Implement Begin/Process/End blocks for pipeline handling
  - Document pipeline input requirements

- **Output Objects:**
  - Return rich objects, not formatted text
  - Use PSCustomObject for structured data
  - Use Write-Output or return statement for data (Write-Host for UI only)
  - Enable downstream cmdlet processing

- **Pipeline Streaming:**
  - Output one object at a time
  - Use process block for streaming
  - Stream objects immediately instead of collecting arrays
  - Enable immediate processing

- **PassThru Pattern:**
  - Default to no output for action cmdlets
  - Implement `-PassThru` switch for object return
  - Return modified/created object with `-PassThru`
  - Use verbose/warning for status updates

### Example

```powershell
function Update-ResourceStatus {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$Name,

        [Parameter(Mandatory)]
        [ValidateSet('Active', 'Inactive', 'Maintenance')]
        [string]$Status,

        [Parameter()]
        [switch]$PassThru
    )

    begin {
        Write-Verbose "Starting resource status update process"
        $timestamp = Get-Date
    }

    process {
        # Process each resource individually
        Write-Verbose "Processing resource: $Name"
        
        $resource = [PSCustomObject]@{
            Name = $Name
            Status = $Status
            LastUpdated = $timestamp
            UpdatedBy = $env:USERNAME
        }

        # Only output if PassThru is specified
        if ($PassThru) {
            Write-Output $resource
        }
    }

    end {
        Write-Verbose "Resource status update process completed"
    }
}
 ```

## Error Handling and Safety

- **ShouldProcess Implementation:**
  - Use `[CmdletBinding(SupportsShouldProcess = $true)]`
  - Set appropriate `ConfirmImpact` level
  - Call `$PSCmdlet.ShouldProcess()` for system changes
  - Use `ShouldContinue()` for additional confirmations

- **Message Streams:**
  - `Write-Verbose` for operational details with `-Verbose`
  - `Write-Warning` for warning conditions
  - `Write-Error` for non-terminating errors
  - `throw` for terminating errors
  - Use `Write-Host` only for user interface text, not data output

- **Error Handling Pattern:**
  - Use try/catch blocks for error management
  - Set appropriate ErrorAction preferences
  - Return meaningful error messages
  - Use ErrorVariable when needed
  - Include proper terminating vs non-terminating error handling

- **Non-Interactive Design:**
  - Accept input via parameters
  - Use parameters instead of `Read-Host` in scripts
  - Support automation scenarios
  - Document all required inputs

### Example

```powershell
function Remove-UserAccount {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]$Username,

        [Parameter()]
        [switch]$Force
    )

    begin {
        Write-Verbose "Starting user account removal process"
        $ErrorActionPreference = 'Stop'
    }

    process {
        try {
            # Validation
            if (-not (Test-UserExists -Username $Username)) {
                Write-Error "User account '$Username' not found"
                return
            }

            # Confirmation
            $shouldProcessMessage = "Remove user account '$Username'"
            if ($Force -or $PSCmdlet.ShouldProcess($Username, $shouldProcessMessage)) {
                Write-Verbose "Removing user account: $Username"
                
                # Main operation
                Remove-ADUser -Identity $Username -ErrorAction Stop
                Write-Warning "User account '$Username' has been removed"
            }
        }
        catch [Microsoft.ActiveDirectory.Management.ADException] {
            Write-Error "Active Directory error: $_"
            throw
        }
        catch {
            Write-Error "Unexpected error removing user account: $_"
            throw
        }
    }

    end {
        Write-Verbose "User account removal process completed"
    }
}
```

## Documentation and Style

- **Comment-Based Help:** Include comment-based help for any public-facing function or cmdlet. Inside the function, add a `<# ... #>` help comment with at least:
  - `.SYNOPSIS` Brief description
  - `.DESCRIPTION` Detailed explanation
  - `.EXAMPLE` sections with practical usage
  - `.PARAMETER` descriptions
  - `.OUTPUTS` Type of output returned
  - `.NOTES` Additional information

- **Consistent Formatting:**
  - Follow consistent PowerShell style
  - Use proper indentation (4 spaces recommended)
  - Opening braces on same line as statement
  - Closing braces on new line
  - Use line breaks after pipeline operators
  - PascalCase for function and parameter names
  - Use consistent, minimal whitespace

- **Pipeline Support:**
  - Implement Begin/Process/End blocks for pipeline functions
  - Use ValueFromPipeline where appropriate
  - Support pipeline input by property name
  - Return proper objects, not formatted text

- **Full Cmdlet Names:** Use complete cmdlet names and parameters in scripts
  - Use full cmdlet names in scripts (e.g., Get-ChildItem instead of gci); aliases acceptable for interactive shell only
  - Use `Where-Object` instead of `?` or `where`
  - Use `ForEach-Object` instead of `%`
  - Use `Get-ChildItem` instead of `ls` or `dir`

## Modules

PowerShell modules package reusable functions, aliases, and resources into a unit that can be versioned, shared, and auto-loaded. Prefer modules over copying functions between scripts.

### Types of modules

- Script module: a `.psm1` file that contains PowerShell code (most common)
- Binary module: a compiled .NET assembly (`.dll`) that exports cmdlets
- Manifest: a `.psd1` file describing metadata (version, dependencies, exports)
- Nested/required modules: dependencies referenced by the manifest

### Recommended layout

Use a module root folder matching the module name and keep public and private functions separate:

```
MyTools\
  MyTools.psd1          # Module manifest (metadata)
  MyTools.psm1          # Root script module (loads other files)
  Public\               # Exported functions
    Get-Thing.ps1
    New-Thing.ps1
  Private\              # Internal helpers (not exported)
    Convert-Internal.ps1
```

MyTools.psm1 typically dot-sources function files, then explicitly exports selected members:

```powershell
# MyTools.psm1
$public  = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public') -Filter *.ps1 -ErrorAction SilentlyContinue
$private = Get-ChildItem -Path (Join-Path $PSScriptRoot 'Private') -Filter *.ps1 -ErrorAction SilentlyContinue

foreach ($file in @($public + $private)) { . $file.FullName }

# Export only the public functions
Export-ModuleMember -Function ($public | ForEach-Object { $_.BaseName })
```

Create a module manifest to describe metadata, dependencies, and exports:

```powershell
$manifestParams = @{
  Path                  = '.\MyTools\MyTools.psd1'
  RootModule            = 'MyTools.psm1'
  ModuleVersion         = '1.0.0'
  Author                = 'Your Name'
  Description           = 'Utilities for working with Things'
  PowerShellVersion     = '7.2'
  CompatiblePSEditions  = @('Core')
  RequiredModules       = @('Microsoft.PowerShell.Management')
}
New-ModuleManifest @manifestParams
```

Notes:
- Prefer explicit exports via `Export-ModuleMember` or the manifest `FunctionsToExport`/`AliasesToExport`/`CmdletsToExport`.
- Version modules semantically. Breaking changes require a major version bump.
- Keep the module name, folder name, and manifest `ModuleName` aligned (e.g., `MyTools`).

### Using modules

- Local import (from current repo):

```powershell
Import-Module -Name (Resolve-Path './MyTools/MyTools.psd1') -Force -ErrorAction Stop
Get-Command -Module MyTools
```

- Autoloading: If the module folder is on `$env:PSModulePath` and you call an exported command, PowerShell will import the module automatically.

- PSModulePath: Add a repo-level modules directory for team reuse (Windows example):

```powershell
$modulesPath = 'C:\src\psmodules'
[Environment]::SetEnvironmentVariable('PSModulePath', "$env:PSModulePath;$modulesPath", 'User')
```

- Install from a repository (PowerShellGet):

```powershell
Find-Module -Name Pester | Select-Object Name, Version, Repository
Install-Module -Name Pester -Scope CurrentUser -Force
```

- Publish your module to a repository (e.g., PSGallery or private feed):

```powershell
Publish-Module -Path .\MyTools -Repository PSGallery -NuGetApiKey '<API_KEY>'
```

### When to use modules

Use a module when:
- You have 2+ related functions used across multiple scripts or projects
- You want clear public vs private APIs and controlled exports
- You need versioning, dependency declaration, or distribution to others
- You want autoloading and discoverability via `Get-Command -Module`

Prefer a plain `.ps1` script when:
- It’s a single-purpose, one-off automation with no reuse
- The script will not be shared beyond a small context and contains only 1–2 helpers

Follow best practices:
- Export specific functions/cmdlets explicitly for published modules (not wildcards)
- Use module-scoped variables instead of polluting global scope
- Create focused, cohesive modules (not giant "kitchen sink" modules)

### Key Microsoft Docs

- About modules: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_modules?view=powershell-7.4
- About module manifests: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_module_manifests?view=powershell-7.4
- New-ModuleManifest: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/new-modulemanifest?view=powershell-7.4
- Import-Module: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/import-module?view=powershell-7.4
- About PSModulePath: https://learn.microsoft.com/powershell/module/microsoft.powershell.core/about/about_psmodulepath?view=powershell-7.4

## Testing

Recommendation: Create tests for all but single one-off automation scripts. Everything else should have testing included.

### Install and setup

- Use Pester v5+ for unit and integration tests.
- Install locally for the current user:

```powershell
Install-Module -Name Pester -Scope CurrentUser -Force
```

### Test layout

- Name test files with the `.Tests.ps1` suffix. Common patterns:
  - For modules: keep tests alongside the module or in a `Tests/` folder
  - For functions: one test file per public function improves focus

Example structure for a script module:

```
MyTools\
  MyTools.psd1
  MyTools.psm1
  Public\
    Get-Thing.ps1
  Private\
    Convert-Internal.ps1
  Tests\
    Get-Thing.Tests.ps1
    Module.Tests.ps1
```

### Writing tests (AAA pattern)

Use Describe/Context/It blocks and the Arrange-Act-Assert pattern with `Should` assertions.

```powershell
# Tests\Get-Thing.Tests.ps1
Describe 'Get-Thing' {
    Context 'when called with a valid name' {
        It 'returns a Thing object with the expected Name' {
            # Arrange
            $name = 'foo'

            # Act
            $result = Get-Thing -Name $name

            # Assert
            $result | Should -Not -BeNullOrEmpty
            $result.Name | Should -Be $name
        }
    }
}
```

### Testing modules and mocking

- Use `InModuleScope` to test internal behavior of a module while preserving scope.
- Use `Mock` to isolate dependencies and assert interactions.

```powershell
# Tests\Module.Tests.ps1
Import-Module (Resolve-Path './MyTools/MyTools.psd1') -Force

InModuleScope 'MyTools' {
    Describe 'New-Thing' {
        It 'calls Convert-Internal with correct parameters' {
            Mock -CommandName Convert-Internal -MockWith { return @{ Name = $args[0] } }

            $result = New-Thing -Name 'bar'

            Assert-MockCalled Convert-Internal -Times 1 -Exactly -ParameterFilter { $Name -eq 'bar' }
            $result.Name | Should -Be 'bar'
        }
    }
}
```

For file system operations, use the ephemeral `TestDrive:` path:

```powershell
It 'writes output file to TestDrive' {
    $out = Join-Path TestDrive: 'output.json'
    Save-Thing -Path $out -InputObject @{ Name = 'x' }
    (Test-Path $out) | Should -BeTrue
}
```

### Running tests

- Quick run in the current directory:

```powershell
Invoke-Pester -CI
```

- With configuration (results file, code coverage):

```powershell
$cfg = New-PesterConfiguration
$cfg.Run.Path = @('.')
$cfg.Run.PassThru = $true
$cfg.TestResult.Enabled = $true
$cfg.TestResult.OutputPath = 'TestResults.xml'
$cfg.TestResult.OutputFormat = 'NUnitXml'
$cfg.CodeCoverage.Enabled = $true
$cfg.CodeCoverage.Path = @('.\\MyTools\\Public', '.\\MyTools\\Private')

$results = Invoke-Pester -Configuration $cfg
if ($results.FailedCount -gt 0) { exit 1 }
```

## Full Example: End-to-End Cmdlet Pattern

```powershell
function New-Resource {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
    param(
        [Parameter(Mandatory = $true,
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter()]
        [ValidateSet('Development', 'Production')]
        [string]$Environment = 'Development'
    )
    
    begin {
        Write-Verbose "Starting resource creation process"
    }
    
    process {
        try {
            if ($PSCmdlet.ShouldProcess($Name, "Create new resource")) {
                # Resource creation logic here
                Write-Output ([PSCustomObject]@{
                    Name = $Name
                    Environment = $Environment
                    Created = Get-Date
                })
            }
        }
        catch {
            Write-Error "Failed to create resource: $_"
        }
    }
    
    end {
        Write-Verbose "Completed resource creation process"
    }
}
```
</parameter_design>
</powershell_guidelines>
