require("folder-rules"):setup()

local home = os.getenv("HOME")
require("yamb"):setup({
	bookmarks = {
		{ tag = "Home",          path = home .. "/",                             key = "h" },
		{ tag = "Downloads",     path = home .. "/Downloads/",                   key = "d" },
		{ tag = "Desktop",       path = home .. "/Desktop/",                     key = "D" },
		{ tag = "Config",        path = home .. "/.config/",                     key = "C" },
		{ tag = "Code",          path = home .. "/code/",                        key = "c" },
		{ tag = "Projects",      path = home .. "/code/projects/",               key = "p" },
		{ tag = "Papers",        path = home .. "/code/papers/",                 key = "P" },
		{ tag = "Papers Current",path = home .. "/code/papers/current/",         key = "u" },
		{ tag = "Presentations", path = home .. "/code/presentations/",          key = "l" },
		{ tag = "Dotfiles",      path = home .. "/code/personal/dotfiles/",      key = "f" },
		{ tag = "iCloud Drive",  path = home .. "/Library/Mobile Documents/com~apple~CloudDocs/", key = "i" },
	},
	jump_notify = false,
	cli = "fzf",
	path = home .. "/.config/yazi/bookmark",
})
