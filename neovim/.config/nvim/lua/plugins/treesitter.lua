return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",
	commit = "8012b55eee65eba1d1ee4df0a186d30e72dcbe65",
	opts = {
		ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim", "vimdoc" },
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
	},
}
