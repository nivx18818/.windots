$dotEnvFile = Join-Path $PSScriptRoot ".env"

if (Test-Path $dotEnvFile) {
    Get-Content $dotEnvFile | ForEach-Object {
        $line = $_.Trim()

        # skip empty/comment
        if ($line -match '^\s*$') { return }
        if ($line -match '^\s*#') { return }

        $name, $value = $line -split '=', 2

        $name = $name.Trim()
        $value = $value.Trim()

        # remove surrounding quotes
        if (
            ($value.StartsWith('"') -and $value.EndsWith('"')) -or
            ($value.StartsWith("'") -and $value.EndsWith("'"))
        ) {
            $value = $value.Substring(1, $value.Length - 2)
        }

        [Environment]::SetEnvironmentVariable(
            $name,
            $value,
            'Process'
        )
    }
}

$envFile = Join-Path $PSScriptRoot "env.ps1"
if (Test-Path $envFile) {
    . $envFile
} else {
    Write-Warning "Env file not found: $envFile"
}

# Lazy-load Terminal-Icons
function global:Get-ChildItem {
    Remove-Item Function:\Get-ChildItem -ErrorAction SilentlyContinue

    if (-not (Get-Module Terminal-Icons)) {
        Import-Module Terminal-Icons
    }

    Microsoft.PowerShell.Management\Get-ChildItem @args
}

. $Env:DOTFILES\oh-my-posh\omp-init.ps1

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -Colors @{ InlinePrediction = $InlinePrediction }

# Keybindings
if ($Env:TERM_PROGRAM -ne "vscode") {
    Set-PSReadLineKeyHandler -Key "Ctrl+b" -Function BackwardWord
    Set-PSReadLineKeyHandler -Key "Ctrl+w" -Function ForwardWord
    Set-PSReadLineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
}

# Wrapper around Windows sudo that properly elevates PowerShell cmdlets, aliases,
# scriptblocks, and previous commands while passing native executables directly.
function Invoke-Sudo {
    begin {
        function convertToBase64EncodedString([string]$cmdLine) {
            [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($cmdLine))
        }
    }
    end {
        switch ($args[0]) {
            $null {
                sudo.exe pwsh -nol
                break
            }
            '!!' {
                $encoded = convertToBase64EncodedString "$(Get-History -c 1)"
                sudo.exe pwsh -e $encoded
                break
            }
            { $_ -is [scriptblock] } {
                $encoded = convertToBase64EncodedString $_
                sudo.exe pwsh -e $encoded
                break
            }
            { Get-Command $_ -Type Application -ErrorAction Ignore } {
                # Pass as-is for native command
                sudo.exe $args
                break
            }
            { Get-Command $_ -Type Cmdlet, ExternalScript, Alias -ErrorAction Ignore } {
                $encoded = convertToBase64EncodedString "$args"
                sudo.exe pwsh -e $encoded
                break
            }
            default {
                Write-Host "Cannot find '$_'" -ForegroundColor Red
            }
        }
    }
}
Set-Alias sudo Invoke-Sudo

$ProfileScriptSources = @(
    'omp-init'
)

function Run-ProfileScript {
    param(
        [Parameter(Position=0, Mandatory)] [string]$Script,
        [Parameter(ValueFromRemainingArguments=$true)] [object[]]$ScriptArgs
    )

    $scriptsDir = Join-Path $PSScriptRoot 'scripts'
    $scriptPath = $Script
    $scriptName

    if (-not [System.IO.Path]::IsPathRooted($Script) -and $Script -notmatch '[\\/]') {
        $scriptFile = if ($Script.EndsWith('.ps1')) { $Script } else { "$Script.ps1" }
        $scriptPath = Join-Path $scriptsDir $scriptFile
        $scriptName = [System.IO.Path]::GetFileNameWithoutExtension($scriptFile)
    }

    if (-not (Test-Path $scriptPath)) {
        Write-Error "Script not found: $scriptPath"
        return
    }

    if ($scriptName -in $ProfileScriptSources) {
        . $scriptPath @ScriptArgs
    } else {
        & $scriptPath @ScriptArgs
    }
}
Set-Alias run Run-ProfileScript

