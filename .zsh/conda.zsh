# if it's linux then set up homebrew
if [ -n "$LINUX_DISTRO_NAME" ]; then
# config homebrew
source $HOME/.profile
# fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('~/.pyenv/versions/miniconda3-latest/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "~/.pyenv/versions/miniconda3-latest/etc/profile.d/conda.sh" ]; then
        . "~/.pyenv/versions/miniconda3-latest/etc/profile.d/conda.sh"
    else
        export PATH="~/.pyenv/versions/miniconda3-latest/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<