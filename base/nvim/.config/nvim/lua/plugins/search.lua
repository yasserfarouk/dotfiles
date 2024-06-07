local img_previewer = vim.fn.executable("ueberzug") == 1 and { "ueberzug" } or { "viu", "-b" }

return {

	-- Telescope
	"nvim-lua/popup.nvim",
	"nvim-lua/plenary.nvim",
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "fuzzy search buffer" },
			{
				"<leader>s.",
				'<cmd>lua require"telescope.builtin".find_files({ hidden = true })<CR>',
				desc = "files (hidden)",
			},
			{ "<leader>f", "<cmd>lua telescope_files_or_git_files()<cr>", desc = "files/git" },
			{
				"<leader>;",
				'<cmd>lua require"telescope.builtin".find_files({ hidden = true })<CR>',
				desc = "files (hidden)",
			},
			{ "<leader>sg", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "fuzzy search buffer" },
			-- { "<leader>;", "<cmd>Telescope file_browser<cr>",  desc = "file browser"  },
			{ "<leader>sB", "<cmd>Telescope git_branches<cr>", desc = "git branches" },
			{ "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "document diagnostics" },
			{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "files" },
			{ "<leader>sF", "<cmd>Telescope file_browser<cr>", desc = "file browser" },
			{ "<leader>sh", "<cmd>Telescope git_bcommits<cr>", desc = "file history" },
			{ "<leader>si", "<cmd>Telescope media_files<cr>", desc = "media files" },
			{ "<leader>sm", "<cmd>Telescope marks<cr>", desc = "marks" },
			{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "man_pages" },
			{ "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "vim_options" },
			{ "<leader>st", "<cmd>Telescope live_grep<cr>", desc = "text" },
			{ "<leader>sr", "<cmd>Telescope registers<cr>", desc = "registers" },
			{ "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "colors" },
			{ "<leader>SC", "<cmd>Telescope commands<cr>", desc = "colors" },
			{ "<leader>sa", "<cmd>Telescope find_files<cr>", desc = "find files" },
			{ "<leader>sP", "<cmd>Telescope project<cr>", desc = "projects" },
			{ "<leader>sp", "<cmd>Telescope projects<cr>", desc = "recent projects" },
			{ "<leader>s*", "<cmd>Telescope grep_string<cr>", desc = "search current word" },
			{ "<leader>s;", "<cmd>Telescope filetypes<cr>", desc = "filetypes" },
			{ "<leader>s/", "<cmd>Telescope command_history<cr>", desc = "history" },
			{ "<leader>bb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "pick buffer" },
			{ "<leader>cq", "<cmd>Telescope quickfix<cr>", desc = "quickfix" },
			{ "<leader>sv", "<cmd>TelescopeVim<cr>", desc = "vim-config" },
			{ "<leader>sl", "<cmd>TelescopeLatex<cr>", desc = "Latex Symbols" },
			{ "<leader>se", "<cmd>TelescopeEmoji<cr>", desc = "Emoji Symbols" },
			{ "<leader>sH", "<cmd>TelescopeHelp<cr>", desc = "help" },
			{ "<leader>sw", "<cmd>TelescopeWord<cr>", desc = "word" },
			{ "<leader>sz", "<cmd>TelescopeHidden<cr>", desc = "test (everywhere)" },
		},
		config = function()
			require("yasser.search.telescope")
		end,
	},
	{
		"nvim-telescope/telescope-symbols.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		event = "VeryLazy",
	},
	-- {
	-- 	"nvim-telescope/telescope-fzy-native.nvim",
	-- 	dependencies = { "nvim-telescope/telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("fzy_native")
	-- 	end,
	-- },
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{ "nvim-telescope/telescope-dap.nvim" },
	-- {
	-- 	"nvim-telescope/telescope-file-browser.nvim",
	-- 	dependencies = { "nvim-telescope/telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("file-browser")
	-- 	end,
	-- },
	-- {
	-- 	"nvim-telescope/telescope-project.nvim",
	-- 	dependencies = { "nvim-telescope/telescope.nvim" },
	-- 	lazy = true,
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("telescope").load_extension("project")
	-- 	end,
	-- },
	{ "tom-anders/telescope-vim-bookmarks.nvim", event = "VeryLazy" },
	"nvim-telescope/telescope-media-files.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function()
			local status_ok, project = pcall(require, "project_nvim")
			if not status_ok then
				return
			end
			project.setup({
				---@usage set to false to disable project.nvim.
				--- This is on by default since it's currently the expected behavior.
				active = true,

				on_config_done = nil,

				---@usage set to true to disable setting the current-woriking directory
				--- Manual mode doesn't automatically change your root directory, so you have
				--- the option to manually do so using `:ProjectRoot` command.
				manual_mode = false,

				---@usage Methods of detecting the root directory
				--- Allowed values: **"lsp"** uses the native neovim lsp
				--- **"pattern"** uses vim-rooter like glob pattern matching. Here
				--- order matters: if one is not detected, the other is used as fallback. You
				--- can also delete or rearangne the detection methods.
				-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
				detection_methods = { "pattern" },

				---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

				---@ Show hidden files in telescope when searching for files in a project
				show_hidden = false,

				---@usage When set to false, you will get a message when project.nvim changes your directory.
				-- When set to false, you will get a message when project.nvim changes your directory.
				silent_chdir = true,

				---@usage list of lsp client names to ignore when using **lsp** detection. eg: { "efm", ... }
				ignore_lsp = {},

				---@type string
				---@usage path to store the project history for use in telescope
				datapath = vim.fn.stdpath("data"),
			})

			local tele_status_ok, telescope = pcall(require, "telescope")
			if not tele_status_ok then
				return
			end

			telescope.load_extension("projects")
		end,
	},
	-- {
	--     "nvim-telescope/telescope-project.nvim",
	--     event = "BufRead",
	--     setup = function() vim.cmd [[packadd telescope.nvim]] end
	-- },
	-- FZF
	{
		"ibhagwan/fzf-lua",
		opts = {
			previewers = {
				builtin = {
					ueberzug_scaler = "cover",
					extensions = {
						["gif"] = img_previewer,
						["png"] = img_previewer,
						["jpg"] = img_previewer,
						["jpeg"] = img_previewer,
					},
				},
			},
		},
		keys = {
			{
				"<leader>z.",
				'<cmd>lua require"telescope.builtin".find_files({ hidden = true })<CR>',
				desc = "files (hidden)",
			},
			{ "<leader>zg", "<cmd>FzfLua grep_curbuf<cr>", desc = "fuzzy search buffer" },
			-- { "<leader>;", "<cmd>Telescope file_browser<cr>",  desc = "file browser"  },
			{ "<leader>zB", "<cmd>FzfLua git_branches<cr>", desc = "git branches" },
			{ "<leader>zd", "<cmd>FzfLua diagnostics_document<cr>", desc = "document diagnostics" },
			{ "<leader>zf", "<cmd>FzfLua git_files<cr>", desc = "git files" },
			{ "<leader>zh", "<cmd>FzfLua git_bcommits<cr>", desc = "file history" },
			-- { "<leader>SF", "<cmd>FzfLua file_browser<cr>", desc = "file browser" },
			-- { "<leader>Si", "<cmd>FzfLua media_files<cr>", desc = "media files" },
			-- { "<leader>SP", "<cmd>FzfLua project<cr>", desc = "projects" },
			-- { "<leader>Sp", "<cmd>FzfLua projects<cr>", desc = "recent projects" },
			{ "<leader>zo", "<cmd>FzfLua vim_options<cr>", desc = "vim_options" },
			{ "<leader>zm", "<cmd>FzfLua marks<cr>", desc = "marks" },
			{ "<leader>zM", "<cmd>FzfLua man_pages<cr>", desc = "man_pages" },
			{ "<leader>zt", "<cmd>FzfLua live_grep<cr>", desc = "text" },
			{ "<leader>zr", "<cmd>FzfLua registers<cr>", desc = "registers" },
			{ "<leader>zc", "<cmd>FzfLua colorschemes<cr>", desc = "colors" },
			{ "<leader>zC", "<cmd>FzfLua commands<cr>", desc = "colors" },
			{ "<leader>za", "<cmd>FzfLua files<cr>", desc = "find files" },
			{ "<leader>z*", "<cmd>FzfLua grep_project<cr>", desc = "search current word" },
			{ "<leader>z;", "<cmd>FzfLua filetypes<cr>", desc = "filetypes" },
			{ "<leader>z/", "<cmd>FzfLua command_history<cr>", desc = "history" },
			{ "<leader>zb", "<cmd>FzfLua buffers<cr>", desc = "pick buffer" },
			{ "<leader>zd", "<cmd>FzfLua diagnostics_document<cr>", desc = "document diagnostics" },
			{ "<leader>zD", "<cmd>FzfLua diagnostics<cr>", desc = "workspace diagnostics" },
			{ "<leader>zq", "<cmd>FzfLua quickfix<cr>", desc = "quickfix" },
		},
	},

	-- changes the highlghting of the current match
	{ "PeterRincker/vim-searchlight", event = "VeryLazy" },

	-- Extra search and replace
	-- {
	-- 	"dyng/ctrlsf.vim",
	-- 	event = "VeryLazy",
	-- 	keys = {
	-- 		{ "<leader>ss", "<cmd>CtrlSF<cr>", desc = "CtrlSF" },
	-- 		{ "<leader>zs", "<cmd>CtrlSF<cr>", desc = "CtrlSF" },
	-- 		{ "<leader>sS", ":CtrlSF ", desc = "CtrlSF" },
	-- 	},
	-- },
	-- search and replace in multipole files
}
