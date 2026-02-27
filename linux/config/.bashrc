#---------------------------------------------------------------
# General Configuration
#---------------------------------------------------------------
# You may need to manually set your language environment
export LANG=en_US.UTF-8

#---------------------------------------------------------------
# History
#---------------------------------------------------------------
# Combine: don't save lines starting with space AND eliminate duplicates
HISTCONTROL=ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# Setting HIST to a value less than zero causes the history list to be unlimited
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTFILE=~/.bash_eternal_history
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
export HISTIGNORE="git*:history:ll*:ls:ps"

# Force prompt to write history after every command.
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

#---------------------------------------------------------------
# Platform & Shared Aliases
#---------------------------------------------------------------
OS_TYPE="$(uname -s)"

# Load shared aliases (bash + zsh)
[[ -f ~/.shell_aliases ]] && source ~/.shell_aliases

#---------------------------------------------------------------
# Oh my bash
#---------------------------------------------------------------
# Path to your oh-my-bash installation.
export OSH=$HOME/.oh-my-bash

# Set name of the theme to load.
OSH_THEME="zork"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_OSH_DAYS=1

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

completions=(
  composer
  ssh
  git
)

aliases=(
  general
)

plugins=(
  bashmarks
  git
)

source $OSH/oh-my-bash.sh

#---------------------------------------------------------------
# Colored Terminal
#---------------------------------------------------------------
NORMAL=`echo -e '\033[0m'`
RED=`echo -e '\033[31m'`
GREEN=`echo -e '\033[0;32m'`
LGREEN=`echo -e '\033[1;32m'`
BLUE=`echo -e '\033[0;34m'`
LBLUE=`echo -e '\033[1;34m'`
YELLOW=`echo -e '\033[0;33m'`

# grep
GREP_OPTS='--color=auto'      # for aliases since $GREP_OPTIONS is deprecated
GREP_COLOR='1;32'             # (legacy) bright green rather than default red
GREP_COLORS="ms=$GREP_COLOR"  # (new) Matching text in Selected line = green
alias   grep='grep $GREP_OPTS'
alias   egrep='egrep $GREP_OPTS'
alias   fgrep='fgrep $GREP_OPTS'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# man pg
function _colorman() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;35m") \
    LESS_TERMCAP_md=$(printf "\e[1;34m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[7;40m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;33m") \
      "$@"
}
function man() { _colorman man "$@"; }
function perldoc() { command perldoc -n less "$@" |man -l -; }

# GNU ls
eval "$( dircolors --sh $(ls -d ~/.dircolors 2>/dev/null) )"

# LS_COLORS
LS_COLORS=$LS_COLORS:'di=1;93:ex=1;33:*.gitignore=34:*LICENSE=34:*.editorconfig=34' ;

_ls_colors_add() {
  local BASE_COLOR="${LS_COLORS##*:?.$1=}" NEW
  if [ "$LS_COLORS" != "$BASE_COLOR" ]; then
    BASE_COLOR="${LS_COLORS}"
    shift
    for NEW in "$@"; do
      if [ "$LS_COLORS" = "${LS_COLORS#*.$NEW=}" ]; then
        LS_COLORS="${LS_COLORS%%:}:*.$NEW=$BASE_COLOR:"
      fi
    done
  fi
  export LS_COLORS
}

_ls_colors_add zip jar xpi egg        # archives
_ls_colors_add jpg ico JPG PNG webp   # images
_ls_colors_add ogg opus               # audio

CLICOLOR=1

if ls -ld --color=auto / >/dev/null 2>&1
  then alias ls="ls -ph --color=auto"
  else alias ls="ls -ph"
fi

# Networks
IP4=$GREEN
IP6=$LBLUE
IFACE=${YELLOW}
DEFAULT_ROUTE=$LBLUE

IP_CMD=$(which ip)

function colored_ip()
{
${IP_CMD} $@ | sed \
    -e "s/inet [^ ]\+ /${IP4}&${NORMAL}/g"\
    -e "s/inet6 [^ ]\+ /${IP6}&${NORMAL}/g"\
    -e "s/^default via .*$/${DEFAULT_ROUTE}&${NORMAL}/"\
    -e "s/^\([0-9]\+: \+\)\([^ \t]\+\)/\1${IFACE}\2${NORMAL}/"
}

alias ip='colored_ip'

#---------------------------------------------------------------
# Paths
#---------------------------------------------------------------
export EDITOR=/usr/bin/vim
# Java
# export JAVA_HOME=/usr/lib/jvm/default-java

# Python
# export PYTHONHOME=
# export PYTHONPATH=

# AWS
# export AWS_ACCESS_KEY_ID=
# export AWS_SECRET_ACCESS_KEY=

# MAVEN artifactory
# export MAVEN_artifactoryPass_reader=
# export MAVEN_artifactoryUser_reader=reader
