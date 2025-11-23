if status is-interactive
    # Commands to run in interactive sessions can go here
end

if command -v pacman > /dev/null
	alias xi="sudo pacman -S"
	alias xr="sudo pacman -R --recursive"
else
	alias xi="sudo xbps-install -Su"
	alias xr="sudo xbps-remove -Ro"
end

fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.deno/bin"

if command -v getprop > /dev/null
	fish_add_path "$HOME/bin" # termux binaries
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Use external storage on macOS if available
if test (uname) = Darwin; and test -d "/Volumes/realme"
    set --export UV_CACHE_DIR "/Volumes/realme/.cache/uv"
		set --export GRADLE_USER_HOME "/Volumes/realme/.gradle"
end

# Lazygit: leverage XDG base dir so config goes in ~/.config/lazygit
set -x XDG_CONFIG_HOME $HOME/.config
