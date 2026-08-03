# Windhawk

## Installation

Install Windhawk from [windhawk.net](https://windhawk.net/downloads/).

Install the following mods from the Windhawk:

- Middle click to close on the taskbar (`taskbar-button-click`).
- Taskbar Scroll Actions (`taskbar-scroll-actions`).
- Taskbar tray system icon tweaks (`taskbar-tray-system-icon-tweaks`).
- Taskbar Volume Control (`taskbar-volume-control`).
- Windows 11 Notification Center Styler (`windows-11-notification-center-styler`).
- Windows 11 Start Menu Styler (`windows-11-start-menu-styler`).
- Windows 11 Taskbar Styler (`windows-11-taskbar-styler`).

## Configuration

For UI-related mods such as:

- Windows 11 Notification Center Styler
- Windows 11 Start Menu Styler
- Windows 11 Taskbar Styler

Open the **Advanced** tab of each mod, then go to the **Mod settings** section and paste the corresponding JSON file from this folder.

## Custom JSON schema

This folder uses a custom JSON schema; it is not the standard schema used by Windhawk mods.

Run the [windhawk-flatten](../pwsh/scripts/winhawk-flatten.ps1) PowerShell script to convert the JSON files in this folder into a file suitable for pasting into a mod's Advanced → Mod settings.

Example usage:

```powershell
run windhawk-flatten monochrome taskbar
```

Use tools such as [watchexec](https://github.com/watchexec/watchexec) to automatically run the script when a JSON file is changed.

```powershell
watchexec -w "./windhawk/monochrome" -d 300 pwsh ./pwsh/scripts/windhawk-flatten.ps1 monochrome taskbar
```
