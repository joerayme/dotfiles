export PATH=$HOME/Documents/git/universal/cake_latest/cake/console:$HOME/local/node/bin:/usr/local/bin:/usr/local/sbin:/opt/local/apache2/bin:/opt/local/lib/postgresql82/bin:$PATH
export VISUAL=vim

alias apache2ctl='sudo /opt/local/apache2/bin/apachectl'
alias mysqlstart='sudo /opt/local/bin/mysqld_safe5 &'
alias mysqlstop='/opt/local/bin/mysqladmin5 -u root -p shutdown'
alias telmem='telnet localhost 11211'

export PS1='\u@\h:\w$(__git_ps1 " [%s]")\$ '

alias ls="ls -Gp"
export LSCOLORS=GxFxCxDxBxegedabagacad

if [ -f /opt/local/etc/bash_completion ]; then
	. /opt/local/etc/bash_completion
fi

. ~/.bashrc

##
# Your previous /Users/joeray/.bash_profile file was backed up as /Users/joeray/.bash_profile.macports-saved_2010-10-28_at_11:27:26
##

# MacPorts Installer addition on 2010-11-17_at_13:54:28: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2010-11-17_at_13:54:28: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.

export HISTSIZE=1000

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