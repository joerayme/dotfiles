# Setup fzf
# ---------
if [[ ! "$PATH" == *${HOMEBREW_PREFIX}/opt/fzf/bin* && -d ${HOMEBREW_PREFIX}/opt/fzf/bin ]]; then
  export PATH="$PATH:${HOMEBREW_PREFIX}/opt/fzf/bin"
fi
if [[ ! "$PATH" == *$HOME/.fzf/bin* && -d $HOME/.fzf/bin ]]; then
  export PATH="$PATH:$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* && -f ${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh ]] && source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null
[[ $- == *i* && -f $HOME/.fzf/shell/completion.zsh ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
[[ -f ${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh ]] && source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
[[ -f $HOME/.fzf/shell/completion.zsh ]] && source "$HOME/.fzf/shell/key-bindings.zsh"

