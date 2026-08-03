# VSCode Neovim Integration

This setup allows you to use Neovim as the backend for VSCode's editing capabilities.

## Prerequisites

- Install [Neovim](https://neovim.io/).
  - Winget

    ```powershell
    winget install Neovim.Neovim
    ```

  - Scoop

    ```powershell
    scoop bucket add main
    scoop install main/neovim
    ```

- Install [`tree-sitter-cli`](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) (installed via your package manager, not npm).
  - Winget

    ```powershell
    winget install tree-sitter.tree-sitter-cli
    ```

  - Scoop

    ```powershell
    scoop bucket add main
    scoop install main/tree-sitter
    ```

- Install `gcc` (a C compiler is required to build the Neovim Tree-sitter parsers).
  - Winget

    ```powershell
    winget install MSYS2.MSYS2
    ```

  - Scoop

    ```powershell
    scoop bucket add main
    scoop install main/mingw
    ```

- Install [VSCode](https://code.visualstudio.com/).

- Install the [VSCode Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim) and [Which Key](https://marketplace.visualstudio.com/items?itemName=VSpaceCode.whichkey) extensions for VSCode.

## Configuration

### Neovim

Refer to the [Neovim configuration](../nvim/README.md) for setting up Neovim itself.

### VSCode

#### Neovim Path

- Configure the **VSCode Neovim** extension to point to your Neovim installation by setting the `neovim.neovimExecutablePaths.windows` option.
  - Open VSCode settings (`Ctrl+,`), search for `neovim executable`, and set the path to your Neovim installation, typically:

    ```powershell
    C:\Program Files\Neovim\bin\nvim.exe
    ```

  > [!NOTE]
  >
  > You can leave it blank if Neovim is already in your system's `PATH`.

#### `settings.json` & `keybindings.json`

- Add this folder's `settings.json` and `keybindings.json` files to your VSCode configuration.
  - Open the Command Palette (`Ctrl+Shift+P`), type `Preferences: Open Settings (JSON)`, and press `Enter`.
  - Copy the contents of `vscode/settings.json` into your VSCode `settings.json`.
  - Similarly, open the Command Palette, type `Preferences: Open Keyboard Shortcuts (JSON)`, and press `Enter`.
  - Copy the contents of `vscode/keybindings.json` into your VSCode `keybindings.json`.

#### Styles

The styles are inspired by:

- [evondev's vscode-custom](https://github.com/evondev/vscode-custom),
- [Aikoyori's ProgrammingVTuberLogos](https://github.com/Aikoyori/ProgrammingVTuberLogos).
- [SAWARATSUKI's KawaiiLogos](https://github.com/SAWARATSUKI/KawaiiLogos).
