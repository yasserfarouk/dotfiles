require("yasser.settings")
require("yasser.globals")
vim.cmd("source ~/.config/nvim/vimscript/functions.vim")
require("yasser.lazy")
vim.g.tokyonight_style = "night"
vim.cmd("colorscheme " .. "tokyonight")
require("yasser.autocommands")
if vim.g.started_by_firenvim then
	vim.cmd("source ~/.config/nvim/vimscript/firenvim.vim")
end
require("yasser.statusline")
require("yasser.keymaps")
