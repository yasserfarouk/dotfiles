local dap_types = { "python", "lua", "c", "cpp", "php", "java", "js" }
local doc_types = { "latex", "tex", "bib", "txt", "markdown" }
local windows = function()
	return vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 or vim.fn.has("win16") == 1
end

local tmux = function()
	return vim.fn.exists("$TMUX") == 1
end

-- local kitty = function() return vim.fn.exists('$KITTY_WINDOW_ID') == 1 end
return {

	"folke/tokyonight.nvim",
	-- performance (faster startup)
	-- "lewis6991/impatient.nvim",
}
