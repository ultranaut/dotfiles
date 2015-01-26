# dotfiles
Word.


## Installation

Install to `~/.dotfiles` and run `setup.py`:

    cd ~
    git clone https://github.com/ultranaut/dotfiles.git ~/.dotfiles
    ~/.dotfiles/setup.py

Switch to working directory and fetch submodules:

    cd ~/.dotfiles
    git submodule init
    git submodule update

The `git-submodule init` and `git-submodule update` can be combined:

    git submodule update --init

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

