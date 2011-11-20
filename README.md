# dotfiles
Word.


## Installation

Install to `~/.dotfiles` and create symlinks:

    cd ~
    git clone git://github.com/ultranaut/dotfiles.git ~/.dotfiles
    ln -s ~/.dotfiles/_vim .vim
    ln -s ~/.dotfiles/_vimrc .vimrc
    ln -s ~/.dotfiles/_oh-my-zsh .oh-my-zsh
    ln -s ~/.dotfiles/_zshrc .zshrc
    ln -s ~/.dotfiles/bin bin

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

Seems like more work than it's necessarily worth to install pathogen itself
as a submodule, so you need to "manually" fetch newer versions:
   
    curl -so ~/.dotfiles/_vim/autoload/pathogen.vim \
        https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim 

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

