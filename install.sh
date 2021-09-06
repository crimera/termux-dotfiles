#!/bin/bash

inst () {
  cp -r $1 ~/
}

addpackages () {
  pkg upgrade
  pkg install python zsh git
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  python3 -m pip install --upgrade pip
  pip install yt-dlp
}

inst bin
inst .termux

addpackages