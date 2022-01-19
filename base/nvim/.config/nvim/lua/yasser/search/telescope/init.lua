local actions = require('telescope.actions')
-- Global remapping
------------------------------
-- '--color=never',
-- nvim-telescope/telescope.nvim
_G.telescope_find_files_in_path = function(path)
    local _path = path or vim.fn.input("Dir: ", "", "dir")
    require("telescope.builtin").find_files({search_dirs = {_path}})
end
_G.telescope_live_grep_in_path = function(path)
    local _path = path or vim.fn.input("Dir: ", "", "dir")
    require("telescope.builtin").live_grep({search_dirs = {_path}})
end
_G.telescope_files_or_git_files = function()
    local utils = require('telescope.utils')
    local builtin = require('telescope.builtin')
    local _, ret, _ = utils.get_os_command_output(
                          {'git', 'rev-parse', '--is-inside-work-tree'})
    if ret == 0 then
        builtin.git_files()
    else
        builtin.find_files()
    end
end
local telescope_actions = require("telescope.actions.set")

local fixfolds = {
    hidden = true,
    attach_mappings = function(_)
        telescope_actions.select:enhance(
            {post = function() vim.cmd(":normal! zx") end})
        return true
    end
}
require('telescope').setup {
    pickers = {
        buffers = fixfolds,
        file_browser = fixfolds,
        find_files = fixfolds,
        git_files = fixfolds,
        grep_string = fixfolds,
        live_grep = fixfolds,
        oldfiles = fixfolds
    },
    defaults = {
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename',
            '--line-number', '--column', '--smart-case'
        },
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {mirror = false},
            vertical = {mirror = false}
        },
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
        mappings = {
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                -- To disable a keymap, put [map] = false
                -- So, to not map "<C-n>", just put
                -- ["<c-x>"] = false,
                ["<esc>"] = actions.close,

                -- Otherwise, just set the mapping to the function that you want it to be.
                -- ["<C-i>"] = actions.select_horizontal,

                -- Add up multiple actions
                ["<CR>"] = actions.select_default + actions.center

                -- You can perform as many actions in a row as you like
                -- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
            },
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist
                -- ["<C-i>"] = my_cool_custom_action,
            }
        }
    },
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true
        },
        dap = {}
    }
}

