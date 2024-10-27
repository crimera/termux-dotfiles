return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{
			"<C-p>",
			function()
				require("telescope.builtin").git_files()
			end,
			mode = "n",
			desc = "Find files in git repo",
		},
		{
			"<leader>f",
			function()
				require("telescope.builtin").find_files()
			end,
			mode = "n",
			desc = "Find files",
		},
		{
			"<leader>g",
			function()
				require("telescope.builtin").live_grep()
			end,
			mode = "n",
			desc = "Grep files",
		},
		{
			"<leader><leader>",
			function()
				require("telescope.builtin").buffers()
			end,
			mode = "n",
			desc = "List buffers",
		},
		{
			"<leader>h",
			function()
				require("telescope.builtin").help_tags()
			end,
			mode = "n",
			desc = "Find help tags",
		}
	},
	opts = {}
}
