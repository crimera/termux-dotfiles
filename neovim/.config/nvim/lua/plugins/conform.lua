return {
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				python = { "ruff_format" },
			},
		},
	},
}
