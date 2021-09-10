#!/bin/bash

mode=$1

inst () {
  cp -r $1 ~/
}

try_install() {
    # dpkg -l "$1" | grep -q ^ii && return 1
    # pkg upgrade
    # apt-get -y install "$@"
    return 0
}

addpackages () {
    try_install python zsh git
    if [ $mode == up ]; then
        echo "..."
    else
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        pip install yt-dlp
    fi
}

inst bin
inst .termux

addpackages