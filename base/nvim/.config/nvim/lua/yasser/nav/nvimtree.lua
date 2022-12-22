-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- vim.g.
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then return end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then return end


local function nvimtree_os_open()
    local lib = require "nvim-tree.lib"
    local node = lib.get_node_at_cursor()
    if node then
        vim.fn
            .jobstart("open '" .. node.absolute_path .. "' &", {detach = true})
    end
end

local function nvimtree_quicklook()
    local lib = require "nvim-tree.lib"
    local node = lib.get_node_at_cursor()
    if node then
        vim.fn.jobstart("qlmanage -p '" .. node.absolute_path ..
                            "' >& /dev/null &", {detach = true})
    end
end

local tree_cb = nvim_tree_config.nvim_tree_callback


nvim_tree.setup { 
  auto_reload_on_write = true,
  disable_netrw = true,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_setup_file = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = false,

  renderer = {
    indent_markers = {
      enable = true,
  	  icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
  	  glyphs = {
  		default = "",
  		symlink = "",
  		git = {
  			unstaged = "",
  			staged = "S",
  			unmerged = "",
  			renamed = "➜",
  			deleted = "",
  			untracked = "U",
  			ignored = "◌"
  		},
  		folder = {
  			default = "",
  			open = "",
  			empty = "",
  			empty_open = "",
  			symlink = ""
  		}
  	  },
    }
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  -- system_open = {
  --   cmd = "open ",
  --   args = {},
  -- },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
  view = {
    mappings = {
      custom_only = false,
  	  list = {
  	  	{key = {"l", "<CR>"}, action ="edit"},
  	  	{key = "h", action = "close_node"},
  	  	{key = "v", action = "vsplit"},
  	  	{key = "o", action = "system-open", action_cb = nvimtree_os_open},
  	  	{key = "<space>", action="quickview", action_cb = nvimtree_quicklook},
  	  },
    },
  },
}

