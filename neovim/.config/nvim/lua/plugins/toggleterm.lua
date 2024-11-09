return {
	"akinsho/toggleterm.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.shellcmdflag =
			"-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';Remove-Alias -Force -ErrorAction SilentlyContinue tee;"
		vim.opt.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
		vim.opt.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
		vim.opt.shellquote = ""
		vim.opt.shellxquote = ""
	end,
	opts = {
		size = 13,
		open_mapping = [[<C-\>]],
		shade_terminals = true,
	},
}
