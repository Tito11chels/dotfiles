export PATH="$(brew --prefix)/bin:$PATH"
export PATH="$(brew --prefix)/Celler:$PATH"
export PATH="$(brew --prefix)/opt/curl/bin:$PATH"
export PATH="$(brew --prefix)/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"


export PATH="$HOME/.cargo/bin:$PATH"

# set anyenv
export PATH="$HOME/.anyenv/envs:$PATH"

# if macOS, then set tlmgr
if [ "$(uname)" = 'Darwin' ]; then
    export PATH="/usr/local/texlive/2023/bin/universal-darwin/:$PATH"
else
    export PATH="/usr/local/texlive/2023/bin/x86_64-linux/:$PATH"
fi

export MANPATH="/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH"