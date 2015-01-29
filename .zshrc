#===============================================================================
# oh my zsh settings
#===============================================================================
ZSH=$HOME/.oh-my-zsh                  # path to your oh-my-zsh config
ZSH_CUSTOM=$HOME/.custom/oh-my-zsh    # path to custom config files
ZSH_THEME="ultranoster"               # theme to load.
CASE_SENSITIVE="true"                 # use case-sensitive completion
plugins=(git osx history-substring-search)
                                      # plugins in ~/.oh-my-zsh/plugins/*
DISABLE_AUTO_UPDATE="true"            # stop oh-my-zsh from doing auto-update
source $ZSH/oh-my-zsh.sh              # what it says
unsetopt correct_all                  # disable the !helpful autocorrect

: ${UNAME=$(uname)}


#===============================================================================
# Python virtualenv
#===============================================================================
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


#===============================================================================
# personal settings
#===============================================================================
PATH=$PATH:~/bin:/usr/local/mysql/bin:.

#--- enable vi mode ---------------------------------------------
bindkey -v

#--- Alt-S (Esc-S) inserts "sudo " at the start of line ----------------
insert_sudo () { zle beginning-of-line; zle -U "sudo "!! }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

#--- Aliases (and a function) ------------------------------------------
alias dbox="cd ~/Dropbox"                     # go to my Dropbox
alias ez="vim ~/.zshrc"                       # quick edit zshrc
alias flushdns='sudo dscacheutil -flushcache' # clear the dns cache
alias l='ls -alF'                             # that's how I dooz it larry
lls () { l "$@" | less }                      # paginate ls
alias ll='ls -lF'                             # omit hidden files from listing
alias path="echo ${PATH} | tr ':' '\n'"       # friendlier path listing
alias dirs="dirs | tr ' ' '\n':"           # friendlier `dirs` listing
alias ping='ping -c 4'                        # dos style
alias mjson='python -mjson.tool'              # pretty prints json

#--- Sass watch --------------------------------------------------------
alias sw='sass --watch -tcompressed css/sass:css &'
alias swd='sass --watch --debug-info -tcompact css/sass:css &'

#--- git stuff ---------------------------------------------------------
# there's a whole bunch more in ~/.oh-my-zsh/plugins/git/git.plugin.zsh
# these are here to override/add to those
alias gc='git commit'
alias gca='git commit -v -a'
alias gcv='git commit -v'
alias gd="git diff --color-words"
alias gl="git --no-pager  log --graph --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %ar%Creset' -20"
alias gll="git log --stat --abbrev-commit"
alias grb='git rebase'


#===============================================================================
# Mac OS X specific
#===============================================================================
if [ "$UNAME" = Darwin ]; then
  # put ports on the paths if /opt/local exists
  test -x /opt/local -a ! -L /opt/local && {
    PORTS=/opt/local

    # setup the PATH and MANPATH
    PATH="$PORTS/bin:$PORTS/sbin:$PATH"
    MANPATH="$PORTS/share/man:$MANPATH"

    # nice little port alias
    alias port="sudo nice -n +18 $PORTS/bin/port"
  }
fi


#===============================================================================
# autojump
#===============================================================================
[[ -s $(brew --prefix)/etc/autojump.sh ]] && . $(brew --prefix)/etc/autojump.sh

#===============================================================================
# This loads NVM
# https://github.com/creationix/nvm
#===============================================================================
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh


#===============================================================================
# Google Cloud SDK
#===============================================================================
# The next line updates PATH for the Google Cloud SDK.
[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] &&
    source "$HOME/google-cloud-sdk/path.zsh.inc"
# The next line enables bash completion for gcloud.
[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] &&
    source "$HOME/google-cloud-sdk/completion.zsh.inc"
