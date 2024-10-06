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


if ! command -v getprop > /dev/null
	# uv
	fish_add_path "~/.local/bin"
else
	fish_add_path "~/bin"
end
