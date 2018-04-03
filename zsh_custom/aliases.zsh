alias textcert="openssl x509 -text -noout"

alias cu="cd \$(git rev-parse --show-toplevel)"

function fe() {
    for dir in *;
    do
        if [ -d $dir ];
        then
            echo "==== $dir ===="
            pushd $dir >/dev/null 2>&1
            echo
            $@
            echo
            popd >/dev/null 2>&1
        fi
    done
}

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

function gfb() {
    local branchname=$(git rev-parse --abbrev-ref HEAD)
    if [[ ! $branchname =~ '^feedback' ]]
    then
        echo "Sure you want to push to a non-feedback branch ${branchname}?"
        return 1
    fi
    git push --set-upstream origin $branchname || return 1
    git lab mr || return 1
    local dir="$(pwd)"
    cd ..
    mv ${dir}{,-${1:-feedback}}
}

alias t2="tree -L 2"

alias gpa="for dir in \$(find . -name '.git'); do pushd \${dir%/*} && pwd && git co master && git pull; popd; done"

[[ -d ~/.dotfiles ]] && alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'