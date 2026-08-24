# Keybindings

# Cursor shape per vi mode
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

# Disable command mode line highlight
ZVM_VI_HIGHLIGHT_BACKGROUND=none
ZVM_VI_HIGHLIGHT_FOREGROUND=none
ZVM_VI_HIGHLIGHT_EXTRASTYLE=none

# Enable system clipboard integration
ZVM_SYSTEM_CLIPBOARD_ENABLED=true

# zsh-vi-mode resets all bindings on init, so custom bindings
# must be registered via this hook to survive.
zvm_after_init() {
  # Ctrl+Right -> move forward one word (^[[1;5C is the terminal escape code)
  bindkey '^[[1;5C' forward-word

  # Ctrl+Left -> move backward one word (^[[1;5D is the terminal escape code)
  bindkey '^[[1;5D' backward-word

  # Ctrl+F -> fzf file picker (no hidden files)
  bindkey '^F' _fzf_file_no_hidden

  # Ctrl+\ -> toggle autosuggestions (useful for screen recordings)
  bindkey '^\' autosuggest-toggle

  # Up/Down -> history search by substring (^[[A/^[[B are up/down arrow escape codes)
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
}

# Allow pasting from system clipboard with `p`/`P`
_zvm_vi_put_after() {
  CUTBUFFER="$(wl-paste -n)"
  zvm_vi_put_after
}

_zvm_vi_put_before() {
  CUTBUFFER="$(wl-paste -n)"
  zvm_vi_put_before
}

zvm_after_lazy_keybindings() {
  zvm_define_widget _zvm_vi_put_after
  zvm_define_widget _zvm_vi_put_before

  zvm_bindkey vicmd 'p' _zvm_vi_put_after
  zvm_bindkey vicmd 'P' _zvm_vi_put_before
}
