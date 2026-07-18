# 変数の設定
export ZSH_DIR="$HOME/dotfiles/.zsh"
export DOT_DIR="$HOME/dotfiles"
export BAT_CONFIG_PATH="$DOT_DIR/bat/bat.conf"
export LANG=ja_JP.UTF-8
export HISTFILE="$ZSH_DIR/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=50000
export SHELDON_CONFIG_DIR="$HOME/dotfiles/.sheldon"
export SHELDON_DATA_DIR="$HOME/dotfiles/.sheldon"

# 自己更新するcask（auto_updates true）はbrew upgradeの対象から除外する。
export HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS=1

# install / upgrade / reinstallでHomebrew本体の確認プロンプトを省略する。
export HOMEBREW_NO_ASK=1

# Homebrew があればプレフィックスを一度だけ取得し、各種フラグに利用
if (( $+commands[brew] )); then
  HOMEBREW_PREFIX="$(brew --prefix 2>/dev/null)"

  if [[ -n "$HOMEBREW_PREFIX" ]]; then
    export HOMEBREW_PREFIX

    # keg-only formulaを含めたビルド系フラグは、実在するディレクトリだけ追加する。
    for libdir in \
      "$HOMEBREW_PREFIX/opt/curl/lib" \
      "$HOMEBREW_PREFIX/opt/ffmpeg-full/lib" \
      "$HOMEBREW_PREFIX/opt/imagemagick-full/lib"; do
      [[ -d "$libdir" ]] || continue
      case " ${LDFLAGS-} " in
        *" -L$libdir "*) ;;
        *) LDFLAGS="-L$libdir${LDFLAGS:+ $LDFLAGS}" ;;
      esac
    done

    for incdir in \
      "$HOMEBREW_PREFIX/opt/curl/include" \
      "$HOMEBREW_PREFIX/opt/ffmpeg-full/include" \
      "$HOMEBREW_PREFIX/opt/imagemagick-full/include"; do
      [[ -d "$incdir" ]] || continue
      case " ${CPPFLAGS-} " in
        *" -I$incdir "*) ;;
        *) CPPFLAGS="-I$incdir${CPPFLAGS:+ $CPPFLAGS}" ;;
      esac
    done

    for pcdir in \
      "$HOMEBREW_PREFIX/opt/ffmpeg-full/lib/pkgconfig" \
      "$HOMEBREW_PREFIX/opt/imagemagick-full/lib/pkgconfig"; do
      [[ -d "$pcdir" ]] || continue
      case ":${PKG_CONFIG_PATH-}:" in
        *":$pcdir:"*) ;;
        *) PKG_CONFIG_PATH="$pcdir${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}" ;;
      esac
    done

    export LDFLAGS
    export CPPFLAGS
    export PKG_CONFIG_PATH
  fi

  # openssl@3が導入済みの場合だけRubyビルド用の設定を有効化する。
  if brew list --formula openssl@3 >/dev/null 2>&1; then
    OPENSSL_PREFIX="$(brew --prefix openssl@3 2>/dev/null)"
    [[ -n "$OPENSSL_PREFIX" ]] && export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_PREFIX"
  fi
fi

# zsh のオプション
bindkey -e
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_space
setopt auto_param_keys

# 履歴関連のおすすめオプション
setopt hist_ignore_all_dups  # 重複履歴を保存しない
setopt hist_save_no_dups      # 重複履歴を保存しない
setopt hist_expire_dups_first # 履歴上限時は重複から削除する
setopt hist_reduce_blanks     # 連続スペースをまとめる
setopt inc_append_history    # コマンドを即座に履歴ファイルへ書き込む
setopt share_history         # 複数のシェル間で履歴を共有する

disable r  # 'r' 内蔵コマンドを無効化

# Sheldon autoload
if (( $+commands[sheldon] )); then
  eval "$(sheldon source)"
fi

# bat を使った man ページ表示
if (( $+commands[bat] )); then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export BAT_PAGER="less -FRX"
else
  export MANPAGER="${MANPAGER:-less -FRX}"
fi

# Perl local::lib を有効化
if (( $+commands[perl] )) && [[ -d "$HOME/perl5/lib/perl5" ]] \
  && perl -I"$HOME/perl5/lib/perl5" -Mlocal::lib -e 1 >/dev/null 2>&1; then
  eval "$(perl -I"$HOME/perl5/lib/perl5" -Mlocal::lib)"
fi

# ここでは PATH の編集は行わず、1path.zsh 側に任せる


# その他の設定ファイルを読み込む
CLICOLOR=1 # カラフルな出力を有効化
export CLICOLOR

# ユーザーが追加したzsh-functionsを読み込む
export ZSH_FUNCTIONS_DIR="$ZSH_DIR/functions"
export FPATH="$ZSH_FUNCTIONS_DIR:$FPATH"
autoload -Uz setup-editor-settings
