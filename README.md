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
    ln -s ~/.dotfiles/_jshintrc .jshintrc
    ln -s ~/.dotfiles/bin bin
    ln -s ~/.dotfiles/_gitconfig .gitconfig
    ln -s ~/.dotfiles/_gitignore_global .gitignore_global
    ln -s ~/.dotfiles/_custom .custom

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

