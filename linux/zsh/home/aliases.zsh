# Better ls
alias ls='eza --icons'

# Detailed listing
alias ll='eza -lh --icons --git'

# Detailed listing including hidden files
alias la='eza -lah --icons --git'

# Tree view
alias tree='eza --tree --icons'

# Reuse ls completions for eza (avoids defining a separate completion function)
compdef eza=ls

# Better cat
alias cat='bat'

# Core utilities
# alias grep='rg --color=auto'
alias diff='diff --color=auto'
alias df='df -h'
alias cls="precmd() {precmd() {echo }} && clear"


# Navigation
# -- prevents - being parsed as a flag; cd - jumps to previous directory
alias -- -='cd -'

lf() { # zsh follow lf navigation
    tmp=$(mktemp)
    command lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir=$(cat "$tmp")
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Editor
alias zed='zeditor'

# Git
alias glog='PAGER="less -F -X" git log'  # -F quit if one screen, -X no clear on exit
alias gadog='PAGER="less -F -X" git log --all --decorate --oneline --graph'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Video
alias stream='mpv av://v4l2:/dev/video4 --fullscreen --demuxer-lavf-o=input_format=mjpeg,framerate=30 --profile=low-latency --untimed'

# Misc
alias evnup='sudo ipsec restart && sleep 1 && sudo ipsec up evnfc-dc && sudo resolvconf -u'
alias evndn='sudo ipsec down evnfc-dc'

alias gaming-on='echo 1 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'
alias gaming-off='echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo'

alias codex-update='curl -fsSL https://chatgpt.com/codex/install.sh | sh'
alias codex-remote='codex remote-control'

alias plytest='sudo plymouthd --debug --debug-file=/tmp/plymouth-debug.log --tty=/dev/tty2; sudo plymouth --show-splash; sleep 3; sudo plymouth --quit'
alias plylog="sudo grep \"Text '\" /tmp/plymouth-debug.log | tail -20"
