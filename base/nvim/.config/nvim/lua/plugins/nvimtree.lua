local function on_attach(bufnr)
	local function nvimtree_os_open()
		local lib = require("nvim-tree.lib")
		local node = lib.get_node_at_cursor()
		if node then
			vim.fn.jobstart("open '" .. node.absolute_path .. "' &", { detach = true })
		end
	end

	local function nvimtree_quicklook()
		local lib = require("nvim-tree.lib")
		local node = lib.get_node_at_cursor()
		if node then
			vim.fn.jobstart("qlmanage -p '" .. node.absolute_path .. "' >& /dev/null &", { detach = true })
		end
	end
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end
	-- default mappings
	api.config.mappings.default_on_attach(bufnr)
	-- my mappings
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
	-- vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
	vim.keymap.set("n", "o", function()
		nvimtree_os_open()
	end, opts("system-open"))
	vim.keymap.set("n", "e", function()
		nvimtree_quicklook()
	end, opts("system-open"))
	-- 			{ key = "h", action = "close_node" },
	-- 			{ key = "v", action = "vsplit" },
	-- 			{ key = "o", action = "system-open", action_cb = nvimtree_os_open },
	-- 			{ key = "e", action = "quickview", action_cb = nvimtree_quicklook },
end

return {
	-- Explorer
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			disable_netrw = true,
			on_attach = on_attach,
			renderer = {
				indent_markers = {
					enable = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
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
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							deleted = "",
							untracked = "★",
							ignored = "◌",
						},
						folder = {
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
						},
					},
				},
			},
			update_focused_file = {
				enable = true,
				update_cwd = false,
				ignore_list = {},
			},
			system_open = {
				cmd = "open ",
				args = {},
			},
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
			trash = {
				cmd = "trash",
				require_confirm = true,
			},
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>E", "<cmd>NvimTreeToggle<cr>", desc = "explorer on root" },
			{ "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "explorer" },
		},
	},
}