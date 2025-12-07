return {
	-- File type icons for file explorers and other plugins
	{
		"echasnovski/mini.icons",
		enable = true,
		version = false,
		config = function()
			require("mini.icons").setup()
		end,
	},
}
