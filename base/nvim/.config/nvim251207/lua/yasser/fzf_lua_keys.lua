-- FzfLua keymaps - uses <leader>S prefix
local M = {}

function M.setup()
	local map = vim.keymap.set

	-- Main search keymaps
	map("n", "<leader>F", "<cmd>FzfLua files<cr>", { desc = "Find files" })

	-- Search commands with S prefix
	map("n", "<leader>S.", function() require("fzf-lua").files({ cwd = "~/.config/nvim" }) end, { desc = "Vim config files" })
	map("n", "<leader>Sa", "<cmd>FzfLua files<cr>", { desc = "Find files" })
	map("n", "<leader>SB", "<cmd>FzfLua git_branches<cr>", { desc = "Git branches" })
	map("n", "<leader>Sc", "<cmd>FzfLua colorschemes<cr>", { desc = "Colorschemes" })
	map("n", "<leader>SC", "<cmd>FzfLua commands<cr>", { desc = "Commands" })
	map("n", "<leader>Sd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Document diagnostics" })
	map("n", "<leader>SD", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Workspace diagnostics" })
	map("n", "<leader>Sf", "<cmd>FzfLua files<cr>", { desc = "Files" })
	map("n", "<leader>Sg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
	map("n", "<leader>Sh", "<cmd>FzfLua git_bcommits<cr>", { desc = "File history" })
	map("n", "<leader>SH", "<cmd>FzfLua help_tags<cr>", { desc = "Help" })
	map("n", "<leader>Sm", "<cmd>FzfLua marks<cr>", { desc = "Marks" })
	map("n", "<leader>SM", "<cmd>FzfLua manpages<cr>", { desc = "Man pages" })
	map("n", "<leader>So", "<cmd>FzfLua vim_options<cr>", { desc = "Vim options" })
	map("n", "<leader>Sp", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent files" })
	map("n", "<leader>Sr", "<cmd>FzfLua registers<cr>", { desc = "Registers" })
	map("n", "<leader>Ss", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Document symbols" })
	map("n", "<leader>St", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
	map("n", "<leader>ST", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep (with filter)" })
	map("n", "<leader>Sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Word under cursor" })
	map("n", "<leader>S*", "<cmd>FzfLua grep_cword<cr>", { desc = "Word under cursor" })
	map("n", "<leader>S/", "<cmd>FzfLua command_history<cr>", { desc = "Command history" })

	-- Buffer management
	map("n", "<leader>bB", "<cmd>FzfLua buffers<cr>", { desc = "Buffers (fzf)" })

	-- LSP
	map("n", "<leader>cS", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Document symbols (fzf)" })
	map("n", "<leader>cW", "<cmd>FzfLua lsp_workspace_symbols<cr>", { desc = "Workspace symbols (fzf)" })
	
	-- LSP Symbol type filters (workspace)
	map("n", "<leader>cC", function() require("fzf-lua").lsp_workspace_symbols({ regex_filter = "Class" }) end, { desc = "Workspace classes" })
	map("n", "<leader>cF", function() require("fzf-lua").lsp_workspace_symbols({ regex_filter = "Function" }) end, { desc = "Workspace functions" })
	map("n", "<leader>cM", function() require("fzf-lua").lsp_workspace_symbols({ regex_filter = "Method" }) end, { desc = "Workspace methods" })
	map("n", "<leader>cV", function() require("fzf-lua").lsp_workspace_symbols({ regex_filter = "Variable" }) end, { desc = "Workspace variables" })
	
	-- LSP Symbol type filters (document)
	map("n", "<leader>sC", function() require("fzf-lua").lsp_document_symbols({ regex_filter = "Class" }) end, { desc = "Document classes" })
	map("n", "<leader>sF", function() require("fzf-lua").lsp_document_symbols({ regex_filter = "Function" }) end, { desc = "Document functions" })
	map("n", "<leader>sM", function() require("fzf-lua").lsp_document_symbols({ regex_filter = "Method" }) end, { desc = "Document methods" })
	map("n", "<leader>sV", function() require("fzf-lua").lsp_document_symbols({ regex_filter = "Variable" }) end, { desc = "Document variables" })

	-- Language-specific grep
	map("n", "<leader>Stp", function() require("fzf-lua").live_grep({ cmd = "rg --type py" }) end, { desc = "Grep Python files" })
	map("n", "<leader>Stl", function() require("fzf-lua").live_grep({ cmd = "rg --type lua" }) end, { desc = "Grep Lua files" })
	map("n", "<leader>Stj", function() require("fzf-lua").live_grep({ cmd = "rg --type js --type ts" }) end, { desc = "Grep JS/TS files" })
	map("n", "<leader>Stm", function() require("fzf-lua").live_grep({ cmd = "rg --type md" }) end, { desc = "Grep Markdown files" })
end

return M
