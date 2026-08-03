<h1 align="center">komorebi</h1>

<p align="center">Tiling Window Management for Windows.</p>

---

## Installation

### Long path support (recommended)

```powershell
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1
```

### Disabling unnecessary system animations (recommended)

Enable the _Turn off all unnecessary animations (when possible)_ option in _Control Panel > Ease of Access > Ease of Access Centre / Make the computer easier to see_ for the best performance with `komorebi`.

### WinGet

```powershell
winget install LGUG2Z.komorebi
winget install LGUG2Z.whkd
```

### Scoop

```powershell
scoop bucket add extras
scoop install komorebi whkd
```

### Upgrades

```powershell
# for winget
winget upgrade LGUG2Z.komorebi
```

```powershell
# for scoop
scoop update komorebi whkd
```

## `KOMOREBI_CONFIG_HOME` & `WHKD_CONFIG_HOME`

- Open PowerShell and run the following command to check whether you already have a profile file:

  ```powershell
  Test-Path $PROFILE
  ```

  If the command returns `False`, create the profile file by running:

  ```powershell
  New-Item -Path $PROFILE -ItemType File -Force
  ```

- Open the profile file with your favorite text editor and add the following lines at the end of the file:

  ```powershell
  $Env:DOTFILES = "path\to\this\repo"
  $Env:KOMOREBI_CONFIG_HOME="$Env:DOTFILES\komorebi"
  $Env:WHKD_CONFIG_HOME="$Env:DOTFILES\komorebi\whkd"
  ```

## Documentation

See the full [documentation](https://lgug2z.github.io/komorebi).
