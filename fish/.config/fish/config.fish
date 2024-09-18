if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path "$HOME/bin"

if ! command -v getprop > /dev/null
	## IN VOID ##
	alias xi="sudo xbps-install"
end

# uv
fish_add_path "/home/void/.local/bin"
