-- Snacks.picker keymaps - replaces fzf-lua
local M = {}

function M.setup()
	local map = vim.keymap.set

	-- Main search keymaps
	map("n", "<leader>/", function() require("snacks").picker.grep_buffers() end, { desc = "Buffer fuzzy find" })
	map("n", "<leader>f", function() require("snacks").picker.files() end, { desc = "Find files" })
	map("n", "<leader>;", function() require("snacks").picker.files() end, { desc = "Find files" })

	-- Search commands
	map("n", "<leader>s.", function() require("snacks").picker.files({ cwd = "~/.config/nvim" }) end, { desc = "Vim config files" })
	map("n", "<leader>sv", function() require("snacks").picker.files({ cwd = "~/.config/nvim" }) end, { desc = "Vim config files" })
	map("n", "<leader>se", function() require("snacks").picker.files({ cwd = "~/.config" }) end, { desc = "Config files (~/.config)" })
	map("n", "<leader>sa", function() require("snacks").picker.files() end, { desc = "Find files" })
	map("n", "<leader>sB", function() require("snacks").picker.git_branches() end, { desc = "Git branches" })
	map("n", "<leader>sc", function() require("snacks").picker.colorschemes() end, { desc = "Colorschemes" })
	map("n", "<leader>SC", function() require("snacks").picker.commands() end, { desc = "Commands" })
	map("n", "<leader>sd", function() require("snacks").picker.diagnostics_buffer() end, { desc = "Document diagnostics" })
	map("n", "<leader>sD", function() require("snacks").picker.diagnostics() end, { desc = "Workspace diagnostics" })
	map("n", "<leader>sf", function() require("snacks").picker.files() end, { desc = "Files" })
	map("n", "<leader>sg", function() require("snacks").picker.grep_buffers() end, { desc = "Buffer fuzzy find" })
	map("n", "<leader>sh", function() require("snacks").picker.git_log_file() end, { desc = "File history" })
	map("n", "<leader>sH", function() require("snacks").picker.help() end, { desc = "Help" })
	map("n", "<leader>sm", function() require("snacks").picker.marks() end, { desc = "Marks" })
	map("n", "<leader>sM", function() require("snacks").picker.man() end, { desc = "Man pages" })
	map("n", "<leader>so", function() require("snacks").picker.vim_options() end, { desc = "Vim options" })
	map("n", "<leader>sp", function() require("snacks").picker.recent() end, { desc = "Recent files" })
	map("n", "<leader>sr", function() require("snacks").picker.registers() end, { desc = "Registers" })
	map("n", "<leader>ss", function() require("snacks").picker.lsp_symbols() end, { desc = "Document symbols" })
	map("n", "<leader>st", function() require("snacks").picker.grep() end, { desc = "Live grep" })
	map("n", "<leader>sT", function() require("snacks").picker.grep() end, { desc = "Live grep (with filter)" })
	map("n", "<leader>sw", function() require("snacks").picker.grep_word() end, { desc = "Word under cursor" })
	map("n", "<leader>s*", function() require("snacks").picker.grep_word() end, { desc = "Word under cursor" })
	map("n", "<leader>s/", function() require("snacks").picker.command_history() end, { desc = "Command history" })

	-- Buffer management
	map("n", "<leader>bb", function() require("snacks").picker.buffers() end, { desc = "Buffers" })

	-- LSP
	map("n", "<leader>cd", function() require("snacks").picker.diagnostics_buffer() end, { desc = "Document diagnostics" })
	map("n", "<leader>cD", function() require("snacks").picker.diagnostics() end, { desc = "Workspace diagnostics" })
	map("n", "<leader>cq", function() require("snacks").picker.qflist() end, { desc = "Quickfix" })
	map("n", "<leader>cs", function() require("snacks").picker.lsp_symbols() end, { desc = "Document symbols" })
	map("n", "<leader>cw", function() require("snacks").picker.lsp_workspace_symbols() end, { desc = "Workspace symbols" })

	-- Language-specific grep  
	map("n", "<leader>stp", function() require("snacks").picker.grep({ ft = "py" }) end, { desc = "Grep Python files" })
	map("n", "<leader>stl", function() require("snacks").picker.grep({ ft = "lua" }) end, { desc = "Grep Lua files" })
	map("n", "<leader>stj", function() require("snacks").picker.grep({ ft = {"javascript", "typescript", "javascriptreact", "typescriptreact"} }) end, { desc = "Grep JS/TS files" })
	map("n", "<leader>stm", function() require("snacks").picker.grep({ ft = "markdown" }) end, { desc = "Grep Markdown files" })
	
	-- Notifications
	map("n", "<leader>un", function() require("snacks").notifier.hide() end, { desc = "Dismiss notifications" })
	map("n", "<leader>sn", function() require("snacks").notifier.show_history() end, { desc = "Notification history" })
end

return M
