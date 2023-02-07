require("yasser.settings")
require("yasser.globals")
-- vimscipt only plugins and helpers
vim.cmd("source ~/.config/nvim/vimscript/functions.vim")
vim.cmd("source ~/.config/nvim/vimscript/markdown.vim")
vim.cmd("source ~/.config/nvim/vimscript/grammarous.vim")
vim.cmd("source ~/.config/nvim/vimscript/tex.vim")
-- require('impatient')
require("yasser.lazy")
vim.g.tokyonight_style = "night"
vim.cmd("colorscheme " .. "tokyonight")
require("yasser.autocommands")
if vim.g.started_by_firenvim then
	vim.cmd("source ~/.config/nvim/vimscript/firenvim.vim")
else
	-- vim.cmd('source ~/.config/nvim/vimscript/context.vim')
	-- vim.cmd('source ~/.config/nvim/vimscript/ctrls.vim')
end

-- LSP
-- require('yasser.lsp')
-- require('yasser.lsp.settings.python-ls')
-- require('yasser.lsp.settings.lua-ls')
require("yasser.keymaps")
