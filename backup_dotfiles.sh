#!/usr/bin/env bash

# various dotfiles
rm -rf dotfiles
mkdir dotfiles
cp "$HOME/.gitconfig" dotfiles/
cp "$HOME/.tmux.conf" dotfiles/
cp "$HOME/.vimrc" dotfiles/
cp "$HOME/.zshrc" dotfiles/
cp -r "$HOME/.i3/" dotfiles/

mkdir dotfiles/.config
cp -r "$HOME/.config/alacritty" dotfiles/.config
