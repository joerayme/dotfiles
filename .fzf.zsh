# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* && -d /usr/local/opt/fzf/bin ]]; then
  export PATH="$PATH:/usr/local/opt/fzf/bin"
fi
if [[ ! "$PATH" == *$HOME/.fzf/bin* && -d $HOME/.fzf/bin ]]; then
  export PATH="$PATH:$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* && -f /usr/local/opt/fzf/shell/completion.zsh ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
[[ $- == *i* && -f $HOME/.fzf/shell/completion.zsh ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
[[ -f /usr/local/opt/fzf/shell/completion.zsh ]] && source "/usr/local/opt/fzf/shell/key-bindings.zsh"
[[ -f $HOME/.fzf/shell/completion.zsh ]] && source "$HOME/.fzf/shell/key-bindings.zsh"

