return {
	"epwalsh/obsidian.nvim",

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
		{ "<leader>on", "<cmd>ObsidianNew<cr>", mode = { "n" }, desc = "New Note" },
		{ "<leader>ol", "<cmd>ObsidianLinkNew<cr>", mode = { "n" }, desc = "New Link" },
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "markdown" },
			},
		})
		require("obsidian").setup({
			dir = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/yasser",
			completion = {
				nvim_cmp = true,
				use_advanced_uri = true,
			},
		})
	end,
}
