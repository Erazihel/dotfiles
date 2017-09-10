#!/bin/bash

echo Install in progress..

echo ZSH config..
ln -sf $(pwd)/.zshrc ~
echo Done!

echo Bullet Train Theme config..
ln -sf $(pwd)/themes/bullet-train.zsh-theme ~/.oh-my-zsh/themes
echo Done!

echo Vim..
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

ln -f -s $(pwd)/nvim/init.vim ~/.config/nvim/init.vim

nvim +PlugInstall +qa
echo Done!

echo Install successful 👌
echo Relaunch your terminal for the modifications to take effect
