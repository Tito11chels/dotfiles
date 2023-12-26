export ZSHCONF_DIR="$HOME/dotfiles/.zsh"
export BREW_PREFIX=$(brew --prefix)

# .zshがディレクトリで、読み取り、実行、が可能なとき
if [ -d $ZSHCONF_DIR ] && [ -r $ZSHCONF_DIR ] && [ -x $ZSHCONF_DIR ]; then
    # zshディレクトリより下にある、.zshファイルの分、繰り返す
    for file in ${ZSHCONF_DIR}/*.zsh; do
        # 読み取り可能ならば実行する
        [ -r $file ] && source $file
    done
fi

# if macOS, then read this
if [ "$(uname)" = 'Darwin' ]; then
    # Homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    if type brew &>/dev/null
        then
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

        autoload -Uz compinit
        compinit
    fi
fi
# configure Homebrew for wsl
if [ -n "$WSL_DISTRO_NAME" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    if type brew &>/dev/null
        then
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

        autoload -Uz compinit
        compinit
    fi
fi
# configure Homebrew for linux
if [ "$(uname)" = 'Linux' ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    if type brew &>/dev/null
        then
        FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

        autoload -Uz compinit
        compinit
    fi
fi

# if it's wsl then set vcxsrv
if [ -n "$WSL_DISTRO_NAME" ]; then
    export DISPLAY=`hostname`.mshome.net:0.0
fi
