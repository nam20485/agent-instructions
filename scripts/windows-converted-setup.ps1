#!/usr/bin/env pwsh
<#!
DEPRECATED: Use scripts/setup-environment.ps1

This file is retained temporarily for backward compatibility with older references.
It now delegates to the canonical script and exits. Please update any tooling to
invoke scripts/setup-environment.ps1 directly.
!#>

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$canonical = Join-Path $here 'setup-environment.ps1'

if (-not (Test-Path $canonical)) {
  Write-Error "Canonical setup script not found at: $canonical"
  exit 1
}

Write-Warning 'DEPRECATED: scripts/windows-converted-setup.ps1 -> use scripts/setup-environment.ps1'
& pwsh -NoProfile -ExecutionPolicy Bypass -File $canonical @args
exit $LASTEXITCODE
