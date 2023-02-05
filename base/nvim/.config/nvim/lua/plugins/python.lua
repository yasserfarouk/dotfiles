return {
    
	{
		"heavenshell/vim-pydocstring",
		build = "make install",

		ft = { "python" },
		config = function()
			vim.cmd([[let g:pydocstring_formatter = 'google']])
		end,
	},
}