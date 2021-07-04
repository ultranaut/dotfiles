# dotfiles

This is my dotfiles repo. There are many like it, but this one is mine.

## Installation

Clone the repository and run the setup script:

```bash
git clone https://github.com/ultranaut/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.py
```

`setup.py` creates symlinks and fetches and initializes the submodules.

### /etc

Create symlinks to `/etc` files in appropriate locations

### zsh

Change login shell to zsh:

```bash
chsh -s /bin/zsh
```

and enter password when prompted.

### iTerm configuration

[Enable italics][1] in shell and Vim:

```bash
cd ~/.dotfiles
tic .terminfo/xterm-256color-italic.terminfo
```

and tell iTerm to use this `TERM` in Preferences > Profile > Terminal > Report Terminal Type

### Homebrew setup

[Install Homebrew][2] and install formulae from `Brewfile`

```bash
cd ~/.dotfiles
brew bundle install
```

### Sensible macOS defaults

When setting up a new Mac, you may want to set some sensible macOS defaults:

```bash
cd ~/.dotfiles
./.macos
```

## Updating/upgrading submodules

To create a submodule:

```bash
git submodule add http://github.com/tpope/foo a/submodule
```

To remove a submodule:

```bash
git submodule deinit -f -- a/submodule
rm -rf .git/modules/a/submodule
git rm -f a/submodule
```

To upgrade an individual submodule:

```bash
cd a/submodule
git pull origin master
```

To upgrade all submodules:

```bash
cd ~/.dotfiles
git submodule foreach git pull origin master
```

[1]: https://alexpearce.me/2014/05/italics-in-iterm2-vim-tmux/ "Italic fonts in iTerm2, tmux, and vim"
[2]: https://brew.sh/
