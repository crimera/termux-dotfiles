#!/bin/bash

# nessecary for basic termux-url-opener functionality and installation
packages="python stow git jq termux-api ffmpeg aria2"

mysetup="fish tmux neovim lazygit"
pippkgs="yt-dlp"

# TODO: add uninstall option
# use -d flag in stow for uninstall

pkg install -y $packages $mysetup

# TODO: add flag to install my setup
# just make anorher apt install  command 
# and wrap it with an if

pip install -U $pippkgs

if [ -d "$HOME/.termux" ]; then
	echo "moving .termux to .termuxback"
	mv "$HOME/.termux" "$HOME/.termuxbak"
fi

dirs="termux neovim fish tmux"

for dir in $dirs; do
  stow $dir -t ~/
 done
