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

# https://github.com/robbyrussell/oh-my-zsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX=true

# what it says
source $ZSH/oh-my-zsh.sh

# no clue...
: ${UNAME=$(uname)}


#--- add our bin dir and cwd to the path --------------------------------------
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

# don't need to know everything
alias duh="sudo du -h -d 1"

# text search
alias srch="grep -rlE"

# dos style
alias ping='ping -c 4'

# I rarely need all the extra crap
alias npmls='npm ls --depth=0'


#--- git stuff --------------------------------------------------------
# there's a whole bunch more in ~/.oh-my-zsh/plugins/git/git.plugin.zsh
# these are here to override/add to those
alias gc='git commit'
alias gd="git diff --color-words"
alias gl="git --no-pager  log --graph --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %ar%Creset' -20"
alias gll="git log --stat --abbrev-commit"
alias grb='git rebase'
alias gb='git branch -vv'
alias gba='git branch -avv'



#--- Python virtualenv ------------------------------------------------
# pip should only run if there is a virtualenv currently activated
# to avoid inadvertently installing global packages
export PIP_REQUIRE_VIRTUALENV=true

# workaround virtualenv requirement
gpip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
gpip3() {
  PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}


# virtualenvwrapper config
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
[ -f "/usr/local/bin/virtualenvwrapper_lazy.sh" ] &&
    source /usr/local/bin/virtualenvwrapper_lazy.sh


#--- npm --------------------------------------------------------------
# github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
NPM_PACKAGES="$HOME/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH=$NPM_PACKAGES/bin:$PATH
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

#--- Mac OS X specific ------------------------------------------------
if [ "$UNAME" = Darwin ]; then
  # list user accounts info
  alias lsuser="dscacheutil -q user | grep -A 4 -B 2 -e uid:\ 5'[0-9][0-9]'"
fi


#--- autojump ---------------------------------------------------------
[[ -s $(brew --prefix)/etc/autojump.sh ]] &&
  . $(brew --prefix)/etc/autojump.sh


#--- Homebrew ---------------------------------------------------------
export PATH="/usr/local/sbin:$PATH"


#--- command line syntax highlighting, sort of ------------------------
# this has to come first, apparently, at least for the pattern to work
source $HOME/.custom/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# enable non-default hightlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# highlight `rm -rf` in red:
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
