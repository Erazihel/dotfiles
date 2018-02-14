#!/bin/bash

echo Install in progress..

echo ZSH config..
ln -sf $(pwd)/.zshrc ~
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
echo Done!

echo Bullet Train Theme config..
ln -sf $(pwd)/themes/bullet-train.zsh-theme ~/.oh-my-zsh/themes
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
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
