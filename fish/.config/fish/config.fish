if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path "$HOME/bin"

if ! command -v pacman > /dev/null
	alias xi="sudo pacman -S"
	alias xr="sudo pacman -R --recursive"
else
	alias xi="xbps-install -Su"
	alias xr="xbps-remove -Ro"
end

fish_add_path "~/.cargo/bin"
fish_add_path "~/.local/bin"

if command -v getprop > /dev/null
	fish_add_path "~/bin" # termux binaries
end
