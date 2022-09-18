# 補完(https://qiita.com/syui/items/ed2d36698a5cc314557d)
## 補完のハイライト
zstyle ':completion:*:default' menu select=2
## 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
## マッチ種別を別々に表示
zstyle ':completion:*' group-name ''
## セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
## 名前で色を付けるようにする
autoload colors
colors
## ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
## cheat-sheet
cheat-sheet () { zle -M "`cat $ZSH_DIR/cheat-sheet.conf`" }
zle -N cheat-sheet
bindkey "^[^h" cheat-sheet
git-cheat () { zle -M "`cat $ZSH_DIR/git-cheat.conf`" }
zle -N git-cheat
bindkey "^[^g" git-cheat