#!/bin/bash

set -eo pipefail

BREW_PACKAGES=(
    diff-so-fancy
    fzf
    git
    gnu-sed
    gpg
    hugo
    jq
    npm
    python
    python3
    ripgrep
    rsync
    terminal-notifier
    tig
    tmux
    vim --with-lua
    wget
    zsh
)

if [[ ! $(which brew) ]]
then
    echo "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

echo "Installing brew packages..."
brew install "${BREW_PACKAGES[@]}"

brew cleanup

echo "Installing dotfiles..."
curl --fail --silent --show-error --location https://raw.githubusercontent.com/joerayme/dotfiles/master/dotfile-install.sh | /bin/bash

curl --fail --silent --show-error --location https://joeray.me/804EFECC.txt | gpg --import --armor

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2

# Disable "natural" scroll
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "Software update..."
sudo softwareupdate -ia
