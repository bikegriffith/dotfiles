# dotfiles

> My configuration for a Linux or OSX workstation


NOTE: You're probably better off looking at something like
https://github.com/nicolashery/mac-dev-setup, but this might have a few other
tricks.

## New Mac Setup

```
# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install cask

# Apps and Dev Tools
brew install node docker macvim go
brew cask install iterm2
brew cask install sublime-text
brew cask install skitch
brew cask install slack
brew cask install google-chrome
brew cask install spotify
brew cask install sketch
brew cask install bitwarden
brew cask install firefox

# Config
mkdir ~/src && cd ~/src
git clone https://github.com/bikegriffith/dotfiles.git
cd dotfiles
cp .bash* ~/
ln -s ~/.bashrc ~/.bash_profile
cp -r .vim* ~/
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
mkdir ~/Library/KeyBindings && cp Library/DefaultKeyBinding.dict ~/Library/KeyBindings/
defaults write NSGlobalDomain KeyRepeat -int 0

# Git setup
git config --global --edit
git config --global push.default matching

echo "Now, make sure you generate a SSH key and add it to github."
echo "See: https://help.github.com/articles/generating-ssh-keys/"
```
