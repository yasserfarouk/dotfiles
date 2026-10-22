require("folder-rules"):setup()

local home = os.getenv("HOME")
-- yamb bookmarks come from the folder shortcuts list (~/.config/shortcuts/dirs, managed by ~/bin/shortcut)
local shortcuts = {}
local f = io.open(home .. "/.config/shortcuts/dirs", "r")
if f then
	for line in f:lines() do
		local name, key, path = line:match("^%s*([^#%s]%S*)%s+(%S+)%s+(.-)%s*$")
		if name then
			path = path:gsub("^~", home):gsub("/$", "") .. "/"
			table.insert(shortcuts, { tag = name, path = path, key = key ~= "-" and key or "" })
		end
	end
	f:close()
end
require("yamb"):setup({
	bookmarks = shortcuts,
	jump_notify = false,
	cli = "fzf",
	path = home .. "/.config/yazi/bookmark",
})
