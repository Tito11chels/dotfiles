export ZSHCONF_DIR="$HOME/dotfiles/.zsh"

# 他の設定ファイルを読み込む（1path.zsh は後で読み込むため除外）
if [ -d "$ZSHCONF_DIR" ]; then
  for file in "$ZSHCONF_DIR"/*.zsh; do
    [ "$(basename "$file")" = "1path.zsh" ] && continue
    [ -r "$file" ] && source "$file"
  done
fi

# OSごとの brew shellenv をまとめて初期化
case "$(uname)" in
  Darwin)
    eval "$(/opt/homebrew/bin/brew shellenv)"
    ;;
  *)
    # Linux/WSL は linuxbrew を使用
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    ;;
esac

# brew が存在するときに補完を設定
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
fi

# PATH の優先順位を修正するため 1path.zsh を最後に読み込む
if [ -r "$ZSHCONF_DIR/1path.zsh" ]; then
  source "$ZSHCONF_DIR/1path.zsh"
  hash -r
fi
