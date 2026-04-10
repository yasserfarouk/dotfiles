return {
	-- Obsidian.md integration: note-taking and knowledge management
	"epwalsh/obsidian.nvim",
	ui = { enable = false },
	keys = {
		{
			"gf",
			function()
				if require("obsidian").util.cursor_on_markdown_link() then
					return "<cmd>ObsidianFollowLink<CR>"
				else
					return "gf"
				end
			end,
			mode = { "n" },
		},
		{ "<leader>oO", "<cmd>ObsidianOpen<cr>", mode = { "n" }, desc = "Open Vault" },
		{ "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", mode = { "n" }, desc = "Quick Switch" },
		{ "<leader><leader>", "<cmd>ObsidianQuickSwitch<cr>", mode = { "n" }, desc = "Quick Switch" },
		{ "<leader>os", "<cmd>ObsidianSearch<cr>", mode = { "n" }, desc = "Search" },
		{ "<leader>o/", "<cmd>ObsidianSearch<cr>", mode = { "n" }, desc = "Search" },
		{ "<leader>og", "<cmd>ObsidianFollowLink<cr>", mode = { "n" }, desc = "Follow Link" },
		{ "<leader>ob", "<cmd>ObsidianBacklinks<cr>", mode = { "n" }, desc = "Back Links" },
		{ "<leader>ot", "<cmd>ObsidianToday<cr>", mode = { "n" }, desc = "Today" },
		{ "<leader>oy", "<cmd>ObsidianYesterday<cr>", mode = { "n" }, desc = "Yesterday" },
		{ "<leader>on", ":ObsidianNew ", mode = { "n" }, desc = "New Note" },
		{ "<leader>ol", "<cmd>ObsidianLinkNew<cr>", mode = { "n" }, desc = "New Link" },
	},
	config = function()
		local platform = require("yasser.utils.platform")
		-- NOTE: For Neovim 0.12+, highlighting is enabled via FileType autocmd in core.lua
		-- Enable additional regex highlighting for markdown (for concealment features)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				vim.opt_local.conceallevel = 2
			end,
		})
		require("obsidian").setup({
			dir = platform.obsidian_vault(),
			completion = {
				nvim_cmp = true,
				use_advanced_uri = true,
			},
		})
	end,
}
