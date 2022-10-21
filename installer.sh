# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cd ~ 
mv dotfiles-* dotfiles

# make symbolic link to .zshrc
ln -s ~/dotfiles/.zshrc ~/.zshrc

cd ~/dotfiles
# install apps with homebrew
brew bundle

# install zsh plugins
sheldon source

# move .config files to home directory
cp -r .config ~/

# install texlive
## download texlive installer
echo -n downloading texlive installer...
curl -OL http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
echo -n done.
echo -n archiving texlive installer...
tar xvf install-tl-unx.tar.gz
echo -n done.
echo -n installing texlive...
cd install-tl-2*
sudo ./install-tl -no-gui -repository http://mirror.ctan.org/systems/texlive/tlnet/
## add texlive to path
echo -n "what is it todays year? Input str: (e.g. 2022)"
read year
echo -n "today is in $year"
sudo /usr/local/texlive/$year/bin/*/tlmgr path add
## update texlive
sudo tlmgr update --self --all
cd && cd dotfiles
echo -n all accomplished.

echo -n "next up, you need configure your git and do some manual work."
echo -n "you shoud do change your shell to zsh and do 'conda init zsh' and create 'dotfiles/.zsh/conda.zsh' file."