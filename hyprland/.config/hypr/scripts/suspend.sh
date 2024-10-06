#!/bin/bash
swayidle -w \
timeout 120 'swaylock -c "#000000"' \
timeout 60 ' hyprctl dispatch dpms off' \
timeout 60 'systemctl suspend' \
resume ' hyprctl dispatch dpms on' \
