return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					rust = { "rustfmt" },
					python = {"ruff_format"}
				},
			})
		end,
	},
}
