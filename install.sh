#!/bin/bash

echo Install in progress..

echo Installing Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo Done!

echo Installing wget
brew install wget
echo Done!

echo Installing Rg
brew install ripgrep
echo Done!

echo Installing OhMyZsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo ZSH..
ln -sf $(pwd)/.zshrc ~
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
echo Done!

echo Bullet Train Theme config..
ln -sf $(pwd)/themes/bullet-train.zsh-theme ~/.oh-my-zsh/themes
echo Done!

echo Vim..
brew install neovim

mkdir -p ~/.config/nvim

if [ ! -d ~/.fzf ]; then
  git clone https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi

if [ ! -f ~/.config/nvim/autoload/plug.vim ]; then
  curl \
    -fLo ~/.config/nvim/autoload/plug.vim \
    --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

ln -sf $(pwd)/nvim/init.vim ~/.config/nvim/init.vim

nvim +PlugInstall +qa
echo Done!

echo Installing Autojump..
git clone git://github.com/wting/autojump.git
cd autojump
./install.py
cd ..
rm -rf autojump
echo Done!

echo Installing fonts..
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
echo Done!

echo Installing Node, NPM and Yarn..
brew install yarn
echo Done!

echo Installing NVM..
brew install nvm
echo Done!

echo Install successful 👌
echo Relaunch your terminal for the modifications to take effect
