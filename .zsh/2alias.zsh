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
