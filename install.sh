#!/bin/bash

echo Install in progress..

echo ZSH config..
ln -sf $(pwd)/.zshrc ~
echo Done !

echo Bullet Train Theme config..
ln -sf $(pwd)/themes/bullet-train.zsh-theme ~/.oh-my-zsh/themes
echo Done !

echo Install successful 👌
echo Relaunch your terminal for the modifications to take effect
