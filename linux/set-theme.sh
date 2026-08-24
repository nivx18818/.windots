#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <theme_name>"
    echo "Available themes:"
    ls -1 _themes/
    exit 1
fi

THEME=$1
THEME_DIR="_themes/$THEME"
BASE_DIR="$(pwd)"

if [ ! -d "$THEME_DIR" ]; then
    echo "Error: Theme '$THEME' does not exist in _themes/"
    exit 1
fi

echo "Applying theme: $THEME"

# niri
if [ -f "$THEME_DIR/niri.kdl" ]; then
    echo "-> Updating niri theme..."
    ln -sf "$BASE_DIR/$THEME_DIR/niri.kdl" "$BASE_DIR/niri/cfg/theme.kdl"
fi

# noctalia
if [ -f "$THEME_DIR/noctalia/config.toml" ]; then
    // Remove Noctalia config state file to avoid config overriding
    // This file is safe to remove
    rm -f $XDG_STATE_HOME/settings.toml
    echo "-> Updating noctalia config..."
    ln -sf "$BASE_DIR/$THEME_DIR/noctalia/config.toml" "$BASE_DIR/noctalia/config.toml"
fi

# noctalia custom palette
if [ -f "$THEME_DIR/noctalia/palette.json" ]; then
    echo "-> Updating noctalia custom palette..."
    mkdir -p "$BASE_DIR/noctalia/palettes"
    ln -sf "$BASE_DIR/$THEME_DIR/noctalia/palette.json" "$BASE_DIR/noctalia/palettes/custom.json"
fi

# kitty
if [ -f "$THEME_DIR/kitty.conf" ]; then
    echo "-> Updating kitty theme..."
    ln -sf "$BASE_DIR/$THEME_DIR/kitty.conf" "$BASE_DIR/kitty/current-theme.conf"
    # Note: Kitty allows reloading config with `kill -SIGUSR1 $(pidof kitty)`
    # pkill -USR1 kitty
fi

# btop
if [ -f "$THEME_DIR/btop.theme" ]; then
    echo "-> Updating btop theme..."
    mkdir -p "$BASE_DIR/btop/themes"
    ln -sf "$BASE_DIR/$THEME_DIR/btop.theme" "$BASE_DIR/btop/themes/current.theme"
fi


echo "Theme '$THEME' applied successfully!"
