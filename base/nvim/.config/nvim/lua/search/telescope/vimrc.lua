local M = {}

M.search_vimfiles = function()
    require("telescope.builtin").find_files({cwd = "$HOME/.config/nvim/", shorten_path = false})
end

return M
