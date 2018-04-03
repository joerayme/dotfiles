#!/bin/bash

set -eo pipefail

BREW_PACKAGES=(
    boot2docker
    ctags
    diff-so-fancy
    fzf
    git
    gpg
    hugo
    jq
    npm
    python
    python3
    rsync
    ssh-copy-id
    terminal-notifier
    the_silver_searcher
    tmux
    vim --with-lua
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
    java
    lastfm
    lastpass
    libreoffice
    moneydance
    rowanj-gitx
    spectacle
    spotify
    vagrant
    virtualbox
    font-source-sans-pro
    font-open-sans
)
PIP_PACKAGES=(
    beets
    fabric
)

if [[ ! $(which brew) ]]
then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

echo "Installing brew packages..."
brew install "${BREW_PACKAGES[@]}"

echo "Installing cask packages..."
brew install caskroom/cask/brew-cask
brew cask tap caskroom/fonts
brew cask install "${CASK_PACKAGES[@]}"

brew cleanup && brew cask cleanup

echo "Installing dotfiles..."
curl --fail --silent --show-error --location https://raw.githubusercontent.com/joerayme/dotfiles/master/dotfile-install.sh | /bin/bash

curl --fail --silent --show-error --location https://joeray.me/804EFECC.txt | gpg --import --armor

echo "Installing pips..."
pip install "${PIP_PACKAGES[@]}"

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Software update..."
sudo softwareupdate -ia
