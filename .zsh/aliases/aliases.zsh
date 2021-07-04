# general stuff

alias duh="sudo du -h -d 1"                   # don't need to know everything
alias srch="grep -rlE"                        # text search
alias ping='ping -c 4'                        # dos style
alias npmls='npm ls --depth=0'                # I rarely need all the extra crap

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
