# homebrew_installer.sh

# detect if homebrew is installed
# if not, install it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    # update homebrew
    brew update
fi