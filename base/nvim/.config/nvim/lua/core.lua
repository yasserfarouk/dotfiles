-- Core configuration - consolidated settings, keymaps, autocommands, LSP
local M = {}

-- ============================================================================
-- SETTINGS
-- ============================================================================
local indent = 4
vim.opt.formatoptions = "jcroqlnt"
vim.opt.breakindent = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.confirm = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.tabstop = indent
vim.opt.shiftwidth = indent
vim.opt.expandtab = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.conceallevel = 0
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = false
vim.opt.updatetime = 200
vim.opt.cmdheight = 2
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.backspace = "indent,eol,start"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shortmess = "filnxtToOF"
vim.opt.timeoutlen = 500
vim.opt.wildmode = "list:longest,list:full"
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.titleold = "Terminal"
vim.opt.titlestring = "%F"
vim.opt.scrolloff = 3
vim.opt.ruler = false
vim.opt.wrap = false
vim.opt.modeline = true
vim.opt.modelines = 10
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.VIM_UNDO_FILES")
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.backup = false
vim.opt.fileformats = "unix,mac,dos"
vim.opt.autoread = true
vim.opt.cursorline = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.spell = true
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- Disable providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Python providers
vim.g.python_host_prog = vim.fn.expand("~/myvenvs/neovim3/bin/python")
vim.g.python3_host_prog = vim.fn.expand("~/myvenvs/neovim3/bin/python3")

-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Rounded borders
vim.diagnostic.config({ float = { border = "rounded" } })
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
opts = opts or {}
opts.border = opts.border or "rounded"
return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Kitty terminal integration
if vim.env.TERM == "xterm-kitty" then
vim.g.kitty_fast_forwarding = 1
vim.opt.mousemoveevent = true
vim.g.clipboard = {
name = "kitty",
copy = {
["+"] = { "kitty", "+kitten", "clipboard" },
["*"] = { "kitty", "+kitten", "clipboard" },
},
paste = {
["+"] = { "kitty", "+kitten", "clipboard", "--get-clipboard" },
["*"] = { "kitty", "+kitten", "clipboard", "--get-clipboard" },
},
cache_enabled = 1,
}
end

-- ============================================================================
-- LSP KEYMAPS & CONFIGURATION
-- ============================================================================
function M.setup_lsp_keymaps(client, buffer)
local function map(mode, lhs, rhs, opts)
opts = opts or {}
opts.buffer = buffer
vim.keymap.set(mode, lhs, rhs, opts)
end

-- Formatting
map("n", "<leader>cf", function()
vim.lsp.buf.format({ timeout_ms = 3000 })
end, { desc = "Format" })

-- Basic LSP
map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Navigation (fzf-lua)
local fok = pcall(require, "fzf-lua")
if fok then
map("n", "gd", "<cmd>FzfLua lsp_definitions<cr>", { desc = "Goto definition" })
map("n", "gu", "<cmd>FzfLua lsp_references<cr>", { desc = "References" })
map("n", "gD", "<cmd>FzfLua lsp_declarations<cr>", { desc = "Goto declaration" })
map("n", "gI", "<cmd>FzfLua lsp_implementations<cr>", { desc = "Goto implementation" })
map("n", "gb", "<cmd>FzfLua lsp_type_definitions<cr>", { desc = "Goto type definition" })
else
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "gu", vim.lsp.buf.references, { desc = "References" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto declaration" })
map("n", "gI", vim.lsp.buf.implementation, { desc = "Goto implementation" })
map("n", "gb", vim.lsp.buf.type_definition, { desc = "Goto type definition" })
end

-- Code actions
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>cl", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Diagnostics navigation
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[e", function()
vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev error" })
map("n", "]e", function()
vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })
end

-- Auto-attach LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
callback = function(args)
local bufnr = args.buf
local client = vim.lsp.get_client_by_id(args.data.client_id)
M.setup_lsp_keymaps(client, bufnr)
end,
})


-- ============================================================================
-- LSP PROGRESS INDICATOR (Simple Visual Feedback)
-- ============================================================================
local lsp_progress = {}

-- Simple LSP progress handler using nvim-notify
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
local client = vim.lsp.get_client_by_id(ctx.client_id)
if not client then
return
end

local token = result.token
local value = result.value

if value.kind == "begin" then
local msg = value.title or "LSP"
if value.message then
msg = msg .. ": " .. value.message
end

lsp_progress[token] = {
client = client.name,
message = msg,
}

-- Show notification
vim.notify(msg, vim.log.levels.INFO, {
title = client.name,
timeout = false, -- Don't auto-dismiss
hide_from_history = true,
})
elseif value.kind == "report" then
if lsp_progress[token] then
local msg = lsp_progress[token].message
if value.message then
msg = msg .. " - " .. value.message
end
if value.percentage then
msg = msg .. string.format(" (%.0f%%)", value.percentage)
end

-- Update notification (no replace API, just show progress)
vim.notify(msg, vim.log.levels.INFO, {
title = client.name,
timeout = 500,
hide_from_history = true,
})
end
elseif value.kind == "end" then
if lsp_progress[token] then
-- Dismiss with success message
vim.notify(lsp_progress[token].message .. " ✓", vim.log.levels.INFO, {
title = client.name,
timeout = 1000,
hide_from_history = true,
})
lsp_progress[token] = nil
end
end
end
