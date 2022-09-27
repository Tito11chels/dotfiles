#if you use macOS then 
if [uname -s = "Darwin"]; then
    # when on apple silicon
    if [umane -m = "arm64"]; then
        export PATH="/opt/homebrew/bin:$PATH"
        export PATH="/opt/homebrew/Celler:$PATH"
        export PATH="/opt/homebrew/opt/curl/bin:$PATH"
        export PATH="/opt/homebrew/sbin:$PATH"
    fi
    # when on intel
    if [uname -m = "x86_64"]; then
        export PATH="/usr/local/bin:$PATH"
        export PATH="/usr/local/Celler:$PATH"
        export PATH="/usr/local/opt/curl/bin:$PATH"
        export PATH="/usr/local/sbin:$PATH"
    fi
    export PATH="/usr/local/bin:$PATH"
fi
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"