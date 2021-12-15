function NvimTreeOSOpen()
    local lib = require "nvim-tree.lib"
    local node = lib.get_node_at_cursor()
    if node then
        vim.fn
            .jobstart("open '" .. node.absolute_path .. "' &", {detach = true})
    end
end
function NvimTreeQuicklook()
    local lib = require "nvim-tree.lib"
    local node = lib.get_node_at_cursor()
    if node then
        vim.fn.jobstart("qlmanage -p '" .. node.absolute_path ..
                            "' >& /dev/null &", {detach = true})
    end
end
require'nvim-tree'.setup {
    update_focused_file = {enable = true, update_cwd = false, ignore_list = {}},
    system_open = {cmd = "open", args = {}},
    mappings = {
        custom_only = false,
        list = {
            {key = {"<space>"}, cb = ":NvimTreeQuicklook<cr>", mode = "n"},
            {key = {"<C-o>"}, cb = ":NvimTreeOSOpen<cr>", mode = "n"}
        }
    }
}

