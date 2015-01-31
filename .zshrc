#--- oh my zsh settings -----------------------------------------------
# path to the oh-my-zsh config
ZSH=$HOME/.oh-my-zsh

# path to custom config files
ZSH_CUSTOM=$HOME/.custom/oh-my-zsh

# theme to load.
ZSH_THEME="ultranoster"

# disable auto-update checks
DISABLE_AUTO_UPDATE="true"

# plugins in ~/.oh-my-zsh/plugins/*
plugins=(git osx history-substring-search)

# use case-sensitive completion
CASE_SENSITIVE="true"

# what it says
source $ZSH/oh-my-zsh.sh

# no clue...
: ${UNAME=$(uname)}


#--- path -------------------------------------------------------------
PATH=$PATH:~/bin:.


#--- Aliases (and a function) -----------------------------------------
# clear the dns cache
alias flushdns='sudo dscacheutil -flushcache'

# that's how I dooz it larry
alias l='ls -alF'

# omit hidden files from listing
alias ll='ls -lF'

# friendlier path listing
alias path="echo ${PATH} | tr ':' '\n'"

# friendlier `dirs` listing
alias dirs="dirs | tr ' ' '\n':"

# dos style
alias ping='ping -c 4'

# pretty prints json
alias mjson='python -mjson.tool'

# Alt-S (Esc-S) inserts "sudo " at the start of line
insert_sudo () { zle beginning-of-line; zle -U "sudo "!! }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo


#--- Sass watch -------------------------------------------------------
alias sw='sass --watch -tcompressed css/sass:css &'
alias swd='sass --watch --debug-info -tcompact css/sass:css &'


#--- git stuff --------------------------------------------------------
# there's a whole bunch more in ~/.oh-my-zsh/plugins/git/git.plugin.zsh
# these are here to override/add to those
alias gc='git commit'
alias gca='git commit -v -a'
alias gcv='git commit -v'
alias gd="git diff --color-words"
alias gl="git --no-pager  log --graph --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %ar%Creset' -20"
alias gll="git log --stat --abbrev-commit"
alias grb='git rebase'

#--- Python virtualenv ------------------------------------------------
# pip should only run if there is a virtualenv currently activated
# to avoid inadvertently installing global packages
export PIP_REQUIRE_VIRTUALENV=true

# workaround virtualenv requirement
gpip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

# virtualenvwrapper config
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
[ -f "/usr/local/bin/virtualenvwrapper_lazy.sh" ] &&
    source /usr/local/bin/virtualenvwrapper_lazy.sh


#--- Mac OS X specific ------------------------------------------------
if [ "$UNAME" = Darwin ]; then
  : #no-op for now
fi


#--- autojump ---------------------------------------------------------
[[ -s $(brew --prefix)/etc/autojump.sh ]] &&
  . $(brew --prefix)/etc/autojump.sh


#--- This loads NVM ---------------------------------------------------
# https://github.com/creationix/nvm
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh


#--- Google Cloud SDK -------------------------------------------------
# The next line updates PATH for the Google Cloud SDK.
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] &&
    source "$HOME/google-cloud-sdk/path.zsh.inc"
# The next line enables bash completion for gcloud.
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] &&
    source "$HOME/google-cloud-sdk/completion.zsh.inc"