# Register tab-completion for script names (completes base filename without extension)
$profileScriptsDir = Join-Path $PSScriptRoot 'scripts'
if (Test-Path $profileScriptsDir) {
    try {
        Register-ArgumentCompleter -CommandName Run-ProfileScript, run -ParameterName Script -ScriptBlock {
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

            $wc = if ($wordToComplete) { "$wordToComplete*" } else { '*' }
            Get-ChildItem -Path $profileScriptsDir -File -ErrorAction SilentlyContinue |
                Where-Object { $_.BaseName -like $wc } |
                ForEach-Object {
                    [System.Management.Automation.CompletionResult]::new($_.BaseName, $_.BaseName, 'ParameterValue', $_.FullName)
                }
        }
    } catch {
        # Ignore completion registration errors (older PS versions)
    }
}

# Better git clone
function Clone-Repository {
    param(
        [Parameter(Mandatory)]
        [string]$url,

        [string]$dir
    )

    # Add .git suffix if it's missing
    if (-not $url.EndsWith('.git')) {
        $url = "$url.git"
    }

    # If no custom directory is provided, extract repo name from URL
    if (-not $dir) {
        # Take the last segment of the URL and strip the .git extension
        $repoName = ($url.Split('/')[-1] -replace '\.git$', '')
        $dir = $repoName
    }

    # Clone the repository into the target directory
    git clone $url $dir | Out-Null

    # After a successful clone, move into the new directory
    if (Test-Path $dir) {
        Set-Location $dir
    }
}
Set-Alias gclone Clone-Repository

# Unix-like remove command with -r and -f flags
function Remove-Path {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    $recursive = $false
    $force = $false
    $paths = @()

    foreach ($a in $Args) {
        if ($a -match '^-[rf]+$') {
            # Parse each character
            foreach ($ch in ($a.Substring(1).ToCharArray())) {
                switch ($ch) {
                    'r' { $recursive = $true }
                    'f' { $force = $true }
                }
            }
        } else {
            # Anything not a flag is a path
            $paths += $a
        }
    }

    foreach ($p in $paths) {
        Remove-Item -Path $p -Recurse:$recursive -Force:$force -ErrorAction SilentlyContinue
    }
}
Remove-Item Alias:rm -ErrorAction SilentlyContinue
Set-Alias rm Remove-Path

# Unix-like copy command with optional -r
function Copy-Path {
    param(
        [Parameter(Mandatory)] [string]$src,
        [Parameter(Mandatory)] [string]$dst,
        [Alias('r')] [switch]$Recursive
    )

    Copy-Item -Path $src -Destination $dst -Recurse:$Recursive
}
Remove-Item Alias:cp -ErrorAction SilentlyContinue
Set-Alias cp Copy-Path

# Unix-like move command
function Move-Path {
    param(
        [Parameter(Mandatory)] [string]$src,
        [Parameter(Mandatory)] [string]$dst
    )

    Move-Item -Path $src -Destination $dst
}
Set-Alias mv Move-Path

# mkdir & cd
function New-Directory {
    param([Parameter(Mandatory)] [string]$name)
    New-Item -ItemType Directory -Path $name | Out-Null
    Set-Location $name
}
Set-Alias mkcd New-Directory

# Show the command's path (Unix-like)
function Get-CommandSource {
    param([Parameter(Mandatory)] [string]$name)
    (Get-Command $name).Source
}
Set-Alias which Get-CommandSource

# Symbolic link command
function New-SymbolicLink {
    param(
        [Parameter(Mandatory)] [string]$link,
        [Parameter(Mandatory)] [string]$target
    )

    if (Test-Path $link) {
        Remove-Item $link
    }

    New-Item -ItemType SymbolicLink -Path $link -Target $target
}
Set-Alias symlink New-SymbolicLink

# WSL Distros
function Enter-WslDistro {
    param([Parameter(Position=0, Mandatory)][string]$Name)
    wsl -d $Name --cd ~
}

function Enter-WslArch {
    Enter-WslDistro -Name 'Arch'
}
Set-Alias arch Enter-WslArch

function Enter-WslUbuntu22 {
    Enter-WslDistro -Name 'Ubuntu-22.04'
}
Set-Alias u22 Enter-WslUbuntu22
