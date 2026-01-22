# 変数の設定
export ZSH_DIR="$HOME/dotfiles/.zsh"
export DOT_DIR="$HOME/dotfiles"
export BAT_CONFIG_PATH="$DOT_DIR/bat/bat.conf"
export LANG=ja_JP.UTF-8
export HISTFILE="$ZSH_DIR/.zsh_history"
export SHELDON_CONFIG_DIR="$HOME/dotfiles/.sheldon"
export SHELDON_DATA_DIR="$HOME/dotfiles/.sheldon"

# Homebrew があればプレフィックスを一度だけ取得し、各種フラグに利用
if command -v brew >/dev/null 2>&1; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  OPENSSL_PREFIX="$(brew --prefix openssl@3)"

  export LDFLAGS="-L$HOMEBREW_PREFIX/opt/curl/lib"
  export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/curl/include"
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_PREFIX"
fi

# zsh のオプション
bindkey -e
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_space
setopt auto_param_keys

# 履歴関連のおすすめオプション
setopt hist_ignore_all_dups  # 重複履歴を保存しない
setopt inc_append_history    # コマンドを即座に履歴ファイルへ書き込む
setopt share_history         # 複数のシェル間で履歴を共有する

disable r  # 'r' 内蔵コマンドを無効化

# Sheldon autoload
eval "$(sheldon source)"

# bat を使った man ページ表示
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_PAGER="less -FRX"

# Perl local::lib を有効化
eval "$(perl -I"$HOME/perl5/lib/perl5" -Mlocal::lib)"

# ここでは PATH の編集は行わず、1path.zsh 側に任せる


# その他の設定ファイルを読み込む
CLICOLOR=1 # カラフルな出力を有効化
export CLICOLOR
