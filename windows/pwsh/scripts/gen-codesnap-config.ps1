<#
.SYNOPSIS
    Generates CodeSnap config.json from snapshot.json.

.EXAMPLE
    gen-codesnap-config
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = if ($Env:DOTFILES) {
    $Env:DOTFILES
} else {
    Resolve-Path (Join-Path $PSScriptRoot '..\..')
}

$codesnapDir  = Join-Path $repoRoot 'codesnap'
$snapshotPath = Join-Path $codesnapDir 'snapshot.json'
$configPath   = Join-Path $codesnapDir 'config.json'

if (-not (Test-Path $codesnapDir -PathType Container)) {
    Write-Error "CodeSnap folder not found: $codesnapDir"
    exit 1
}

if (-not (Test-Path $snapshotPath -PathType Leaf)) {
    Write-Error "Snapshot file not found: $snapshotPath"
    exit 1
}

if (-not (Test-Path $configPath -PathType Leaf)) {
    Write-Error "Config file not found: $configPath"
    exit 1
}

function Read-JsonFile {
    param(
        [Parameter(Mandatory)]
        [string] $Path
    )

    $attempts = 5

    for ($i = 1; $i -le $attempts; $i++) {
        try {
            $json = Get-Content $Path -Raw -Encoding UTF8

            if ([string]::IsNullOrWhiteSpace($json)) {
                throw "JSON file is empty: $Path"
            }

            return $json | ConvertFrom-Json -AsHashtable
        } catch {
            if ($i -eq $attempts) {
                throw
            }

            Start-Sleep -Milliseconds 100
        }
    }
}

function Update-CodeSnapConfig {
    $snapshot = Read-JsonFile $snapshotPath
    $config   = Read-JsonFile $configPath

    $snapshot.Remove('$schema')
    $config['snapshot_config'] = $snapshot

    $json = $config | ConvertTo-Json -Depth 100
    Set-Content -Path $configPath -Value $json -Encoding UTF8

    Write-Host "Updated: $configPath" -ForegroundColor Green
}

Update-CodeSnapConfig
