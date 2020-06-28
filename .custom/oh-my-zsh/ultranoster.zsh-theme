# vim:ft=zsh ts=2 sw=2 sts=2
#
# An increasingly tweaked version of agnoster's theme:
#
#   agnoster's Theme - https://gist.github.com/3712874
#   A Powerline-inspired theme for ZSH
#

function battery_charge {
    echo `~/bin/batcharge.py` 2>/dev/null
}

### Some custom colors
CHERRY=52
GREENER=142
EGGSHELL=223
CHARCOAL=234


### Segment drawing
CURRENT_BG='NONE'
SEGMENT_SEPARATOR='⮀'     # U+25B6

# A few utility functions to make it easy and re-usable to draw segmented prompts

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
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
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$user@%m"
  fi
}

# If shell is running inside vim process, show in prompt
prompt_vim() {
  local vim=`env | grep VIMRUNTIME`

  if [[ ! -z $vim ]]; then
    prompt_segment red ${EGGSHELL} "{vim}"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    ZSH_THEME_GIT_PROMPT_DIRTY='±'
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow ${CHARCOAL}
    else
      prompt_segment ${GREENER} ${CHARCOAL}
    fi
    echo -n "${ref/refs\/heads\//⭠ }$dirty"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment ${CHERRY} ${EGGSHELL} '%~'
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

# Prompt character
prompt_char() {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  echo '$'
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  #prompt_context
  prompt_vim
  prompt_git
  prompt_dir
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt)
 $(prompt_char) '

RPROMPT='$(battery_charge)'
