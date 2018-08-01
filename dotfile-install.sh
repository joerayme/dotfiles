#!/bin/bash

[[ ! -d $HOME/.dotfiles ]] && git clone --bare https://github.com/joerayme/dotfiles.git $HOME/.dotfiles
function config {
   /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" $@
}
mkdir -p .config-backup

if config checkout; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | grep -E "\\s+\\." | awk '{print $1}' | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
config submodule init && config submodule update

[[ ! -d $HOME/.oh-my-zsh ]] && git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh >/dev/null 2>&1

vim +PluginClean +PluginInstall +qa