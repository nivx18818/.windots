if (-not (& "$PSScriptRoot\..\utils\require-admin.ps1")) { exit 1 }

$devices = Get-PnpDevice | Where-Object {
    $_.FriendlyName -like "*touch screen*" -and $_.Status -ne "Unknown"
}

if (-not $devices) {
    Write-Host "No touchscreen device found."
    exit
}

foreach ($device in $devices) {
    if ($device.Status -eq "OK") {
        Write-Host "Disabling: $($device.FriendlyName)"
        Disable-PnpDevice -InstanceId $device.InstanceId -Confirm:$false
    }
    else {
        Write-Host "Enabling: $($device.FriendlyName)"
        Enable-PnpDevice -InstanceId $device.InstanceId -Confirm:$false
    }
}
