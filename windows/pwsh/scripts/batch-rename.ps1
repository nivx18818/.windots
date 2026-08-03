param(
    [Alias('h', '?')]
    [switch]$Help,

    [Alias('p')]
    [string]$Prefix,
    [Alias('s')]
    [string]$Suffix,

    [Alias('i')]
    [switch]$Index,          # enable indexing
    [Alias('k')]
    [switch]$KeepName,       # keep original filename when indexing

    [Alias('si')]
    [int]$StartIndex = 1,    # starting number
    [int]$Pad = 0,           # zero padding (e.g. 3 -> 001)

    [Alias('pat')]
    [string]$Pattern,        # regex pattern
    [Alias('r')]
    [string]$Replace,        # regex replacement

    [switch]$Dry,            # dry-run
    [switch]$Verbose   # print rename log
)

# Show usage and exit early before touching files.
if ($Help) {
@"
Usage:
    ./batch-rename.ps1 [options]

Modes:
    Standard mode: combine -Prefix/-Suffix and optional -Index
    Regex mode: use -Pattern and -Replace (cannot combine with standard mode)

Options:
    -Help, -h, -?             Show this help message
    -Prefix <string>          Add text before the base name
    -Suffix <string>          Add text after the base name
    -Index                    Enable numeric indexing
    -KeepName                 Keep original filename when indexing
    -StartIndex <int>         Starting index (default: 1)
    -Pad <int>                Zero-pad width (default: 0)
    -Pattern <string>         Regex pattern
    -Replace <string>         Regex replacement (required with -Pattern)
    -Dry                      Preview changes without renaming
    -VerboseOutput            Print rename log during execution

Examples:
    ./batch-rename.ps1 -Prefix "img_" -Index -Pad 3 -Dry
    ./batch-rename.ps1 -Index -KeepName -StartIndex 10
    ./batch-rename.ps1 -Pattern "\\s+" -Replace "_" -Dry
"@ | Write-Host
    return
}

$files = Get-ChildItem -File

# Validate regex mode (must be standalone)
if ($Pattern -and -not $Replace) {
    Write-Error "Pattern requires -Replace"
    exit
}

if ($Pattern -and ($Prefix -or $Suffix -or $Index)) {
    Write-Error "Regex mode cannot be combined with other modes"
    exit
}

$i = $StartIndex

foreach ($f in $files) {
    $name = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
    $ext  = $f.Extension

    $newName = $null

    if ($Pattern) {
        # Regex mode (full control)
        $newName = $f.Name -replace $Pattern, $Replace
    }
    else {
        # Build index string if enabled
        $indexStr = ""
        if ($Index) {
            if ($Pad -gt 0) {
                $indexStr = $i.ToString("D$Pad")
            } else {
                $indexStr = "$i"
            }
        }

        # Construct base name
        if ($Index -and -not $KeepName) {
            # Only index (ignore original name)
            $base = $indexStr
        }
        elseif ($Index -and $KeepName) {
            # Index + original name
            $base = "$indexStr`_$name"
        }
        else {
            # No index, just original name
            $base = $name
        }

        # Apply prefix and suffix
        $newName = "$Prefix$base$Suffix$ext"

        if ($Index) { $i++ }
    }

    if ($newName -eq $f.Name) { continue }

    if ($Dry) {
        Write-Host "[DRY] $($f.Name) -> $newName"
    } else {
        Rename-Item $f -NewName $newName
        if ($Verbose) {
            Write-Host "$($f.Name) -> $newName"
        }
    }
}
