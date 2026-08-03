<#
.SYNOPSIS
    Flattens a nested Windhawk mod style JSON and copies it to the clipboard.

.PARAMETER Theme
    The theme folder to process. Defaults to $Theme from your profile.

.PARAMETER Mod
    Optional filename (without extension) to process a single file.
    When omitted, all *.json files in the theme folder are processed
    and each is copied to the clipboard in turn.

.EXAMPLE
    ConvertTo-WindhawkSettings

.EXAMPLE
    ConvertTo-WindhawkSettings catppuccin

.EXAMPLE
    ConvertTo-WindhawkSettings catppuccin -Mod taskbar
#>

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string] $Theme = $Theme,

    [Parameter(Position = 1)]
    [string] $Mod
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not $Theme) {
    Write-Error 'No theme specified and $Theme is not set in your profile.'
    exit 1
}

if (-not $Env:DOTFILES) {
    Write-Error '$Env:DOTFILES is not set.'
    exit 1
}

$sourceDir = Join-Path $Env:DOTFILES "windhawk\$Theme"

if (-not (Test-Path $sourceDir)) {
    Write-Error "Theme folder not found: $sourceDir"
    exit 1
}

$filter = if ($Mod) { "windows-11-$Mod-styler.json" } else { '*.json' }
$files  = Get-ChildItem -Path $sourceDir -Filter $filter -File

if (-not $files) {
    Write-Warning "No JSON files found in $sourceDir$(if ($Mod) { " matching '$Mod.json'" })"
    exit 0
}

function Flatten-ModStyles {
    param([System.Collections.Hashtable] $nested)

    $flat = [ordered]@{}

    if ($nested.ContainsKey('styleConstants') -and $nested['styleConstants']) {
        $i = 0
        foreach ($entry in $nested['styleConstants']) {
            $flat["styleConstants[$i]"] = $entry
            $i++
        }
    }

    if ($nested.ContainsKey('controlStyles') -and $nested['controlStyles']) {
        $i = 0
        foreach ($target in $nested['controlStyles'].Keys) {
            $flat["controlStyles[$i].target"] = $target
            $j = 0
            foreach ($style in $nested['controlStyles'][$target]) {
                $flat["controlStyles[$i].styles[$j]"] = $style
                $j++
            }
            $i++
        }
    }

    if ($nested.ContainsKey('resourceVariables') -and $nested['resourceVariables']) {
        $i = 0
        foreach ($key in $nested['resourceVariables'].Keys) {
            $flat["resourceVariables[$i].variableKey"] = $key
            $flat["resourceVariables[$i].value"]       = $nested['resourceVariables'][$key]
            $i++
        }
    }

    return $flat
}

foreach ($file in $files) {
    $nested = Get-Content $file.FullName -Raw -Encoding UTF8 | ConvertFrom-Json -AsHashtable
    $json   = Flatten-ModStyles $nested | ConvertTo-Json -Compress -Depth 5

    $json | Set-Clipboard
    Write-Host "Copied: $($file.Name)" -ForegroundColor Green
}
