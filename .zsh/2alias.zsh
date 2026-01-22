alias ls="lsd -A"
alias ll="lsd -Al"
alias cat="bat"

# neovimがインストールされている場合はnvimを優先
if command -v nvim >/dev/null 2>&1; then
    alias vim="nvim"
fi

alias grep="rg --color=auto"

alias tx="
    cp ~/latexconfig/.textlintrc.json ./.textlintrc.json
    cp ~/latexconfig/latexindent.yaml ./latexindent.yaml
"

alias tt="tree -N ."
alias nv="nvim ."

# # Homebrew 実行時に pyenv/anyenv/asdf などの shims を PATH から一時的に除外するエイリアス
# alias brew="env PATH=${PATH/\/Users\/$USER\/\.*env:/} brew"

# ここから便利エイリアスの例（用途に応じて追加）
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

mkcd() { mkdir -p ${1} && cd ${1}; }
alias mkcd=mkcd

alias brewup='brew update && brew upgrade && brew cleanup'
