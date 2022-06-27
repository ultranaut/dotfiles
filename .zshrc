#--- oh my zsh settings -----------------------------------------------
ZSH=$HOME/.oh-my-zsh                    # path to the oh-my-zsh config
ZSH_CUSTOM=$HOME/.custom/oh-my-zsh      # path to custom config files
ZSH_THEME="ultranoster"                 # theme to load.
DISABLE_AUTO_UPDATE="true"              # disable auto-update checks
plugins=(history-substring-search)  # plugins in ~/.oh-my-zsh/plugins/*
CASE_SENSITIVE="true"                   # use case-sensitive completion
ZSH_DISABLE_COMPFIX=true                # https://github.com/robbyrussell/oh-my-zsh/issues/6835#issuecomment-390216875
source $ZSH/oh-my-zsh.sh                # what it says

#--- my .zsh configuration --------------------------------------------
DOTZSH=$HOME/.zsh

#--- Aliases ----------------------------------------------------------
if [ -d $DOTZSH/aliases ]; then
  for file in $DOTZSH/aliases/*; do
    source "$file"
  done
fi

#--- Functions --------------------------------------------------------
if [ -d $DOTZSH/functions ]; then
  fpath+=$DOTZSH/functions
  autoload -U $DOTZSH/functions/*
fi

#--- add our bin dir and cwd to the path ------------------------------
PATH=$PATH:$HOME/bin:.

#--- use nvim/vim to view man pages -----------------------------------
if command -v nvim &>/dev/null; then
  export MANPAGER="nvim +Man!"
else
  export MANPAGER="vim -M +MANPAGER -"
fi

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


# --- rbenv -----------------------------------------------------------
# Load rbenv automatically by appending
# the following to ~/.zshrc:

eval "$(rbenv init -)"


# --- pip -------------------------------------------------------------
# pip should only run if there is a virtualenv currently activated
# to avoid inadvertently installing global packages
export PIP_REQUIRE_VIRTUALENV=true

# workaround virtualenv requirement to install global packages
gpip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

# --- pyenv -----------------------------------------------------------
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
