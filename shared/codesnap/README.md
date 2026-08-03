# CodeSnap

## Installation

- Scoop:

```powershell
scoop bucket add extras
scoop install extras/codesnap
```

- Read more at [CodeSnap's docs](https://github.com/codesnap-rs/codesnap#-getting-started).

## Configuration

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
  $Env:XDG_CONFIG_HOME="$HOME\.config"
  ```

- Create a symbolic link from this repository's `codesnap` folder to your Neovim configuration directory:

  ```powershell
  $Env:DOTFILES = "path\to\this\repo"
  ```

  ```powershell
  # Remove the existing Neovim configuration directory if it exists
  Remove-Item "$Env:XDG_CONFIG_HOME\codesnap" -Recurse -Force -ErrorAction Ignore
  # Create a symbolic link to the nvim configuration in this repository
  New-Item -ItemType SymbolicLink -Path "$Env:XDG_CONFIG_HOME\codesnap" -Target "$Env:DOTFILES\codesnap"
  ```

## Development

Edit `snapshot.json` when changing the CodeSnap snapshot configuration. Run the [gen-codesnap-config](./gen-codesnap-config.ps1) PowerShell script to place that JSON under the `snapshot_config` field in `config.json`.

The script also strips the top-level `$schema` key from `snapshot.json` before writing `config.json`.

Example usage:

```powershell
run gen-codesnap-config
```

Use tools such as [watchexec](https://github.com/watchexec/watchexec) to automatically run the script when `snapshot.json` is changed.

```powershell
watchexec -w "./codesnap/snapshot.json" -d 300 pwsh ./pwsh/scripts/gen-codesnap-config.ps1
```
