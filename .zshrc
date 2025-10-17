
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export ZSH="$HOME/.oh-my-zsh"

setopt inc_append_history hist_expire_dups_first hist_ignore_space
HISTFILE=${XDG_DATA_HOME=$HOME/.local/share/}/zsh/zsh_history
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h

HISTFILESIZE=100000
HISTSIZE=200000

ZSH_THEME="robbyrussell"
# ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  fzf
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  per-directory-history
)

source $ZSH/oh-my-zsh.sh
source /etc/environment
source ~/.profile

[[ -s $HOME/.nvm/nvm.sh ]] && source "$HOME/.nvm/nvm.sh"
# . "$HOME/.cargo/env"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:$HOME/SW/flutter/bin/"
export FZF_BASE=/usr/bin/fzf

# custom exports
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DISPLAY=:0

# custom alias
alias py="python3"
alias lock="i3lock -i /home/lou/Pictures/lockalt.png -t"
alias vim="nvim"
alias lvim="NVIM_APPNAME=lvim nvim"
alias code="~/vscode/bin/code"

# custom keybinds
bindkey -s ^f "tmux-sessionizer\n"
bindkey -s ^v "cliphist list | fzf | cliphist decode | wl-copy\n"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
