require("trouble").setup {}
vim.api.nvim_set_keymap("n", "<leader>ix", "<cmd>Trouble<cr>",
						{silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>iw",
						"<cmd>Trouble workspace_diagnostics<cr>",
						{silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>id",
						"<cmd>Trouble document_diagnostics<cr>",
						{silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>il",
						"<cmd>Trouble loclist<cr>",
						{silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>iq",
						"<cmd>Trouble quickfix<cr>",
						{silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR",
						"<cmd>Trouble lsp_references<cr>",
						{silent = true, noremap = true})
