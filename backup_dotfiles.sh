#!/usr/bin/env bash

# various dotfiles
rm -rf dotfiles
mkdir dotfiles
cp "$HOME/.gitconfig" dotfiles/
cp "$HOME/.tmux.conf" dotfiles/
cp "$HOME/.vimrc" dotfiles/
cp "$HOME/.zshrc" dotfiles/
