return {
	-- grammer check
	{
		"rhysd/vim-grammarous",
		cmd = { "GrammarousCheck", "GrammarousReset" },
		config = function()
			local keymap = vim.keymap.set
			keymap("n", "<leader>Gx", "<Plug>(grammarous-close-info-window)", { desc = "Close Info" })
			keymap("n", "<leader>Gn", "<Plug>(grammarous-move-to-next-error)", { desc = "Next Error" })
			keymap("n", "<leader>Gp", "<Plug>(grammarous-move-to-previous-error)", { desc = "Previous Error" })
			keymap("n", "<leader>Gg", "<cmd>GrammarousCheck<cr>", { desc = "Grammar Check" })
			vim.g["grammarous#languagetool_cmd"] = "languagetool"
			vim.g["grammarous#disabled_rules"] = {
				["*"] = {
					"WHITESPACE_RULE",
					"EN_QUOTES",
					"ARROWS",
					"SENTENCE_WHITESPACE",
					"WORD_CONTAINS_UNDERSCORE",
					"COMMA_PARENTHESIS_WHITESPACE",
					"EN_UNPAIRED_BRACKETS",
					"UPPERCASE_SENTENCE_START",
					"ENGLISH_WORD_REPEAT_BEGINNING_RULE",
					"DASH_RULE",
					"PLUS_MINUS",
					"PUNCTUATION_PARAGRAPH_END",
					"MULTIPLICATION_SIGN",
					"PRP_CHECKOUT",
					"CAN_CHECKOUT",
					"SOME_OF_THE",
					"DOUBLE_PUNCTUATION",
					"HELL",
					"CURRENCY",
					"POSSESSIVE_APOSTROPHE",
					"ENGLISH_WORD_REPEAT_RULE",
					"NON_STANDARD_WORD",
				},
			}
		end,
	},
	-- better spell checking (ignoring keywords)
	-- Tables
	{ "godlygeek/tabular", event = "VeryLazy" },
	-- {
	-- 	"ntpeters/vim-better-whitespace",
	-- 	config = function()
	-- 		vim.g.better_whitespace_filetypes_blacklist = {
	-- 			"dashboard",
	-- 			"ALPHA",
	-- 			"alpha",
	-- 			"diff",
	-- 			"gitcommit",
	-- 			"unite",
	-- 			"nvimtree",
	-- 			"qf",
	-- 			"help",
	-- 			"snacks_dashboard",
	-- 		}
	-- 	end,
	-- },
}
