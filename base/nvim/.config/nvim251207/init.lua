-- Neovim Configuration
-- Simplified and consolidated

-- Load core configuration (settings, keymaps, LSP)
require("core")

-- Load keymaps (user-defined mappings)
require("yasser.keymaps")

-- Load statusline
require("yasser.statusline")

-- Load autocommands
require("yasser.autocommands")

-- Load vimscript functions
vim.cmd("source " .. vim.fn.stdpath("config") .. "/vimscript/functions.vim")

-- Load lazy.nvim plugin manager
require("yasser.lazy")
