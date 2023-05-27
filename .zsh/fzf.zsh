# Setup fzf
# ---------
if [[ ! "$PATH" == *$(brew --prefix)/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$(brew --prefix)/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(brew --prefix)/Cellar/fzf/0.40.0/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$(brew --prefix)/Cellar/fzf/$(fzf --version | sed 's/[^0-9.]*//g')/shell/key-bindings.zsh"

export FZF_DEFAULT_OPTS='--preview "bat --color=always --style=numbers --line-range :500 {}"'

# 関数を追加(https://qiita.com/kamykn/items/aa9920f07487559c0c7e)

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

fzf-z-search() {
    local res=$(z | sort -rn | cut -c 12- | fzf)
    if [ -n "$res" ]; then
        BUFFER+="cd $res"
        zle accept-line
    else
        return 1
    fi
}

zle -N fzf-z-search
bindkey '^f' fzf-z-search

# fd - cd to selected directory
# https://qiita.com/kamykn/items/aa9920f07487559c0c7e
fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}