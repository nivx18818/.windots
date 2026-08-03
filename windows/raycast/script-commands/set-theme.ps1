# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Theme
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎨
# @raycast.argument1 { "type": "text", "placeholder": "Theme Name" }

# Documentation:
# @raycast.author nivx18818
# @raycast.authorURL https://raycast.com/nivx18818

param([string]$Theme)

$validThemes = @('catppuccin','monochrome')

if (-not ($validThemes -contains $Theme)) {
    throw "Invalid theme '$Theme'"
}

$envFile = "$PSScriptRoot\..\..\pwsh\env.ps1"
if (-not (Test-Path $envFile)) {
    throw "Required env file missing: $envFile"
}
. $envFile -Theme $Theme

komorebic stop --whkd
yasbc stop
yasbc start
komorebic start --whkd

oh-my-posh init pwsh --config "$Env:DOTFILES\oh-my-posh\$OmpTheme.omp.json" > $Env:DOTFILES\oh-my-posh\omp-init.ps1
