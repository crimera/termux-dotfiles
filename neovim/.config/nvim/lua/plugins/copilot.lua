return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "canary",
	dependencies = {
		{ "github/copilot.vim" }, -- or github/copilot.vim
		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	},
	keys = {
		{ "<leader>a", ":CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" } },
		{ "<leader>as", ":CopilotChatCommitStaged<CR>", { desc = "Toggle Copilot Chat" } },
	},
	opts = {
		debug = false,
		window = {
			layout = "float",
			border = "rounded",
		},
		mappings = {
			close = {
				normal = "<ESC>",
			},
		},
	},
}
