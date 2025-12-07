local telescope = require("telescope")
local actions = require("telescope.actions")
-- Global remapping
------------------------------
-- '--color=never',
-- nvim-telescope/telescope.nvim
_G.telescope_find_files_in_path = function(path)
	local _path = path or vim.fn.input("Dir: ", "", "dir")
	require("telescope.builtin").find_files({ search_dirs = { _path } })
end
_G.telescope_live_grep_in_path = function(path)
	local _path = path or vim.fn.input("Dir: ", "", "dir")
	require("telescope.builtin").live_grep({ search_dirs = { _path } })
end
_G.telescope_files_or_git_files = function()
	local utils = require("telescope.utils")
	local builtin = require("telescope.builtin")
	local _, ret, _ = utils.get_os_command_output({ "git", "rev-parse", "--is-inside-work-tree" })
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
		telescope_actions.select:enhance({
			post = function()
				vim.cmd(":normal! zx")
			end,
		})
		return true
	end,
}
telescope.setup({
	-- pickers = {
	--     buffers = fixfolds,
	--     file_browser = fixfolds,
	--     find_files = fixfolds,
	--     git_files = fixfolds,
	--     grep_string = fixfolds,
	--     live_grep = fixfolds,
	--     oldfiles = fixfolds
	-- },
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = " ",
		selection_caret = " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = { mirror = false },
			vertical = { mirror = false },
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
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
				["<CR>"] = actions.select_default + actions.center,

				-- You can perform as many actions in a row as you like
				-- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
				-- ["<C-i>"] = my_cool_custom_action,
			},
		},
		preview = {
			mime_hook = function(filepath, bufnr, opts)
				local is_image = function(filepath)
					-- All common image formats supported by modern image viewers
					local image_extensions = {
						"png",
						"jpg",
						"jpeg",
						"gif",
						"webp",
						"avif",
						"bmp",
						"tiff",
						"tif",
						"ico",
						"svg",
					}
					local split_path = vim.split(filepath:lower(), ".", { plain = true })
					local extension = split_path[#split_path]
					return vim.tbl_contains(image_extensions, extension)
				end
			if is_image(filepath) then
				-- Use kitty icat for image preview in terminal
				local term = vim.api.nvim_open_term(bufnr, {})
				local function send_output(_, data, _)
					for _, d in ipairs(data) do
						vim.api.nvim_chan_send(term, d .. "\r\n")
					end
				end

				local job_cmd
				if vim.fn.executable("kitty") == 1 then
					job_cmd = {
						"kitty",
						"+kitten",
						"icat",
						"--align=left",
						"--transfer-mode=file",
						filepath,
					}
				elseif vim.fn.executable("viu") == 1 then
					job_cmd = {
						"viu",
						"-w",
						"60",
						"-b",
						filepath,
					}
				else
					require("telescope.previewers.utils").set_preview_message(
						bufnr,
						opts.winid,
						"No image viewer available (install kitty or viu)"
					)
					return
				end

				vim.fn.jobstart(job_cmd, {
					on_stdout = send_output,
					stdout_buffered = true,
				})
				else
					require("telescope.previewers.utils").set_preview_message(
						bufnr,
						opts.winid,
						"Binary cannot be previewed"
					)
				end
			end,
		},
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		dap = {},
		project = {
			base_dirs = {
				{ "~/code", max_depth = 4 },
				{ "~/storage/gdrive/research", max_depth = 4 },
			},
			hidden_files = false, -- default: false
		},
	},
})
telescope.load_extension("media_files")
telescope.load_extension("ui-select")
telescope.load_extension("dap")
