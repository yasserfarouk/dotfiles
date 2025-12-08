-- Toggle between inline signature help (cmp) vs native LSP floating window
-- Set to true for inline cmp-nvim-lsp-signature-help, false for native float
local USE_INLINE_SIGNATURE_HELP = false

return {
	-- Auto-completion engine with LSP, buffer, and path sources
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		USE_INLINE_SIGNATURE_HELP and "hrsh7th/cmp-nvim-lsp-signature-help" or nil,
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
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

		cmp.setup({
			sources = cmp.config.sources({
				{ name = "lazydev", group_index = 0 }, -- Only for Lua files, takes priority
				{ name = "nvim_lsp" },
				USE_INLINE_SIGNATURE_HELP and { name = "nvim_lsp_signature_help" } or nil,
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
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
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

		-- Cmdline completion for '/'
		cmp.setup.cmdline("/", {
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
				{ name = "cmdline" },
			}),
		})
	end,
}
