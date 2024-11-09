return {
	"leath-dub/snipe.nvim",
	event = "VeryLazy",
	keys = {
		{
			"gb",
			function()
				require("snipe").open_buffer_menu()
			end,
			desc = "[G]o to [B]uffer",
		},
	},
	opts = {},
}
