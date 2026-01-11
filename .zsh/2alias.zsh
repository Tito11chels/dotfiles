alias ls="lsd -A"
alias ll="lsd -Al"
alias cat="bat"
if [ "$(uname)" = "Darwin" ]; then
    alias brew="env PATH=${PATH/\/Users\/$USER\/\.*env:/} brew"
fi

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
