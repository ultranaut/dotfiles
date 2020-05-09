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

To add a plugin to the bundle directory:

    cd ~/.dotfiles
    git submodule add http://github.com/tpope/vim-foo.git .vim/bundle/foo
    git commit -m "Install foo.vim bundle as submodule"

To remove a submodule:

    git submodule deinit -f -- a/submodule
    rm -rf .git/modules/a/submodule
    git rm -f a/submodule

To upgrade an individual submodule:

    cd ~/.dotfiles/.vim/bundle/foo
    git pull origin master

To upgrade all submodules:

    cd ~/.dotfiles
    git submodule foreach git pull origin master

### Installing YouCompleteMe

Full instructions are at the YCM [Full Installation Guide](https://github.com/ycm-core/YouCompleteMe/wiki/Full-Installation-Guide), but the short version is:

  1) Install YCM and fetch all of it's dependencies

    git submodule add https://github.com/ycm-core/YouCompleteMe.git .vim/bundle/youcompleteme
    git submodule update --init --recursive

  2) Install `cmake` if necessary

    brew install cmake

  3) Compile the `ycm_core` library

    cd ~
    mkdir ycm_build && cd ycm_build
    cmake -G "Unix Makefiles" . ~/.vim/bundle/youcompleteme/third_party/ycmd/cpp
    cmake --build . --target ycm_core --config Release

  4) Install `watchdog` library

    cd ~/.vim/bundle/youcompleteme/third_party/ycmd/third_party/watchdog_deps/watchdog
    python setup.py build --build-base=build/3 --build-lib=build/lib3

  5) Build the `regex` module

    cd ~
    mkdir regex_build && cd regex_build
    cmake -G "Unix Makefiles" . ~/.vim/bundle/youcompleteme/third_party/ycmd/third_party/cregex
    cmake --build . --target _regex --config Release

  6) Set up language support

    cd ~/.vim/bundle/youcompleteme/third_party/ycmd
    npm install -g --prefix third_party/tsserver typescript

`ycm_build` and `regex_build` directories can be removed after installation.
