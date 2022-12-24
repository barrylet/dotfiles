#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, use sudo "$0" instead" 1>&2
   exit 1
fi

if [ "$#" -ne 1 ]; then
    echo "Missing user argument"
    exit 1
fi

echo $1
exit 0

# main packages to add

## update mirrorlist
rankmirrors -f 30

## install packages
pacman_cmd='pacman --noconfirm -S '

$pacman_cmd firefox
$pacman_cmd git
$pacman_cmd gvim
$pacman_cmd vim-spell-en
$pacman_cmd vim-spell-es
$pacman_cmd powerline
$pacman_cmd powerline-vim
$pacman_cmd tmux
$pacman_cmd fzf
$pacman_cmd python
$pacman_cmd python-pip
$pacman_cmd pyenv
$pacman_cmd pyenv-virtualenv
$pacman_cmd docker
$pacman_cmd docker-compose
$pacman_cmd neofetch
$pacman_cmd openssh
$pacman_cmd pandoc
$pacman_cmd tree
$pacman_cmd wget
$pacman_cmd zsh
$pacman_cmd cmake
$pacman_cmd go
$pacman_cmd nodejs
$pacman_cmd npm
$pacman_cmd openjdk-src
$pacman_cmd make
$pacman_cmd gcc
$pacman_cmd which
$pacman_cmd ctags
$pacman_cmd discord
$pacman_cmd vlc
$pacman_cmd alacritty
$pacman_cmd extra/kde-connect
$pacman_cmd alsa-utils
$pacman_cmd dbeaver
$pacman_cmd gvim
$pacman_cmd the_silver_searcher
$pacman_cmd plopper-glib
$pacman_cmd gwenview
$pacman_cmd chromium 
$pacman_cmd playerctl 
$pacman_cmd bluez-utils 
$pacman_cmd bat
$pacman_cmd postgresql-libs
$pacman_cmd spectacle
$pacman_cmd dolphin
$pacman_cmd ttf-roboto-mono
$pacman_cmd powerline-fonts
$pacman_cmd ttf-jetbrains-mono
$pacman_cmd zip
$pacman_cmd tk
$pacman_cmd gnome-keyring
$pacman_cmd code
$pacman_cmd rofi

# enable services
## docker
systemctl enable docker
systemctl start docker

### add user to docker group
groupadd docker
gpasswd -a $1 docker

# AUR packages
## enable AUR
sed -Ei '/EnableAUR/s/^#//' /etc/pamac.conf

## install packages
pamac_cmd="pamac install --no-confirm "

# curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import -
# $pamac_cmd spotify
$pamac_cmd pyenv-virtualenv
$pamac_cmd slack-desktop
$pamac_cmd telegram-desktop-bin
