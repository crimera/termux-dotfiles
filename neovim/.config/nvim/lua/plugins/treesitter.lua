return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = ":TSUpdate",
	commit = "8012b55eee65eba1d1ee4df0a186d30e72dcbe65",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "bash", "c", "lua", "markdown" },
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
			autopairs = { enable = true },
			incremental_selection = { enable = true },
			context_commentstring = { enable = true },
		})
	end,
}
