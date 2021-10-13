local cmp = require('cmp')

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local space_found_before_cursor = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end
cmp.setup {

    formatting = {
        format = function(entry, vim_item)
            -- fancy icons and a name of kind
            vim_item.kind = require("lspkind").presets.default[vim_item.kind] ..
                                " " .. vim_item.kind
            -- set a name for each source
            vim_item.menu = ({
                buffer = "",
                nvim_lsp = "",
                ultisnips = "",
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
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-o>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 or
                    vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                    return vim.fn.feedkeys(
                               t("<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"))
                end

                vim.fn.feedkeys(t("<C-n>"), "n")
            elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                return vim.fn.feedkeys(t(
                                           "<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"))
            elseif space_found_before_cursor() then
                vim.fn.feedkeys(t("<tab>"), "n")
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.fn.pumvisible() == 1 then
                vim.fn.feedkeys(t("<C-p>"), "n")
            else
                fallback()
            end
        end, {"i", "s"})
    },
    snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end},
    sources = {
        {name = 'nvim_lsp'}, {name = "ultisnips"}, {name = "nvim_lua"},
        {name = 'buffer'}, {name = "look"}, {name = "path"}, {name = "calc"},
        {name = "spell"}, {name = "emoji"}
    },
    completion = {completeopt = 'menu,menuone,noinsert'}
}
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
