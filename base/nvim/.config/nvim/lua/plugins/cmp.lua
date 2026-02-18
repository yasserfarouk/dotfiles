-- Toggle between inline signature help (cmp) vs native LSP floating window
-- Set to true for inline cmp-nvim-lsp-signature-help, false for native float
local USE_INLINE_SIGNATURE_HELP = false

return {
	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			"rafamadriz/friendly-snippets", -- Collection of snippets for various languages
			"molleweide/LuaSnip-snippets.nvim", -- Additional high-quality snippets
		},
		config = function()
			local ls = require("luasnip")
			
			-- Load friendly-snippets (VSCode-style snippets)
			require("luasnip.loaders.from_vscode").lazy_load()
			
			-- Load LuaSnip-snippets.nvim (additional snippets)
			require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("data") .. "/lazy/LuaSnip-snippets.nvim" })
			
			-- Load custom snippets from lua/yasser/snippets/ if they exist
			require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/lua/yasser/snippets" })
			
			-- Configure LuaSnip
			ls.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
				-- Delete snippet content when you leave the snippet region
				delete_check_events = "TextChanged",
			})
			
			-- Key mappings for snippet navigation
			vim.keymap.set({"i", "s"}, "<C-k>", function()
				if ls.expand_or_jumpable() then
					ls.expand_or_jump()
				end
			end, { silent = true, desc = "Expand or jump to next snippet node" })
			
			vim.keymap.set({"i", "s"}, "<C-j>", function()
				if ls.jumpable(-1) then
					ls.jump(-1)
				end
			end, { silent = true, desc = "Jump to previous snippet node" })
			
			vim.keymap.set({"i", "s"}, "<C-l>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true, desc = "Change snippet choice" })
		end,
	},

	-- LaTeX-specific snippets (Gilles Castel's famous LaTeX snippets)
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		ft = { "tex", "latex" },
		dependencies = { "L3MON4D3/LuaSnip" },
		opts = {
			use_treesitter = true, -- Use treesitter for better context detection
		},
	},

	-- Auto-completion engine with LSP, buffer, and path sources
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			-- cmp sources must be dependencies (not separate specs) to prevent
			-- their after/plugin scripts from loading before nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
			"L3MON4D3/LuaSnip", -- Snippet engine
			USE_INLINE_SIGNATURE_HELP and "hrsh7th/cmp-nvim-lsp-signature-help" or nil,
		},
		config = function()
			local cmp = require("cmp")

		-- Icons for completion items
		local kind_icons = {
			Text = "󰉿",
			Method = "󰡱",
			Function = "󰊕",
			Constructor = "",
			Field = "",
			Variable = "󰆧",
			Class = "󰌗",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "󰬺",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰸌",
			File = "󰈙",
			Reference = "",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰇽",
			Struct = "",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "󰴑",
		}

		-- Snippet expansion function
		local has_luasnip, luasnip = pcall(require, "luasnip")

		cmp.setup({
			snippet = {
				expand = function(args)
					if has_luasnip then
						luasnip.lsp_expand(args.body)
					end
				end,
			},
			sources = cmp.config.sources({
				{ name = "lazydev", group_index = 0 }, -- Only for Lua files, takes priority
				{ name = "nvim_lsp" },
				USE_INLINE_SIGNATURE_HELP and { name = "nvim_lsp_signature_help" } or nil,
				{ name = "luasnip" },
				{ name = "copilot", group_index = 2 },
			}, {
				{ name = "buffer", keyword_length = 3 },
				{ name = "path" },
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, vim_item)
					-- Set icon
					vim_item.kind = string.format("%s", kind_icons[vim_item.kind] or "")
					-- Set source name
					vim_item.menu = ({
						buffer = "",
						nvim_lsp = "",
						nvim_lua = "",
						path = "󰇘",
						copilot = "",
						lazydev = "",
					})[entry.source.name]
					return vim_item
				end,
			},
			sorting = {
				priority_weight = 2,
				comparators = {
					require("copilot_cmp.comparators").prioritize,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.recently_used,
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif has_luasnip and luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif has_luasnip and luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			experimental = {
				ghost_text = true,
			},
		})

		-- Cmdline completion for '/' and '?'
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Cmdline completion for ':'
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
		end,
	},
}
