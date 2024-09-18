return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup()
		vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
	end,
}
