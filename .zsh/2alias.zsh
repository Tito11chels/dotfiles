alias tree="tree -N"
alias ls="lsd -A"
alias cat="bat"
if [ "$(uname)" = "Darwin" ]; then
    alias brew="env PATH=${PATH/\/Users\/$USER\/\.*env:/} brew"
fi
alias vim="nvim"
alias vi="nvim"

alias ,viz="nvim $ZSH_DIR"
alias ,viv="nvim ~/.config/nvim/lua"
