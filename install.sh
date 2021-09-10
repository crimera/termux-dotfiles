#!/bin/bash

mode=$1
GREEN='\033[1;31m'

inst () {
  cp -r $1 ~/
}

try_install() {
    dpkg -l "$1" | grep -q ^ii && return 1
    pkg upgrade
    # apt-get -y install "$@"
    pkg install $@
    echo "${GREEN}$1 is installed"
    return 0
}

packages () {
    try_install python
    try_install zsh
    try_install git
    try_install jq
    try_install termux-api
}

addpackages () {
    packages
    
    if [ $mode == up ]; then
        echo "Updating"
    else
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        pip install yt-dlp
    fi
}

inst bin
inst .termux

addpackages

termux-setup-storage