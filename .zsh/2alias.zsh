alias tree="tree -N"
alias ls="lsd -A"
alias ll="lsd -Al"
alias cat="bat"
if [ "$(uname)" = "Darwin" ]; then
    alias brew="env PATH=${PATH/\/Users\/$USER\/\.*env:/} brew"
fi

alias grep="rg --color=auto"

alias vi="nvim"
alias vim="nvim"

alias tx="
    ln -s ~/latexconfig/.textlintrc.json ./.textlintrc.json
    ln -s ~/latexconfig/latexindent.yaml ./latexindent.yaml
"
