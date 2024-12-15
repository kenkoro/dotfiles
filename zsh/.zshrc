#!/bin/sh
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

autoload -U colors && colors

# In addition, if you set GIT_PS1_SHOWDIRTYSTATE to a nonempty value,
# unstaged (*) and staged (+) changes will be shown next to the branch
# name.
export GIT_PS1_SHOWDIRTYSTATE=1
# For gpg signature
export GPG_TTY=$(tty)
# Java environment
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@21/21.0.4/libexec/openjdk.jdk/Contents/Home

# Zsh history
HISTFILE=~/.zsh_history

# Plugins
plug "esc/conda-zsh-completion"
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
plug "zap-zsh/supercharge"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/zap-prompt"

# Bindkeys
# Ctrl-Y
bindkey '^Y' autosuggest-accept

if command -v bat &>/dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\""
  alias catt="bat --theme \"Visual Studio Dark+\""
fi

source ~/.git-prompt.sh
setopt PROMPT_SUBST
does_branch_exist() {
  if [[ -d .git && $(git branch | wc -l) != 0 ]]; then
    echo "$(__git_ps1 '(%s) ')"
  fi
}

get_current_time() {
  echo $(date +"%r")
}

PROMPT='%B%{$fg[yellow]%}$(does_branch_exist)~%b '

# Aliases
alias dotfiles="cd ~/Dev/dotfiles"
alias dev="cd ~/Dev"
alias ll="ls -l"
alias taurus="dev; cd taurus"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"
source "$HOME/.cargo/env"

eval "$(rbenv init -)"
