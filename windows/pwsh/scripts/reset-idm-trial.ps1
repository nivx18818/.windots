# NOTE: There can be multiple *_Classes keys when multiple user profiles are loaded.
# This script targets only SID-based keys like S-1-5-21-..._Classes.

if (-not (& "$PSScriptRoot\..\utils\require-admin.ps1")) { exit 1 }

$clsid = "{07999AC3-058B-40BF-984F-69EB1E554CA7}"
$relativePath = "WOW6432Node\CLSID\$clsid"

$classesKeys = Get-ChildItem -Path Registry::HKEY_USERS |
    Where-Object { $_.PSChildName -match '^S-1-5-21-(\d+-){3}\d+_Classes$' }

if (-not $classesKeys) {
    Write-Error "No SID-based HKEY_USERS keys ending with _Classes were found."
    exit 1
}

foreach ($key in $classesKeys) {
    $targetPath = Join-Path -Path $key.PSPath -ChildPath $relativePath
    if (-not (Test-Path -Path $targetPath)) {
        Write-Error "Missing CLSID path at $targetPath"
        continue
    }

    Set-ItemProperty -Path $targetPath -Name "Therad" -Value 1
    Write-Host "IDM trial has been reset"
}
