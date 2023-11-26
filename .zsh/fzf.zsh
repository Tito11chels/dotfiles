# Setup fzf
# ---------
if [[ ! "$PATH" == *$(brew --prefix)/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$(brew --prefix)/fzf/bin"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
