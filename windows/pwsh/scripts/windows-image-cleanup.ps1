if (-not (& "$PSScriptRoot\..\utils\require-admin.ps1")) { exit 1 }

Dism.exe /Online /Cleanup-Image /StartComponentCleanup
