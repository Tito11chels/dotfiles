#!bin/bash

wget https://github.com/TakumiO/dotfiles/archive/master.tar.gz
tar -zxvf master.tar.gz
cd dotfiles-master

# install zsh neovim shelldon
# detect homebrew
if type brew > /dev/null 2>&1; then
  brew install zsh neovim shelldon
else
  echo "installing brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install zsh neovim shelldon
fi

ln -s .zsh/.zshrc ~/.zshrc
source ~/.zshrc

# install Packer.vim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# move nvim config dir
mkdir ~/.config
mv ~/nvim ~/.config/nvim
