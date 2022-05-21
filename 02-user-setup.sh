#!/usr/bin/env bash

# poetry
curl -sSL https://install.python-poetry.org | python3 -

# oh-my-zsh

## main instalation
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
## oh-my-zsh backs up current .zshrc, so we'll un-back-it
rm $HOME/.zshrc
mv $HOME/.zshrc.pre-oh-my-zsh $HOME/.zshrc

## change default shell
chsh -s $(which zsh)

## zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## pure theme
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

## forgit
git clone https://github.com/wfxr/forgit ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/forgit


# vim
## install vim-plug plugins. First time it runs it will auto-install vim-plug
vim -c "PlugInstall" -c "qa"
## finish ycm setup
python3 $HOME/.vim/plugged/YouCompleteMe/install.py --all 

# tmux
## install tpm package manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
bash ~/.tmux/plugins/tpm/scripts/install_plugins.sh

