#!/bin/bash

set -eo pipefail

TMP_DIR=$(mktemp -t install)

BREW_PACKAGES=(
    boot2docker
    git
    jq
    npm
    python
    python3
    ssh-copy-id
    terminal-notifier
    the_silver_searcher
    tmux
    vim
    wget
    zsh
)
CASK_PACKAGES=(
    alfred
    calibre
    dash
    firefox
    google-chrome
    google-drive
    iterm2
    lastfm
    lastpass
    libreoffice
    rowanj-gitx
    spectacle
    spotify
    vagrant
    virtualbox
)
PIP_PACKAGES=(
    beets
    powerline-status
)

if [[ ! $(which brew) ]]
then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

echo "Installing brew packages..."
brew install ${BREW_PACKAGES[@]}

echo "Installing cask packages..."
brew install caskroom/cask/brew-cask
brew cask install ${CASK_PACKAGES[@]}

brew cleanup && brew cask cleanup

echo "Installing dotfiles..."
[[ ! -d ~/.dotfiles ]] && git clone git@github.com:joerayme/dotfiles.git ~/.dotfiles >/dev/null 2>&1
[[ ! -d ~/.oh-my-zsh ]] && git clone git@github.com:joerayme/oh-my-zsh.git ~/.oh-my-zsh >/dev/null 2>&1

DIR=$(pwd)
cd ~/.dotfiles
git submodule init && git submodule update
cd $DIR

for f in ~/.dotfiles/.*
do
    bn=$(basename $f)
    target=~/$bn
    if [[ $bn -ne "." && $bn -ne ".." && $bn -ne ".git" && $bn -ne ".gitmodules" ]]
    then
        if [[ ! -L $target && -e $target ]]
        then
            read -p "$target is a regular file, do you want to replace it? " yn
            case $yn in
                [Yy]* ) mv $target "${target}.bak" && ln -s $f $target;
            esac
        elif [[ ! -L $target ]]
        then
            read -p "Do you want to link $bn? " yn
            case $yn in
                [Yy]* ) ln -s $f $target;
            esac
        fi
    fi
done

vim +BundleInstall +qa

echo "Installing pips..."
pip install ${PIP_PACKAGES[@]}

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Software update..."
sudo softwareupdate -ia
