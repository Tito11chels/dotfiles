export ZSHCONF_DIR="$HOME/dotfiles/.zsh"

# Homebrewが見つかった場合だけshellenvを評価する。
# Apple Silicon / Intel Mac / Linuxbrew / カスタムprefixの順に検出し、
# Homebrew未導入の環境でもシェル起動時にエラーを出さない。
typeset brew_bin=""
if (( $+commands[brew] )); then
  brew_bin="${commands[brew]}"
else
  for candidate in \
    "${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/bin/brew}" \
    /opt/homebrew/bin/brew \
    /usr/local/bin/brew \
    /home/linuxbrew/.linuxbrew/bin/brew; do
    if [[ -n "$candidate" && -x "$candidate" ]]; then
      brew_bin="$candidate"
      break
    fi
  done
fi

if [[ -n "$brew_bin" ]]; then
  eval "$("$brew_bin" shellenv)"
fi
unset brew_bin candidate

# 他の設定ファイルを読み込む（1path.zsh は後で読み込むため除外）
if [ -d "$ZSHCONF_DIR" ]; then
  for file in "$ZSHCONF_DIR"/*.zsh; do
    [ "$(basename "$file")" = "1path.zsh" ] && continue
    [ -r "$file" ] && source "$file"
  done
fi

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
