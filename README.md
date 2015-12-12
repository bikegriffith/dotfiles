# dotfiles

> My configuration for a Linux or OSX workstation

## New Mac Setup

```


# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install cask

# Apps
brew install vim
brew cask install google-chrome
brew cask install iterm2
brew cask install sublime-text

# Config
mkdir ~/src && cd ~/src
git clone https://github.com/bikegriffith/dotfiles.git
cd dotfiles
cp .bash* ~/
ln -s ~/.bashrc ~/.bash_profile
mkdir ~/Library/KeyBindings && cp Library/DefaultKeyBinding.dict ~/Library/KeyBindings/
cp -r .vim* ~/
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
```
