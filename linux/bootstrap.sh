#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(realpath "$SCRIPT_DIR/..")"

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Other package managers
sudo pacman -Sy --needed paru flatpak

sudo pacman -S --needed $(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/_packages/pacman.txt")
paru -S --needed $(grep -vE '^\s*(#|$)' "$SCRIPT_DIR/_packages/aur.txt")

# while read -r cmd; do
#     [[ -z "$cmd" || "$cmd" =~ ^# ]] && continue
#     eval "$cmd"
# done < "$SCRIPT_DIR/_packages/external.txt"

echo
echo "The following apps cannot be installed automatically:"
echo "==========================="

while IFS='|' read -r name type url; do
    [[ -z "$name" || "$name" =~ ^# ]] && continue

    echo
    echo "$name ($type)"
    echo "  Visit: $url"
done < "$SCRIPT_DIR/_packages/manual.txt"

expand_path() {
    local path="$1"
    printf '%s\n' "${path/#\~/$HOME}"
}

run() {
    if [[ "$dst" == /etc/* || "$dst" == /usr/* || "$dst" == /boot/* ]]; then
        sudo "$@"
    else
        "$@"
    fi
}

while IFS='|' read -r src dst method; do
    # Skip comments and empty lines
    [[ -z "${src// }" || "$src" =~ ^[[:space:]]*# ]] && continue

    method="${method:-symlink}"

    src="$DOTFILES_ROOT/$src"

    if [[ ! -e "$src" ]]; then
        echo "[ERROR] Source not found: %s\n" "${src#$DOTFILES_ROOT/}" >&2
        continue
    fi

    src="$(realpath "$src")"

    if [[ -z "$dst" ]]; then
        dst="$CONFIG_HOME/$(basename "$src")"
    else
        dst="$(expand_path "$dst")"
    fi

    run mkdir -p "$(dirname "$dst")"

    case "$method" in
        symlink)
            run rm -rf "$dst"
            run ln -sfn "$src" "$dst"
            printf "[LINK]  %-30s -> %s\n" "${src#$DOTFILES_ROOT/}" "$dst"
            ;;

        copy)
            run rm -rf "$dst"
            run cp -a "$src" "$dst"
            printf "[COPY]  %-30s -> %s\n" "${src#$DOTFILES_ROOT/}" "$dst"
            ;;

        merge)
            run mkdir -p "$dst"
            run cp -a "$src/." "$dst/"
            printf "[MERGE] %-30s -> %s\n" "${src#$DOTFILES_ROOT/}" "$dst"
            ;;

        *)
            echo "[ERROR] Unknown method '%s' for '%s'\n" "$method" "${src#$DOTFILES_ROOT/}"
            ;;
    esac
done < "$SCRIPT_DIR/apps.txt"

chsh -s $(which zsh)
