export ZSHCONF_DIR="$HOME/dotfiles/.zsh"

# .zshがディレクトリで、読み取り、実行、が可能なとき
if [ -d $ZSHCONF_DIR ] && [ -r $ZSHCONF_DIR ] && [ -x $ZSHCONF_DIR ]; then
    # zshディレクトリより下にある、.zshファイルの分、繰り返す
    for file in ${ZSHCONF_DIR}/*.zsh; do
        # 読み取り可能ならば実行する
        [ -r $file ] && source $file
    done
fi

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    autoload -Uz compinit
    compinit -d $HOME/dotfiles/.zsh/.zcompdump
fi

# if it's wsl then set vcxsrv
if [ -n "$WSL_DISTRO_NAME" ]; then
    export DISPLAY=`hostname`.mshome.net:0.0
fi

# setting for fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
