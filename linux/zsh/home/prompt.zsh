# ~/.config/zsh/prompt.zsh

# Add a blank line before prompt
precmd() {
  precmd() {
    echo
  }
}

# Prevent Python virtualenv from polluting the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

FUNCNEST=100

eval "$(starship init zsh)"
