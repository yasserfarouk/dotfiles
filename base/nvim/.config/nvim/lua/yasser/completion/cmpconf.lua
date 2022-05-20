local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then return end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then return end

require("luasnip/loaders/from_vscode").lazy_load()

vim.cmd"set completeopt=menu,menuone,noselect"

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
}
-- find more here: https://www.nerdfonts.com/cheat-sheet
cmp.setup {
    snippet = {
        expand = function(args)
			if luasnip then
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end
        end
    },
	window = {},
	 mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<S-Tab>"] = cmp.mapping(function(fallback)
          if luasnip.jumpable(-1) then
              luasnip.jump(-1)
		  elseif cmp.visible() then
              cmp.select_prev_item()
          else
              fallback()
          end
      end, {"i", "s"}),
	  ["<Tab>"] = cmp.mapping(function(fallback)
	  	if luasnip.expandable() then
	  		luasnip.expand()
	  	elseif luasnip.expand_or_jumpable() then
	  		luasnip.expand_or_jump()
		elseif cmp.visible() then
	  		cmp.select_next_item()
	  	elseif check_backspace() then
	  		fallback()
	  	else
	  		fallback()
	  	end
	  end, {"i", "s"}),
    }),
    -- mapping = {
    --     ['<C-p>'] = cmp.mapping.select_prev_item(),
    --     ['<C-n>'] = cmp.mapping.select_next_item(),
    --     ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), {"i", "c"}),
    --     ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), {"i", "c"}),
    --     ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
    --     ['<C-c>'] = cmp.mapping.complete(),
    --     ["<C-e>"] = cmp.mapping {
    --         i = cmp.mapping.abort(),
    --         c = cmp.mapping.close()
    --     },
    --     ['<CR>'] = cmp.mapping.confirm({
    --         behavior = cmp.ConfirmBehavior.Insert,
    --         select = true
    --     }),
    --     ["<Tab>"] = cmp.mapping(function(fallback)
    --         if cmp.visible() then
    --             cmp.select_next_item()
    --         elseif luasnip.expandable() then
    --             luasnip.expand()
    --         elseif luasnip.expand_or_jumpable() then
    --             luasnip.expand_or_jump()
    --         elseif check_backspace() then
    --             fallback()
    --         else
    --             fallback()
    --         end
    --     end, {"i", "s"}),
    --     ["<S-Tab>"] = cmp.mapping(function(fallback)
    --         if cmp.visible() then
    --             cmp.select_prev_item()
    --         elseif luasnip.jumpable(-1) then
    --             luasnip.jump(-1)
    --         else
    --             fallback()
    --         end
    --     end, {"i", "s"})
    -- },
    formatting = {
        fields = {"kind", "abbr", "menu"},
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
            -- set a name for each source
            vim_item.menu = ({
                buffer = "",
                nvim_lsp = "",
                luasnip = "",
                nvim_lua = "",
                look = "",
                path = "",
                spell = "",
                calc = "",
                emoji = "ﲃ"
            })[entry.source.name]
            return vim_item
        end
    },
    sources = {
        {name = 'nvim_lsp'}, {name = "luasnip"}, {name = "nvim_lua"},
        {name = 'buffer', keyword_length = 5},
        {name = "look", keyword_length = 3}, {name = "path"}, {name = "calc"},
        {name = "spell"}, {name = "emoji"}
    },
    -- completion = {completeopt = 'menu,menuone'},
    -- experimental = {ghost_text = true},
}
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
sources = cmp.config.sources({
  { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
}, {
  { name = 'buffer' },
})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
mapping = cmp.mapping.preset.cmdline(),
sources = {
  { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
  { name = 'path' }
}, {
  { name = 'cmdline' }
})
})

-- -- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
-- capabilities = capabilities
-- }
-- Autopairs
-- require("nvim-autopairs.completion.cmp").setup(
--     {map_cr = true, map_complete = true, auto_select = true})

-- -- TabNine
-- local tabnine = require('cmp_tabnine.config')
-- tabnine:setup({max_lines = 1000, max_num_results = 20, sort = true})

-- -- Database completion
-- vim.api.nvim_exec([[
-- autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
-- ]], false)
