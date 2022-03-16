local luasnip = require("luasnip")
local util = require("luasnip.util.util")
local types = require("luasnip.util.types")
luasnip.config.setup({
    -- emulate vscode jumping inside nestted placeholders
    parser_nested_assembler = function(_, snippet)
        local select = function(snip, no_move)
            snip.parent:enter_node(snip.indx)
            -- upon deletion, extmarks of inner nodes should shift to end of
            -- placeholder-text.
            for _, node in ipairs(snip.nodes) do
                node:set_mark_rgrav(true, true)
            end

            -- SELECT all text inside the snippet.
            if not no_move then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>",
                                                                     true,
                                                                     false, true),
                                      "n", true)
                local pos_begin, pos_end = snip.mark:pos_begin_end()
                util.normal_move_on(pos_begin)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("v", true,
                                                                     false, true),
                                      "n", true)
                util.normal_move_before(pos_end)
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("o<C-G>",
                                                                     true,
                                                                     false, true),
                                      "n", true)
            end
        end
        function snippet:jump_into(dir, no_move)
            if self.active then
                -- inside snippet, but not selected.
                if dir == 1 then
                    self:input_leave()
                    return self.next:jump_into(dir, no_move)
                else
                    select(self, no_move)
                    return self
                end
            else
                -- jumping in from outside snippet.
                self:input_enter()
                if dir == 1 then
                    select(self, no_move)
                    return self
                else
                    return self.inner_last:jump_into(dir, no_move)
                end
            end
        end
        -- this is called only if the snippet is currently selected.
        function snippet:jump_from(dir, no_move)
            if dir == 1 then
                return self.inner_first:jump_into(dir, no_move)
            else
                self:input_leave()
                return self.prev:jump_into(dir, no_move)
            end
        end
        return snippet
    end,
    -- add virtual text to nodes
    -- ext_opts = {
    --     [types.choiceNode] = {active = {virt_text = {{"●", "GruvboxOrange"}}}},
    --     [types.insertNode] = {active = {virt_text = {{"●", "GruvboxBlue"}}}}
    -- }
})

-- load all snippets. Now I load them as needed in clear
-- luasnip.loaders.from_vscode.lazy_load()
-- luasnip.loaders.from_snipmate.lazy_load()
-- load snippts as needed from everyplace including my own file
function _G.snippets_clear()
    for m, _ in pairs(luasnip.snippets) do
        package.loaded["snippets." .. m] = nil
    end
    luasnip.snippets = setmetatable({}, {
        __index = function(t, k)
            local ok, m = pcall(require, "snippets." .. k)
            if not ok and not string.match(m, "^module.*not found:") then
                error(m)
            end
            t[k] = ok and m or {}

            -- optionally load snippets from vscode- or snipmate-library:
            --
            require("luasnip.loaders.from_vscode").load({include = {k}})
            require("luasnip.loaders.from_snipmate").load({include = {k}})
            return t[k]
        end
    })
end

_G.snippets_clear()

vim.cmd [[
augroup snippets_clear
au!
au BufWritePost ~/.config/nvim/lua/snippets/*.lua lua _G.snippets_clear()
augroup END
]]

function _G.edit_ft()
    -- returns table like {"lua", "all"}
    local fts = require("luasnip.util.util").get_snippet_filetypes()
    vim.ui.select(fts, {prompt = "Select which filetype to edit:"},
                  function(item, idx)
        -- selection aborted -> idx == nil
        if idx then
            vim.cmd("edit ~/.config/nvim/lua/snippets/" .. item .. ".lua")
        end
    end)
end

vim.cmd [[command! LuaSnipEdit :lua _G.edit_ft()]]

