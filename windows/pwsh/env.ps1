param(
    [string]$Theme = "monochrome"
)

$Env:DOTFILES="D:\code\dotfiles"
$Env:XDG_CONFIG_HOME="$HOME\.config"

$Env:KOMOREBI_CONFIG_HOME="$Env:DOTFILES\komorebi\$Theme"
$Env:WHKD_CONFIG_HOME="$Env:DOTFILES\komorebi\whkd"
$Env:YASB_CONFIG_HOME="$Env:DOTFILES\yasb\$Theme"

$Env:NEOVIDE_CONFIG="$Env:DOTFILES\neovide\config.toml"

$Env:OPENCODE_CONFIG="$Env:DOTFILES\opencode\config.json"
$Env:OPENCODE_TUI_CONFIG="$Env:DOTFILES\opencode\tui.json"
$Env:EDITOR="neovide"

$Env:PIPX_HOME="D:\apps\pipx\share\pipx"
$Env:PIPX_BIN_DIR="D:\apps\pipx\bin"
$Env:PIPX_MAN_DIR="D:\apps\pipx\share\man"
$Env:PIPX_GLOBAL_HOME=$Env:PIPX_HOME
$Env:PIPX_GLOBAL_BIN_DIR=$Env:PIPX_BIN_DIR
$Env:PIPX_GLOBAL_MAN_DIR=$Env:PIPX_MAN_DIR

if ($Theme -eq "catppuccin") {
    $OmpTheme = "poimandres"
    $InlinePrediction = "#767c9d"
} elseif ($Theme -eq "monochrome") {
    $OmpTheme = "vesper"
    $InlinePrediction = "#a0a0a0"
}
