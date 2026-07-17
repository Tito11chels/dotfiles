# PATH setup (order matters): asdf > Homebrew > system
# Idempotent: safe to source multiple times without growing PATH.

# zsh-only implementation (this file is intended to be sourced by zsh)
if [[ -n "${ZSH_VERSION-}" ]]; then
  # Use zsh's `path` array and keep entries unique (first occurrence wins)
  typeset -U path PATH
  typeset brew_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}"
  typeset -a original_path requested_path

  original_path=("${path[@]}")
  requested_path=(
    "${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
    "$brew_prefix/opt/imagemagick-full/bin"
    "$brew_prefix/opt/ffmpeg-full/bin"
    "$brew_prefix/bin"
    "$brew_prefix/sbin"
    "$brew_prefix/opt/curl/bin"
    /usr/local/bin
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
    "$brew_prefix/opt/rustup/bin"
  )

  # Build PATH in the desired priority order.
  # - asdf shims first
  # - Homebrew next (including opt/curl)
  # - user/rust tooling
  # - finally whatever PATH already had (system paths, etc.)
  path=()
  for dir in "${requested_path[@]}" "${original_path[@]}"; do
    [[ -d "$dir" ]] && path+=("$dir")
  done

  export PATH
  unset brew_prefix original_path requested_path dir
else
  # Fallback for non-zsh shells (best-effort, may not be fully idempotent)
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:${HOMEBREW_PREFIX:-/opt/homebrew}/opt/imagemagick-full/bin:${HOMEBREW_PREFIX:-/opt/homebrew}/opt/ffmpeg-full/bin:${HOMEBREW_PREFIX:-/opt/homebrew}/bin:${HOMEBREW_PREFIX:-/opt/homebrew}/sbin:${HOMEBREW_PREFIX:-/opt/homebrew}/opt/curl/bin:/usr/local/bin:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:${HOMEBREW_PREFIX:-/opt/homebrew}/opt/rustup/bin:$PATH"
fi
