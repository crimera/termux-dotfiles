return {
	"rmagatti/auto-session",
	init = function ()
		vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
	end,
	opts = {}
}
