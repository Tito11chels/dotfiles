export PATH="/usr/local/bin:$(brew --prefix)/bin:$(brew --prefix)/sbin:$(brew --prefix)/opt/curl/bin:${PATH}"

# set ASDF
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# asdfのパスを最優先に設定
export PATH="$HOME/.asdf/shims:$PATH"
