<<<<<<< HEAD
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
=======
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/Celler:$PATH"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

<<<<<<< HEAD
>>>>>>> 14f9c25 (改良失敗 修正)
=======
export PATH="$HOME/.cargo/bin:$PATH"
>>>>>>> 61b1380 (add wezterm)
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.nodenv/shims:$PATH"