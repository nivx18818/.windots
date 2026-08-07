# ---------- XDG base directories ----------
# Centralizes config/cache/data locations
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ---------- Editor ----------
# Default editor used by git, crontab, etc.
export EDITOR="nvim"
export VISUAL="nvim"

# ---------- Pager ----------
# if command -v bat >/dev/null 2>&1; then
#   export MANPAGER="bat -l man -p"
# elif command -v batcat >/dev/null 2>&1; then
#   export MANPAGER="batcat -l man -p"
# fi

# ---------- GPG ----------
export GPG_TTY=$(tty)

# ---------- Starship ----------
export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

# ---------- PATH ----------
# Personal binaries/scripts
export PATH="$HOME/.local/bin:$PATH"

# ---------- MISC ----------
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME/npm/config/npm-init.js"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"

export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"

export WINEPREFIX="$XDG_DATA_HOME/wine"

export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

