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

# Lazygit: leverage XDG base dir so config goes in ~/.config/lazygit
set -x XDG_CONFIG_HOME $HOME/.config
