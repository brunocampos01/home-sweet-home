# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#---------------------------------------------------------------
# General Configuration
#---------------------------------------------------------------
export LANG=en_US.UTF-8

# Platform detection
OS_TYPE="$(uname -s)"

# Load shared aliases (bash + zsh)
[[ -f ~/.shell_aliases ]] && source ~/.shell_aliases

# colorls (guard — only alias if installed)
command -v colorls &>/dev/null && alias ls='colorls' && alias ll='colorls -la'

#---------------------------------------------------------------
# History
#---------------------------------------------------------------
setopt HIST_IGNORE_SPACE       # don't save lines starting with a space
setopt HIST_IGNORE_DUPS        # eliminate consecutive duplicates
setopt hist_ignore_all_dups    # remove older duplicate entries from history
setopt APPEND_HISTORY          # append to history, don't overwrite it
setopt share_history           # share history between shell instances
setopt auto_menu               # automatically use menu completion
setopt always_to_end           # move cursor to end if word had one match
setopt EXTENDED_HISTORY        # add timestamp to history entries

# Setting -1 makes history unlimited
export HISTSIZE=-1
export SAVEHIST=-1
export HISTFILE=~/.zsh_eternal_history
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export HIST_IGNORE="git*:history:ll*:ls:ps"

#---------------------------------------------------------------
# Autocompletion
#---------------------------------------------------------------
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:::::' completer _expand _complete _ignored _approximate

autoload -Uz compinit;
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

zmodload -i zsh/complist

#---------------------------------------------------------------
# Oh My Zsh
#---------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

CASE_SENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

#---------------------------------------------------------------
# Syntax Highlighting (portable — checks multiple install paths)
#---------------------------------------------------------------
_zsh_hl_paths=(
    "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "${HOME}/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)
for _zsh_hl in "${_zsh_hl_paths[@]}"; do
    if [[ -f "$_zsh_hl" ]]; then source "$_zsh_hl"; break; fi
done
unset _zsh_hl _zsh_hl_paths

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#---------------------------------------------------------------
# Paths
#---------------------------------------------------------------
export PATH=$PATH
# Java
# export JAVA_HOME=/usr/lib/jvm/default-java

# Python
# export PYTHONHOME=
# export PYTHONPATH=
