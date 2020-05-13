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
plugins=(osx history-substring-search)

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


#--- Aliases ----------------------------------------------------------
# general stuff
alias flushdns='sudo dscacheutil -flushcache' # clear the dns cache on Mac OS
alias l='ls -alF'                             # that's how I dooz it larry
alias ll='ls -lF'                             # omit hidden files from listing
alias path="echo ${PATH} | tr ':' '\n'"       # friendlier path listing
alias duh="sudo du -h -d 1"                   # don't need to know everything
alias srch="grep -rlE"                        # text search
alias ping='ping -c 4'                        # dos style
alias npmls='npm ls --depth=0'                # I rarely need all the extra crap

# git stuff
alias g='git'
alias ga='git add'
alias gb='git branch -vv'
alias gba='git branch -avv'
alias gbd='git branch -d'
alias gc!='git commit -v --amend'
alias gc='git commit -v'
alias gc='git commit -v'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcm='git checkout master'
alias gco='git checkout'
alias gd="git diff --color-words"
alias gf='git fetch'
alias ghh='git help'
alias gl="git --no-pager  log --graph --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %ar%Creset' -20"
alias gll="git log --stat --abbrev-commit"
alias glo="git log --graph --pretty='%Cred%h%Creset %C(auto)%d%Creset %s %Cgreen(%ad)' --date=short"
alias gm='git merge'
alias gp='git push'
alias gr='git remote'
alias grb='git rebase'
alias grm='git rm'
alias grs='git restore'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias grv='git remote -v'
alias gst='git status'
alias gsw='git switch'


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


#--- fzf (https://github.com/junegunn/fzf) ----------------------------
# Enable key bindings and auto completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://github.com/junegunn/fzf
# -------------------------------
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
}

# stolen from https://github.com/samoshkin/dotfiles
# ---------------------------------------------------
FD_OPTIONS="--hidden --follow --exclude .git --exclude node_modules"

export FZF_DEFAULT_OPTS="--no-mouse --height 50% -1 --reverse --multi --inline-info --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300' --preview-window='right:hidden:wrap' --bind='f3:execute(bat --style=numbers {} || less -f {}),f2:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-y:execute-silent(echo {+} | pbcopy),ctrl-x:execute(rm -i {+})+abort'"

if command -v fd > /dev/null; then
  # Use git-ls-files inside git repo, otherwise fd
  export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard || fd --type f --type l $FD_OPTIONS"
  export FZF_CTRL_T_COMMAND="fd $FD_OPTIONS"
  export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
fi
