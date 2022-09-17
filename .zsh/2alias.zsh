alias tree="tree -N"
alias ls="lsd -a"
alias cat="bat"
if [ "$(uname)" = "Darwin" ]; then
    alias brew="env PATH=${PATH/\/Users\/$USER\/\.*env:/} brew"
fi