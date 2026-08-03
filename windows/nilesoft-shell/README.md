# Nilesoft Shell

Powerful manager for Windows File Explorer context menu.

## Installation

> [!NOTE]
>
> Administrative permissions are required for installation.

### WinGet

**Install:**

```powershell
winget install Nilesoft.Shell
```

**Uninstall:**

```powershell
winget uninstall Nilesoft.Shell
```

### Scoop

**Install:**

```powershell
scoop bucket add extras
scoop install extras/nilesoft-shell
```

```powershell
$Env:DOTFILES = "path\to\this\repo"
```

```powershell
# Allow the shell loads the configuration file from a custom path.
# If it does not find the configuration file,
# it looks for the default configuration file `shell.nss` in the program folder.
New-Item -Path "HKCU:\Software\Nilesoft\Shell" -Force | Out-Null
New-ItemProperty `
  -Path "HKCU:\Software\Nilesoft\Shell" `
  -Name "config" `
  -PropertyType String `
  -Value "$Env:DOTFILES\nilesoft-shell\shell.nss" `
  -Force
```

```powershell
# Run in an elevated PowerShell session
# or use gsudo: https://github.com/gerardog/gsudo
shell -register -restart
```

**Uninstall:**

```powershell
Remove-Item "HKCU:\Software\Nilesoft" -Recurse -Force
```

```powershell
# Run in an elevated PowerShell session
# or use gsudo: https://github.com/gerardog/gsudo
shell -unregister -restart
scoop uninstall nilesoft-shell
```

## Documentation

See the full [documentation](https://nilesoft.org/docs).
