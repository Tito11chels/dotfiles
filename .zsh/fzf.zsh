# Setup fzf
# ---------
if [[ ! "$PATH" == *$(brew --prefix)/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$(brew --prefix)/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(brew --prefix)/Cellar/fzf/0.39.0/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$(brew --prefix)/Cellar/fzf/0.39.0/shell/key-bindings.zsh"

export FZF_DEFAULT_OPTS='--preview "bat --color=always --style=numbers --line-range :500 {}"'