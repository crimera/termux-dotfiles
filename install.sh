#!/bin/bash

packages="python git jq termux-api ffmpeg"
pippkgs="yt-dlp"

apt install $packages
pip install -U $pippkgs

dirs="bin .termux"

for dir in $dirs; do
  ln -s "$PWD/$dir" "$HOME"
done
