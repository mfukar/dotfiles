#!/usr/bin/env bash
# A script to soft-link everything necessary (and some things optional)
# to the CURRENT DIRECTORY.
#
# You can invoke it from ~ like so:
# git clone <this repo>
# ./dotfiles/link.sh

echo "Remember to install dependencies: exa"

# git(hub):
ln -s dotfiles/.gitconfig .gitconfig
# tmux:
ln -s dotfiles/tmux.conf .tmux.conf

# The below are mostly optional:
ln -s dotfiles/.bash_profile .bash_profile
ln -s dotfiles/.gdbinit .gdbinit
ln -s dotfiles/.screenrc .screenrc
ln -s dotfiles/.clang-format .clang-format

# oh-my-zsh:
cd dotfiles
git submodule update --init --recursive
cd ..
# zsh config:
ln -s dotfiles/.zshrc.local .zshrc.local
ln -s dotfiles/.zshrc .zshrc
ln -s dotfiles/oh-my-zsh .oh-my-zsh
# the zsh theme:
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
ln -s dotfiles/.p10k.zsh .p10k.zsh

ln -s vim-stuff .vim
ln -s vim-stuff/_vimrc .vimrc
