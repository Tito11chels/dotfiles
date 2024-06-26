export PATH=$PATH:/usr/local/bin
export PATH="$(brew --prefix)/bin:$PATH"
export PATH="$(brew --prefix)/Celler:$PATH"
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"
export PATH="$(brew --prefix)/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

# set anyenv
export PATH="$HOME/.anyenv/envs:$PATH"

# if macOS, then set tlmgr
TEXLIVE_YEAR=2024
if [ "$(uname)" = 'Darwin' ]; then
  export PATH="/usr/local/texlive/$TEXLIVE_YEAR/bin/universal-darwin/:$PATH"
else
  export PATH="/usr/local/texlive/$TEXLIVE_YEAR/bin/x86_64-linux/:$PATH"
fi

export MANPATH="/usr/local/texlive/$TEXLIVE_YEAR/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/$TEXLIVE_YEAR/texmf-dist/doc/info:$INFOPATH"
