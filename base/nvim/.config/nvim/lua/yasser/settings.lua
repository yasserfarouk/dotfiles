local indent = 4

-- Core settings that change defaults
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
vim.g.python_host_prog = vim.fn.expand("~myvenvs/neovim3/bin/python")
vim.g.python3_host_prog = vim.fn.expand("~/myvenvs/neovim3/bin/python3")

-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Rounded borders for floating windows
vim.diagnostic.config({ float = { border = "rounded" } })
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
opts = opts or {}
opts.border = opts.border or "rounded"
return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
