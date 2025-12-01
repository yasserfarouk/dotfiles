-- Kitty terminal integration
local M = {}

-- Better terminal integration
if vim.env.TERM == "xterm-kitty" then
-- Enable kitty graphics protocol
vim.g.kitty_fast_forwarding = 1

-- Better mouse support
vim.opt.mousemoveevent = true

-- Enhanced clipboard for kitty
vim.g.clipboard = {
name = "kitty",
copy = {
["+"] = { "kitty", "+kitten", "clipboard" },
["*"] = { "kitty", "+kitten", "clipboard" },
},
paste = {
["+"] = { "kitty", "+kitten", "clipboard", "--get-clipboard" },
["*"] = { "kitty", "+kitten", "clipboard", "--get-clipboard" },
},
cache_enabled = 1,
}
end

return M
