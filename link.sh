#!/usr/bin/env bash
# A script to soft-link everything necessary (and some things optional)
# to the CURRENT DIRECTORY.
#
# You can invoke it from ~ like so:
# git clone <this repo>
# ./dotfiles/link.sh
#
# Soft-link all the .bashrc-related stuff:
for i in dotfiles/.bashrc.*; do ln -s $i ${i##dotfiles/} ; done
ln -s dotfiles/.bashrc .bashrc

# Used by .bashrc:
ln -s dotfiles/.inputrc .inputrc

# git(hub):
ln -s dotfiles/.gitconfig .gitconfig

# The below are mostly optional:
ln -s dotfiles/.bash_profile .bash_profile
ln -s dotfiles/.gdbinit .gdbinit
ln -s dotfiles/.screenrc .screenrc
ln -s dotfiles/.clang-format .clang-format
ln -s dotfiles/.ipython .ipython
ln -s dotfiles/.pythonrc .pythonrc

# zsh config:
ln -s dotfiles/.zshrc .zshrc

