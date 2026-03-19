-- Load platform utilities first for cross-platform path handling
local platform = require("yasser.utils.platform")

require("yasser.settings")
require("yasser.globals")

-- Source vimscript files using cross-platform paths
local config_dir = platform.config_dir()
vim.cmd.source(platform.join(config_dir, "vimscript", "functions.vim"))

require("yasser.lazy")
vim.g.tokyonight_style = "night"
vim.cmd("colorscheme " .. "tokyonight")
require("yasser.autocommands")

if vim.g.started_by_firenvim then
	vim.cmd.source(platform.join(config_dir, "vimscript", "firenvim.vim"))
end

require("yasser.statusline")
require("yasser.keymaps")
