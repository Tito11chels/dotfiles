#!bin/bash

wget https://github.com/TakumiO/dotfiles/archive/master.tar.gz
tar -zxvf master.tar.gz
cd dotfiles-master

# install essential packages
# detect homebrew
if type brew > /dev/null 2>&1; then
  brew install zsh neovim shelldon
else
  # detect OS
  if [ "$(uname)" == 'Darwin' ]; then
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install zsh neovim shelldon pandoc pyenv nodenv rbenv mactex-no-gui tex-live-utility
    # install anotheessential Casks
    brew install iterm2 google-chrome visual-studio-code google-japanese-ime min
  elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    echo "installing brew"
    sudo apt install build-essential curl file git
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install zsh neovim shelldon pandoc pyenv nodenv rbenv 
  # install texlive
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -zxvf install-tl-unx.tar.gz
  cd install-tl-* && sudo ./install-tl
  sudo /usr/local/texlive/????/bin/*/tlmgr path add
  fi
fi

ln -s .zsh/.zshrc ~/.zshrc
source ~/.zshrc

# install Packer.vim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# move nvim config dir
mkdir ~/.config
mv ~/nvim ~/.config/nvim

# move .latexmkrc
mv .latexmkrc ~/

# install miniconda via pyenv
pyenv install miniconda3-latest
# set miniconda3-latest as global
pyenv global miniconda3-latest
## install python packages
conda install jupyter numpy pandas matplotlib scipy