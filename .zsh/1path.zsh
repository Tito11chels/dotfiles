# PATH setup (order matters): asdf > Homebrew > system
# Idempotent: safe to source multiple times without growing PATH.

# zsh-only implementation (this file is intended to be sourced by zsh)
if [[ -n "${ZSH_VERSION-}" ]]; then
  # Use zsh's `path` array and keep entries unique (first occurrence wins)
  typeset -U path PATH

  # Build PATH in the desired priority order.
  # - asdf shims first
  # - Homebrew next (including opt/curl)
  # - user/rust tooling
  # - finally whatever PATH already had (system paths, etc.)
  path=(
    "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /opt/homebrew/opt/curl/bin
    /usr/local/bin
    "$HOME/bin"
    "$HOME/.cargo/bin"
    /opt/homebrew/opt/rustup/bin
    $path
  )

  export PATH
else
  # Fallback for non-zsh shells (best-effort, may not be fully idempotent)
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/curl/bin:/usr/local/bin:$HOME/bin:$HOME/.cargo/bin:/opt/homebrew/opt/rustup/bin:$PATH"
fi
