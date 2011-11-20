# dotfiles
Word.


## Installation

Install to `~/.dotfiles` and create symlinks:

    cd ~
    git clone git://github.com/ultranaut/dotfiles.git ~/.dotfiles
    ln -s ~/.vim ~/.dotfiles/_vim
    ln -s ~/.vimrc ~/.dotfiles/_vimrc

Switch to working directory and fetch submodules:

    cd ~/.dotfiles
    git submodule init
    git submodule update

The `git-submodule init` and `git-submodule update` can be combined:

    git submodule update --init


## Updating/upgrading submodules
Seems like more work than it's necessarily worth to install pathogen intself
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

