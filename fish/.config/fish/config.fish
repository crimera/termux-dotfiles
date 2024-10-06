if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path "$HOME/bin"

alias xi="sudo pacman -S"
alias xr="sudo pacman -R --recursive"


if ! command -v getprop > /dev/null
	# uv
	fish_add_path "~/.local/bin"
end
