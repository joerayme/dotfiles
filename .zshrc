# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
DOTFILES=$(cd "$(dirname $(readlink ${(%):-%N}))" && pwd)
ZSH_CUSTOM=$DOTFILES/zsh_custom/

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="josno"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias tmux="tmux -u"
alias json="jq '.' --color-output | less -R"

dockercl() {
    IMAGES=$(docker ps -aqf status=exited)
    if [[ ! -z $IMAGES ]]; then
        docker ps --all --filter=status=exited
        printf '%s\n' "$IMAGES" | while IFS= read -r i
        do
            read -q "REPLY?Do you want to delete $i? [yN] "
            echo
            [[ $REPLY == "y" || $REPLY == "Y" ]] && docker rm $i
        done
    else
        echo "No stopped images to clean up"
    fi
    docker images -q --filter dangling=true | xargs docker rmi
}

docker-usage() {
    boot2docker ssh "sudo du -hs /var/lib/docker/aufs/"
}

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Customize to your needs...
unamestr=`uname`
platform='unknown'
if [[ "$unamestr" == "Darwin" ]]; then
    platform="osx"
elif [[ "$unamestr" == "Linux" ]]; then
    platform="linux"
fi

if [[ "$platform" == "osx" ]]; then
    path=(/usr/local/sbin /usr/local/bin /usr/bin /bin /usr/sbin /sbin /usr/local/share/npm/bin)
else
    path=(/usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games /usr/local/games)
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vagrant brew fabric rbenv aws gpg-agent zsh-navigation-tools zsh_reload)

source $ZSH/oh-my-zsh.sh

# Docker
#which docker-machine >/dev/null 2>&1 && $(docker-machine env dev 2> /dev/null | grep -v "^#" | sed 's/"//g')

# pip should only run if there is a virtualenv currently activated
#export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

if [[ -d ~/gocode/bin ]]; then
    export GOPATH=~/gocode/
elif [[ -d ~/Documents/code/go/ ]]; then
    export GOPATH=~/Documents/code/go/
fi

if [[ -z $GOPATH ]]; then
    path+=($GOPATH/bin/)
fi

#. ~/.vim/bundle/powerline/powerline/bindings/zsh/powerline.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
