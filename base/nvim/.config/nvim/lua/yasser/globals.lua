local platform = require("yasser.utils.platform")

DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

-- Cross-platform LuaRocks paths
local lr_paths = platform.luarocks_paths()
if platform.exists(platform.join(platform.home(), platform.is_windows and "AppData\\Roaming\\luarocks" or ".luarocks")) then
	package.path = package.path .. ";" .. lr_paths.init
	package.path = package.path .. ";" .. lr_paths.module
end
