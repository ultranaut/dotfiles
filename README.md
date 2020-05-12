# dotfiles
This is my dotfiles repo. There are many like it, but this one is mine.

## Installation

Clone the repository and run the setup script:

    git clone https://github.com/ultranaut/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    ./setup.py

`setup.py` creates symlinks and fetches and initializes the submodules.

Change login shell to zsh:

    chsh -s /bin/zsh

and enter password when prompted.

## Updating/upgrading submodules

To create a submodule:

    git submodule add http://github.com/tpope/foo a/submodule

To remove a submodule:

    git submodule deinit -f -- a/submodule
    rm -rf .git/modules/a/submodule
    git rm -f a/submodule

To upgrade an individual submodule:

    cd a/submodule
    git pull origin master

To upgrade all submodules:

    cd ~/.dotfiles
    git submodule foreach git pull origin master
