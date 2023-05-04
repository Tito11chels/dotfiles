# 変数の設定
export ZSH_DIR="$HOME/dotfiles/.zsh"
export LDFLAGS="-L$(brew --prefix)/opt/curl/lib"
export CPPFLAGS="-I$(brew --prefix)/opt/curl/include"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export LANG=ja_JP.UTF-8
export HISTFILE="$ZSH_DIR/.zsh_history"
export SHELDON_CONFIG_DIR="$HOME/dotfiles/.sheldon"
export SHELDON_DATA_DIR="$HOME/dotfiles/.sheldon"
export DOT_DIR="$HOME/dotfiles"
export BAT_CONFIG_PATH="$HOME/dotfiles/bat/bat.conf"

# 設定
bindkey -e
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_space
setopt auto_param_keys
disable r

# set **env
eval "$(anyenv init -)"
## set pyenv
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# sheldon autoload
eval "$(sheldon source)"

# set man pager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_PAGER="less -RF"