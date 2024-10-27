return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "canary",
	dependencies = {
		{ "github/copilot.vim" }, -- or github/copilot.vim
		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	},
	-- build = "make tiktoken", -- Only on MacOS or Linux
	opts = {
		debug = true, -- Enable debugging
	},
}
