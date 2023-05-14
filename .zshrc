#!/bin/zsh

#################
# USER init MOD #
#################

# bullet-train: no newline
#BULLETTRAIN_PROMPT_ADD_NEWLINE=false

# Add additional completions
# ... remove `~/.zcompdump` to refresh
fpath=(
    ~/.zsh_profiles/completions
    ~/.nix-profile/share/zsh/site-functions
    $fpath
    ~/.zsh_profiles/plugins/zsh-completions/src
)

#############################################################################
### OH-MY-ZSH ###############################################################
#############################################################################

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bullet-train.zsh/bullet-train"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.zsh_profiles

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  colored-man-pages
  colorize
  archlinux
  systemd
  themes
  you-should-use
  zsh-syntax-highlighting
  zsh-autosuggestions
  conda-zsh-completion
  brew
  pip
  nix-zsh-completions
)

#echo $fpath | sed 's/ /\n/g'
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#############################################################################
### END of OH-MY-ZSH ########################################################
#############################################################################

#########################################
###### USER MOD #########################
#########################################

# update env
source $HOME/.shrc

# homebrew
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

#######################
# bullet-train mod ####
#######################
BULLETTRAIN_PROMPT_ORDER=(
  time
  status
  custom
  context
  dir
  screen
  perl
  ruby
  virtualenv
  conda ### user mod
  aws
  go
  rust
  elixir
  git
  hg
  cmd_exec_time
)

prompt_nix_shell_setup

export BULLETTRAIN_CONTEXT_DEFAULT_USER=bryan
[[ -n $SSH_CONNECTION ]] || [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]] && \
  export BULLETTRAIN_IS_SSH_CLIENT=true
alias dm-zsh='dm enter BULLETTRAIN_CUSTOM_MSG=yadm zsh'

# https://github.com/caiogondim/bullet-train.zsh/issues/282#issuecomment-516266791
prompt_conda() {
  command -v conda &>/dev/null \
  && prompt_segment \
    $BULLETTRAIN_VIRTUALENV_BG \
    $BULLETTRAIN_VIRTUALENV_FG \
    "$BULLETTRAIN_VIRTUALENV_PREFIX anaconda" \
  || true
}

# Begin a segment
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%b%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%B%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%b%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}
# Bold
PROMPT="$PROMPT"'%B'
# Un-`bold`-ify
POSTEDIT=$'\e[0m'

###########################
# END of bullet-train mod #
###########################

# Highlighter
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern root line)
ZSH_HIGHLIGHT_STYLES[line]='bold'

# Complete in word
bindkey '^I' expand-or-complete-prefix
bindkey '' undo
# Same background '&' as bash
setopt NO_HUP
setopt NO_CHECK_JOBS
# Trim history
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt ALWAYS_TO_END
# List when pwd changed
chpwd() {
    ls -alhF --group-directories-first >&2
    >&2 echo "$(tput bold)>> $PWD$(tput sgr0)"
}

# Remove unwanted completion
zstyle ':completion:*' ignored-patterns 'gedi'
zstyle ':completion:*' known-hosts-file off
zstyle ':completion:*' hosts off
# Custom completion
compcopy() {
    if whichq "$1"; then
        local model=$1
        shift
        for cmd in "$@"; do
            compdef "$cmd"="$model" &>/dev/null
        done
    fi
}
compcopy tmux byobu
compcopy yadm yadm-nonbare
compcopy env proxychains env-proxy tldr
compcopy ssh ssh-serve autossh autossh-reverse

# git: Don't complete remote url or local directories
__git_remote_repositories () {
  if compset -P '*:'; then
    _remote_files -/ -- ssh
#  else
#    _ssh_hosts -S:
  fi
}
__git_local_repositories () { :; }

# colored less
zmodload zsh/zpty

pty() {
    zpty pty-${UID} ${1+$@}
    if [[ ! -t 1 ]];then
        setopt local_traps
        trap '' INT
    fi
    zpty -r pty-${UID}
    zpty -d pty-${UID}
}

ptyless() {
    pty $@ | less
}

# Kill word
export WORDCHARS='|'

autoload -Uz compinit
compinit

# zoxide, after compinit
if whichq zoxide; then eval "$(zoxide init --cmd j zsh)"; fi

# pipx
autoload -U bashcompinit
bashcompinit
if whichq register-python-argcomplete; then eval "$(register-python-argcomplete pipx)"; fi

if whichq direnv; then eval "$(direnv hook zsh)"; fi
if whichq rtx; then eval "$(rtx activate zsh)"; fi
