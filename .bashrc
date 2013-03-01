# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
export VISUAL=vim
export LSCOLORS=GxFxCxDxBxegedabagacad

if [ -d $HOME/local/node/bin ]
then
    export PATH=$HOME/local/node/bin:$PATH
fi

if [ -d /opt/local/ ]
then
    export PATH=/opt/local/bin:/opt/local/apache2/bin:/opt/local/lib/postgresql82/bin:$PATH
    export MANPATH=/opt/local/share/man:$MANPATH
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
export HISTSIZE=1000

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
color_prompt=yes

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(command -v __git_ps1 >/dev/null && __git_ps1 " [%s]")\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
elif [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
fi

if [ -f /opt/local/share/git-core/git-prompt.sh ]; then
    . /opt/local/share/git-core/git-prompt.sh
fi

if [ -d $HOME/.rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

if [ -d $HOME/Documents/git/mainline/bin ]; then
    export PATH="$PATH:$HOME/Documents/git/mainline/bin"
fi

function rmb {
    current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [ "$current_branch" != "master" ]; then
        echo "WARNING: You are on branch $current_branch, NOT master."
    fi
        echo "Fetching merged branches..."
    for r in $(git remote);
    do
        git remote prune $r
        remote_branches=$(git branch -r --merged | grep "^ *$r\/" | grep -v '/\(master\|develop\)$' | grep -v "/$current_branch$")
        if [ -z "$remote_branches" ]; then
            echo "No existing branches have been merged into $current_branch."
        else
            echo "This will remove the following branches:"
            echo "$remote_branches"
            read -p "Continue? (y/n): " -n 1 choice
            echo
            if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
                # Remove remote branches
                git push $r `git branch -r --merged | grep "^ *$r\/" | grep -v '/\(master\|develop\)$' | grep -v "/$current_branch$" | sed "s/$r\//:/g" | tr -d '\n'`
            fi
        fi
    done
    local_branches=$(git branch --merged | grep -v '\(master\|develop\)$' | grep -v "$current_branch$")
    if [ -z "$local_branches" ]; then
        echo "No existing branches have been merged into $current_branch."
    else
        echo "This will remove the following branches:"
        if [ -n "$local_branches" ]; then
            echo "$local_branches"
        fi
        read -p "Continue? (y/n): " -n 1 choice
        echo
        if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
            # Remove local branches
            git branch -d `git branch --merged | grep -v '\(master\|develop\)$' | grep -v "$current_branch$" | sed 's/origin\///g' | tr -d '\n'`
        else
            echo "No branches removed."
        fi
    fi
}

function bundle {
    if [ -f scripts/deploy/build.sh ]
    then
        ./scripts/deploy/build.sh
    elif [ -f deploy/bundle.php ]
    then
        php deploy/bundle.php
    elif [ -f build/bundle.sh ]
    then
        ./build/bundle.sh
    fi
}
