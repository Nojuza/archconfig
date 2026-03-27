#    _               _              
#   | |__   __ _ ___| |__  _ __ ___ 
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__ 
# (_)_.__/ \__,_|___/_| |_|_|  \___|
# 

# If not running interactively, don't do anything
force_color_prompt=yes
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# -----------------------------------------------------
# LOAD CUSTOM .bashrc_custom if exists
# -----------------------------------------------------
if [ -f ~/.bashrc_custom ] ;then
    source ~/.bashrc_custom
fi

# -----------------------------------------------------
# Fastfetch if in Hyprland
# -----------------------------------------------------
if [[ $(tty) == *"pts"* ]]; then
    fastfetch
else
    echo
    echo "Start Hyprland with command Hyprland"
fi

alias ml4w-hyprland='~/.config/ml4w/apps/ML4W_Hyprland_Settings-x86_64.AppImage'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function sb() {
  switchboard
}
# ~/.bashrc

eval "$(starship init bash)"

# opencode
export PATH=/home/nojuza/.opencode/bin:$PATH

# go
export PATH="$PATH:$HOME/go/bin"

# --- Gas Town Integration (managed by gt) ---
[[ -f "/home/nojuza/.config/gastown/shell-hook.sh" ]] && source "/home/nojuza/.config/gastown/shell-hook.sh"
# --- End Gas Town ---
. "$HOME/.cargo/env"

# Bare git repo dotfiles management — use 'dotfiles' instead of 'git'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
