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
  for file in $DOTZSH/functions/*; do
    source "$file"
  done
fi

#--- fzf --------------------------------------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#--- nvm --------------------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
