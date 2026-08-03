# Neovim — Configuration and Setup

This folder contains my personal Neovim configuration written in Lua.

## Prerequisites

- Latest version of [Neovim](https://github.com/neovim/neovim).
- Basic utils: `git`, `curl`, `unzip`, `make`, C compiler (`gcc`).
- Others: [ripgrep](https://github.com/BurntSushi/ripgrep#installation),
  [fd-find](https://github.com/sharkdp/fd#installation),
  [lazygit](https://github.com/jesseduffield/lazygit#installation)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it, set `vim.g.have_nerd_font` to true
- Language Formatter Setup:
  - For Rust-based tools (like `stylua`, `taplo`, etc.): install `rust`.
  - For Node.js-based tools (like `prettier`, `eslint_d`, etc.): install `nodejs` and `npm` or `yarn`.
  - For Python-based tools (like `black`, `flake8`, etc.): install `python3` and `pip`.

## File structure

- `init.lua` — main entry point
- `lua/core/` — editor options, keymaps, autocommands
- `lua/plugins/` — individual plugin configuration files
- `lazy-lock.json` — plugin lockfile

## Configuration

### `XDG_CONFIG_HOME`

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

- Create a symbolic link from this repository's `nvim` folder to your Neovim configuration directory:

  ```powershell
  $Env:DOTFILES = "path\to\this\repo"
  ```

  ```powershell
  # Remove the existing Neovim configuration directory if it exists
  Remove-Item "$Env:XDG_CONFIG_HOME\nvim" -Recurse -Force -ErrorAction Ignore
  # Create a symbolic link to the nvim configuration in this repository
  New-Item -ItemType SymbolicLink -Path "$Env:XDG_CONFIG_HOME\nvim" -Target "$Env:DOTFILES\nvim"
  ```

## Specific plugins

### cord.nvim

See the official docs for full details and options: [vyfor/cord.nvim](https://github.com/vyfor/cord.nvim)

Below are my personal notes for the way I configured `cord.nvim` on Arch Linux running inside WSL2. This is not a substitute for the upstream docs — it's purely my experience and small tips that helped me get it working.

- Follow this guide to set up Discord Rich Presence on WSL2: [Using Discord Rich Presence with WSL2](https://github.com/vyfor/cord.nvim/wiki/Special-Environments)

- After installing `socat`, download `npiperelay.exe` from `npiperelay` releases. Note that:

  - `386`: for 32-bit CPUs (very old, almost no longer used).
  - `amd64`: for x86_64 CPUs (Intel or AMD 64-bit — most modern PCs).

- Extract and place `npiperelay.exe` somewhere accessible, e.g. `D:\npiperelay\npiperelay.exe`.

- Create `.bashrc` in your home directory (e.g. `~/.bashrc`) and add the following lines, adjusting the path to `npiperelay.exe` as needed:

  ```bash
  nvim() {
      if ! pidof socat > /dev/null 2>&1; then
          [ -e /tmp/discord-ipc-0 ] && rm -f /tmp/discord-ipc-0
          socat UNIX-LISTEN:/tmp/discord-ipc-0,fork \
              EXEC:"mnt/d/npiperelay/npiperelay.exe //./pipe/discord-ipc-0" 2>/dev/null &
      fi

      command nvim "$@"
  }
  ```

  > Replace `mnt/d/npiperelay/npiperelay.exe` with the actual path to your `npiperelay.exe` file.
  >
  > `mnt/d/` corresponds to `D:\` in Windows.

- Restart your WSL2 terminal or source the `.bashrc` file:

  ```bash
  source ~/.bashrc
  ```

- Now, when you launch Neovim using the `nvim` command in WSL2, `cord.nvim` should be able to connect to Discord and display your Rich Presence status.

### vim-wakatime

You can find the official documentation for `vim-wakatime` here: [wakatime/vim-wakatime](https://github.com/wakatime/vim-wakatime)

After following the installation instructions, if `wakatime-cli` is not automatically installed, you can manually install it by following these steps:

- Download the latest release of `wakatime-cli` from the [WakaTime CLI releases page](https://github.com/wakatime/wakatime-cli/releases). Note that:

  - `386`: for 32-bit CPUs (very old, almost no longer used).
  - `amd64`: for x86_64 CPUs (Intel or AMD 64-bit — most modern PCs).
  - `arm` and `arm64`: for ARM CPUs (like Raspberry Pi, or Apple M1/M2 if running the ARM version).
  - `riscv64`: for machines using the RISC-V architecture (very rare, mostly for research).

- Extract the downloaded archive, rename the binary to `wakatime-cli`, and place it in `~/.wakatime`.

- After installation, verify `wakatime-cli` is working from inside Neovim by running the command `:WakaTimeToday` (this should show today's coding activity if the CLI and plugin are configured correctly).
