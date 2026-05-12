# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

export ZSH="$HOME/.oh-my-zsh"

setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY          # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file
HISTFILE=${XDG_DATA_HOME=$HOME/.local/share/}/zsh/zsh_history
[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h

HISTFILESIZE=100000
HISTSIZE=200000

ZSH_THEME="robbyrussell"
# ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  fzf
  z
  per-directory-history
  nvm
  zsh-autosuggestions
  zsh-syntax-highlighting
)

zstyle ':omz:plugins:nvm' lazy yes

source $ZSH/oh-my-zsh.sh
source /etc/environment
source ~/.profile

# custom exports
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export DISPLAY=:0

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# custom keybinds
bindkey -s ^f "louarch tmux attach\n"
bindkey -s ^k "louarch tmux kill\n"
bindkey -s ^v "cliphist list | fzf | cliphist decode | wl-copy\n"
bindkey -s ^e "nvim .\n"

# custom alias
alias py="python3"
alias lock="i3lock -i /home/lou/Pictures/lockalt.png -t"
alias code="~/develop/vscode/bin/code"
alias lvim="NVIM_APPNAME=lvim nvim"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform
source $HOME/.local/bin/completions
