# dotfiles
This is my dotfiles repo. There are many like it, but this one is mine.

## Installation

Clone the repository and run the setup script:

    git clone https://github.com/ultranaut/dotfiles.git ~/.dotfiles
    cd ~
    setup.py

`setup.py` creates symlinks and fetches and initializes the submodules.

Change login shell to zsh:

    chsh -s /bin/zsh

and enter password when prompted.

## Updating/upgrading submodules

To add a plugin to the bundle directory:

    cd ~/.dotfiles
    git submodule add http://github.com/tpope/vim-foo.git _vim/bundle/foo
    git commit -m "Install foo.vim bundle as submodule"

To upgrade an individual submodule:

    cd ~/.dotfiles/_vim/bundle/foo
    git pull origin master

To upgrade all submodules:

    cd ~/.dotfiles
    git submodule foreach git pull origin master

