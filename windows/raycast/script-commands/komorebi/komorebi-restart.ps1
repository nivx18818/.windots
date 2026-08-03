# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Komorebi Restart
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🍉

# Documentation:
# @raycast.author nivx18818
# @raycast.authorURL https://raycast.com/nivx18818

$envFile = "$PSScriptRoot\..\..\..\pwsh\env.ps1"
if (-not (Test-Path $envFile)) {
    throw "Required env file missing: $envFile"
}
. $envFile

komorebic stop --whkd
komorebic start --whkd
