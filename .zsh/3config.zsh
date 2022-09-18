# 変数の設定
export LDFLAGS="-L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="-I/opt/homebrew/opt/curl/include"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export HOMEBREW_GITHUB_API_TOKEN=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
export LANG=ja_JP.UTF-8
export HISTFILE=$ZSH_DIR/.zsh_history


# 設定
bindkey -e
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_space
setopt auto_param_keys
disable r

# nodenv autoload
eval "$(nodenv init -)"
# rbenv autoload
eval "$(rbenv init -)"
# pyenv autoload
eval "$(pyenv init -)"
# sheldon autoload
eval "$(sheldon source)"

# zsh-packages-setup
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source $HOME/.sheldon/repos/github.com/romkatv/powerlevel10k/powerlevel10k.zsh-theme
# zsh-highlighting
source $HOME/.sheldon/repos/github.com/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# zsh-autosuggestions
source $HOME/.sheldon/repos/github.com/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh