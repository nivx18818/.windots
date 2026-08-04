# Set GNOME interface fonts
setfont() {
  local font="${1:?Usage: setfont <font-name> [size]}"
  local size="${2:-11}"
  local value="${font} ${size}"

  gsettings set org.gnome.desktop.interface font-name "$value"
  gsettings set org.gnome.desktop.interface document-font-name "$value"
  gsettings set org.gnome.desktop.interface monospace-font-name "$value"

  echo "Font set to: $value"
}

conf () {
  nvim "$XDG_CONFIG_HOME/$1"
}

proj () {
  zed "$HOME/Projects/$1"
}

