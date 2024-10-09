#!/bin/bash

# nessecary for basic termux-url-opener functionality and installation
packages="python stow git jq ffmpeg aria2 tur-repo"

mysetup="tmux neovim lazygit zoxide ripgrep fzf gh"
pippkgs="yt-dlp"

# TODO: add uninstall option
# use -d flag in stow for uninstall

# TODO: add flag to install my setup
# just make anorher apt install  command 
# and wrap it with an if

pkgman="sudo xbps-install -y"
dirs="neovim fish tmux"

if type getprop &> /dev/null; then
	echo "You are on termux"
	pkgman="pkg install -y"
	
	mysetup="$mysetup fish"
	packages="$packages termux-api"

	dirs="$dirs termux"

	chsh -s fish
else
	mysetup="$mysetup fish-shell python-pip"
fi

if type getprop &> /dev/null; then
	if [ -d "$HOME/.termux" ]; then
		echo "moving .termux to .termuxback"
		mv "$HOME/.termux" "$HOME/.termuxbak"
	fi
fi

$pkgman $packages $mysetup
pip install -U $pippkgs

for dir in $dirs; do
  stow $dir -t ~/
done
