#!/usr/bin/env bash

read -p "Are you sure you want to export dotfiles? It will override current home folders [y/N]: " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
	exit 1
fi

cp -r dotfiles/. "$HOME/"
