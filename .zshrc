#--- oh my zsh settings -----------------------------------------------
ZSH=$HOME/.oh-my-zsh                    # path to the oh-my-zsh config
ZSH_CUSTOM=$HOME/.custom/oh-my-zsh      # path to custom config files
ZSH_THEME="ultranoster"                 # theme to load.
DISABLE_AUTO_UPDATE="true"              # disable auto-update checks
plugins=(history-substring-search)  # plugins in ~/.oh-my-zsh/plugins/*
CASE_SENSITIVE="true"                   # use case-sensitive completion
ZSH_DISABLE_COMPFIX=true                # https://github.com/robbyrussell/oh-my-zsh/issues/6835#issuecomment-390216875
source $ZSH/oh-my-zsh.sh                # what it says


#--- add our bin dir and cwd to the path --------------------------------------
PATH=$PATH:~/bin:.


#--- Aliases ----------------------------------------------------------
# general stuff
alias flushdns='sudo dscacheutil -flushcache' # clear the dns cache on Mac OS

# if `exa` is installed, use it in place of `ls`
if command -v exa &>/dev/null; then
  alias ls='exa'                              # barebones
  alias l='exa -aalF'                         # show everything
  alias ll='exa -lF'                          # exclude hidden files, `.` and `..` dirs
  alias lt='exa -aalF -s new'                 # sort by modified time
else
  alias l='ls -alhF'                          # same as above, basically
  alias ll='ls -lhF'
  alias lt='ls -alhFt'
fi

# if `bat` is installed, use it in place of `cat`
if command -v bat &>/dev/null; then
  alias cat='bat'
fi

# if `nvim` is installed, use it
if command -v nvim &>/dev/null; then
  alias vim='nvim'
fi

alias path="echo ${PATH} | tr ':' '\n'"       # friendlier path listing
alias duh="sudo du -h -d 1"                   # don't need to know everything
alias srch="grep -rlE"                        # text search
alias ping='ping -c 4'                        # dos style
alias npmls='npm ls --depth=0'                # I rarely need all the extra crap

alias bbb='brew update && brew upgrade && brew cleanup && brew doctor'

# git stuff
alias g='git'
alias ga='git add'
alias gb='git branch -vv'
alias gba='git branch -avv'
alias gbd='git branch -d'
alias gc!='git commit -v --amend'
alias gc='git commit -v'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcm='git checkout master'
alias gco='git checkout'
alias gd="git diff --color-words"
alias gf='git fetch'
alias gfc='gll -i --grep'
alias ghh='git help'
alias gl="git --no-pager  log --graph --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(white)- %ar%Creset' -20"
alias glg="git log --all --name-status -i --grep"
alias gll="git log --stat --abbrev-commit --date=format:'%a %b %d %Y %T'"
alias glo="git log --graph --pretty='%Cred%h%Creset %C(auto)%d%Creset %s %Cgreen(%ad)' --date=short"
alias gm='git merge'
alias gmo='git merge origin/master'
alias gp='git push'
alias gr='git remote'
alias grb='git rebase'
alias grm='git rm'
alias grs='git restore'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias grv='git remote -v'
alias gst='git status'
alias gsw='git switch'


#--- npm --------------------------------------------------------------
# github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
NPM_PACKAGES="$HOME/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH=$NPM_PACKAGES/bin:$PATH
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"


#--- autojump ---------------------------------------------------------
[[ -s $(brew --prefix)/etc/autojump.sh ]] &&
  . $(brew --prefix)/etc/autojump.sh


#--- Homebrew ---------------------------------------------------------
export PATH="/usr/local/sbin:$PATH"


#--- zsh-autosuggestions ----------------------------------------------
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^@' autosuggest-accept         # ctrl-space to accept suggestion
bindkey '^ ' autosuggest-accept         # these are equivalent, in iTerm anyway
bindkey '\e[24~' autosuggest-toggle     # F12 to tooggle


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

# Use fd and fzf to get the args to a command.
# Examples:
# f mv # To move files. You can write the destination after selecting the files.
# f 'echo Selected:'
# f 'echo Selected music:' --extention mp3
# fm rm # To rm files in current directory
f() {
    sels=( "${(@f)$(fd "${fd_default[@]}" "${@:2}"| fzf)}" )
    test -n "$sels" && print -z -- "$1 ${sels[@]:q:q}"
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() (
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} -p "${files[@]}"
)

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() (
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
)


# --- zsh-syntax-highlighting -----------------------------------------
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# enable non-default hightlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# highlight `rm -rf` in red:
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')


# --- nvm ------------------- -----------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
