# Setup fzf
# ---------
if [[ ! "$PATH" == *$(brew --prefix)/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$(brew --prefix)/fzf/bin"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

# fzfの基本設定
export FZF_DEFAULT_OPTS="
  --height 40%
  --reverse
  --border
  --color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7
  --color=fg+:#c0caf5,bg+:#292e42,hl+:#7dcfff
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a
"
