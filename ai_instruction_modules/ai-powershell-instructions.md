---
description: PowerShell cmdlet development guidelines
scope: powershell-development
---
# PowerShell Guidelines

## Naming
- **Verb-Noun:** Approved verbs (`Get-Verb`), PascalCase
- **Params:** PascalCase, `[ValidateSet]`, `[ValidateNotNullOrEmpty]`
- **Full names in scripts:** `Get-ChildItem` not `gci`

## Parameters
- `[Parameter(Mandatory)]`, `[switch]` for flags
- `ValueFromPipeline` / `ValueFromPipelineByPropertyName`

## Output
- Return `PSCustomObject` via `Write-Output`
- **No `Write-Host`** for data
- Process streaming in `process` block

## Safety
- `[CmdletBinding(SupportsShouldProcess)]` for destructive ops
- `ErrorActionPreference = 'Stop'`, `try/catch`
- No `Read-Host` - use params

## Modules
```
MyTools/
├─ MyTools.psd1  (manifest)
├─ MyTools.psm1  (loader)
├─ Public/
└─ Private/
```

## Testing (Pester)
- `*.Tests.ps1`, AAA pattern, `Mock` dependencies
- `Invoke-Pester -CI`
