export PATH="/usr/local/bin:$(brew --prefix)/bin:$(brew --prefix)/sbin:$(brew --prefix)/opt/curl/bin:${PATH}"

# set anyenv
export PATH="$HOME/.anyenv/envs:${PATH}"

# if macOS, then set tlmgr
TEXLIVE_YEAR=2024
if [ "$(uname)" = 'Darwin' ]; then
  export PATH="/usr/local/texlive/$TEXLIVE_YEAR/bin/universal-darwin:/Library/TeX/texbin:${PATH}"
else
  export PATH="/usr/local/texlive/$TEXLIVE_YEAR/bin/x86_64-linux:${PATH}"
fi

export MANPATH="/usr/local/texlive/$TEXLIVE_YEAR/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/$TEXLIVE_YEAR/texmf-dist/doc/info:$INFOPATH"
# asdfのパスを最優先に設定
export PATH="$HOME/.asdf/shims:$PATH"
