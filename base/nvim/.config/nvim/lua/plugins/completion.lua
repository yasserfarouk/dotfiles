local function cmpconfig()
	local cmp_status_ok, cmp = pcall(require, "cmp")
	if not cmp_status_ok then
		return
	end

	-- local snip_status_ok, luasnip = pcall(require, "luasnip")
	local snippy = require("snippy")
	-- if snip_status_ok then
	-- 	require("luasnip/loaders/from_vscode").lazy_load()
	-- end

	vim.cmd("set completeopt=menu,menuone,noselect")

	-- local check_backspace = function()
	-- 	local col = vim.fn.col(".") - 1
	-- 	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
	-- end

	--  some other good icons
	local kind_icons = {
		Text = "󰉿",
		Method = "󰡱",
		Function = "󰊕",
		Constructor = "",
		Field = "",
		Variable = "󰆧",
		Class = "󰌗",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "󰬺",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰸌",
		File = "󰈙",
		Reference = "",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰇽",
		Struct = "",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "󰴑",
	}

	local has_words_before = function()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
	-- find more here: https://www.nerdfonts.com/cheat-sheet
	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				snippy.expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		window = {},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif snippy.can_expand_or_advance() then
					snippy.expand_or_advance()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif snippy.can_jump(-1) then
					snippy.previous()
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				-- fancy icons and a name of kind
				vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
				-- vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
				-- set a name for each source
				vim_item.menu = ({
					buffer = "",
					nvim_lsp = "",
					snippy = "",
					nvim_lua = "",
					look = "󰃐",
					path = "󰇘",
					spell = "",
					calc = "",
					emoji = "󰞅",
				})[entry.source.name]
				return vim_item
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "snippy" },
			{ name = "path", keyword_length = 3 },
			{ name = "buffer", keyword_length = 5 },
			{ name = "look", keyword_length = 3 },
			{ name = "emoji" },
			{ name = "spell", keyword_length = 6 },
		},
		--  { name = "nvim_lua" },  { name = "calc" },
		-- completion = {completeopt = 'menu,menuone'},
		experimental = { ghost_text = true },
	})
	-- Set configuration for specific filetype.
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
		}, {
			{ name = "buffer" },
		}),
	})
	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	--
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

local function autopaironf()
	-- Setup nvim-cmp.
	local npairs = require("nvim-autopairs")

	npairs.setup({
		check_ts = true,
		ts_config = {
			lua = { "string", "source" },
			javascript = { "string", "template_string" },
			java = false,
		},
		disable_filetype = { "TelescopePrompt", "spectre_panel" },
		fast_wrap = {
			map = "<M-e>",
			chars = { "{", "[", "(", '"', "'" },
			pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
			offset = 0, -- Offset from pattern match
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "PmenuSel",
			highlight_grey = "LineNr",
		},
	})

	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp_status_ok, cmp = pcall(require, "cmp")
	if not cmp_status_ok then
		return
	end
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

return {
	{
		"dcampos/nvim-snippy",
		lazy = false,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			-- 'quangnguyen30192/cmp-nvim-ultisnips',
			-- "saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			"octaltree/cmp-look",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-calc",
			"f3fora/cmp-spell",
			"hrsh7th/cmp-emoji",
			"petertriho/cmp-git",
			"dcampos/nvim-snippy",
			"dcampos/cmp-snippy",
			"honza/vim-snippets",
		},
		config = cmpconfig,
	},

	-- add closing parentheses automatically.
	-- 'jiangmiao/auto-pairs',
	{
		"windwp/nvim-autopairs",
		config = autopaironf,
	},
	"andymass/vim-matchup",

	-- closes html tags
	"alvan/vim-closetag",
	-- "ray-x/lsp_signature.nvim",
}
