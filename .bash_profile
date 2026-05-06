if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
