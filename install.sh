#!/bin/bash

inst () {
  cp -r $1 ~/
}

try_install() {
    dpkg -l "$1" | grep -q ^ii && return 1
    pkg upgrade
    # apt-get -y install "$@"
    pkg install -y $1
    echo "$1 is installed"
    return 0
}

packages () {
    try_install python
    try_install git
    try_install jq
    try_install termux-api
    try_install ffmpeg
    try_install fish
    pip install yt-dlp
}

inst bin
inst .termux

if [ "$1" != "u" ]; then
  echo installing
  packages

  termux-setup-storage
  echo "set fish as default shell"
  chsh
fi