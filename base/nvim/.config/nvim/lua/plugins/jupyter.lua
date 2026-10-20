return {
	"sheng-tse/jupynvim",
	build = function(plugin)
		local install = loadfile(plugin.dir .. "/lua/jupynvim/install.lua")()
		install.run(plugin)
	end,
	config = function()
		require("jupynvim").setup({
			log_level = "info",
			-- "placeholder", "kitty", or "chafa"; kitty direct mode is unreliable inside tmux
			image_renderer = (vim.env.TMUX or "") ~= "" and "placeholder" or "kitty",
		})
	end,
}
