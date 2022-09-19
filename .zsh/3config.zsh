# 変数の設定
export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export LANG=ja_JP.UTF-8
export HISTFILE=$ZSH_DIR/.zsh_history
export SHELDON_CONFIG_DIR=$HOME/dotfiles/.sheldon
export SHELDON_DATA_DIR=$HOME/dotfiles/.sheldon
export DOT_DIR="$HOME/dotfiles"

# 設定
bindkey -e
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_space
setopt auto_param_keys
disable r

# nodenv autoload
eval "$(nodenv init -)"
# rbenv autoload
eval "$(rbenv init -)"
# pyenv autoload
eval "$(pyenv init -)"
# sheldon autoload
eval "$(sheldon source)"
