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

-- Load lazy.nvim plugin manager
require("yasser.lazy")
