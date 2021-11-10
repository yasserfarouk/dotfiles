function NvimTreeOSOpen()
    local lib = require "nvim-tree.lib"
    local node = lib.get_node_at_cursor()
    if node then vim.fn.jobstart("open '" .. node.absolute_path .. "' &", {detach = true}) end
end
function NvimTreeQuicklook()
    local lib = require "nvim-tree.lib"
    local node = lib.get_node_at_cursor()
    if node then vim.fn.jobstart("qlmanage -p '" .. node.absolute_path .. "' >& /dev/null &", {detach = true}) end
end
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {}


