#!/bin/sh
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"

autoload -U colors && colors

export PATH="$HOME/.local/bin":$PATH
export GIT_PS1_SHOWDIRTYSTATE=1
# deno
export DENO_INSTALL="/home/frogharvard/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
# npm
export PATH="$HOME/.node/bin:$PATH"  
export NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH"

# history
HISTFILE=~/.zsh_history

# plugins
plug "esc/conda-zsh-completion"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"

# keybinds
bindkey '^ ' autosuggest-accept

if command -v bat &>/dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\""
  alias catt="bat --theme \"Visual Studio Dark+\""
fi

source ~/.git-prompt.sh
setopt PROMPT_SUBST
does_branch_exist() {
  if [[ $(git branch | wc -l) != 0 ]]; then
    echo "$(__git_ps1 '(%s) ')"
  fi
}

get_current_time() {
  echo $(date +"%r")
}

# timer corner
declare -A timer_options
timer_options["work"]="50"

notify() {
  session_type=$1
  urgency="normal"
  expire_time=$2
  app_name="timer"
  sound_file="string:sound-file:/usr/share/sounds/freedesktop/stereo/complete.oga"

  notify-send -u $urgency -t $expire_time -a $app_name -h $sound_file \
    "$session_type session done" \
    "you can relax now"
}

pomodoro_timer() {
  if [ -n "$1" -a -n "${timer_options["$1"]}" ]; then
    val=$1
    expire_time=3000

    echo $val | lolcat
    timer ${timer_options["$val"]}m && notify $val $expire_time
  fi
}

PROMPT='%B%{$fg[yellow]%}$(does_branch_exist)~%b '

# aliases
# root privileges
alias doas="doas --"
alias dotfiles="cd ~/dotfiles"
alias go="pomodoro_timer 'work'"

# brew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# open mpi
source /etc/profile.d/modules.sh
module load mpi/openmpi-x86_64

# this must be at the end of the file for sdkman to work!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
