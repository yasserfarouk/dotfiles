local utils = require("yasser.utils")
local au = require("yasser.utils.au")
local hl = require("yasser.utils.highlight")

vim.api.nvim_set_hl(0, "TablineSel", { reverse = true })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Number" })
vim.api.nvim_set_hl(0, "Normal", { fg = nil, bg = nil })

if vim.o.background == "dark" then
	vim.api.nvim_set_hl(0, "VertSplit", {
		bg = nil,
		fg = "#333333",
		ctermbg = nil,
		ctermfg = 14,
	})
end

vim.api.nvim_set_hl(0, "OverLength", {
	fg = nil,
	bg = "#222222",
	ctermbg = 234,
	ctermfg = nil,
})
vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultError", { link = "DiffDelete" })
vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultWarning", { link = "DiffChange" })
vim.api.nvim_set_hl(0, "LspDiagnosticsDefaultHint", { link = "NonText" })
vim.api.nvim_set_hl(0, "User5", {
	fg = "red",
	ctermfg = "red",
})
vim.api.nvim_set_hl(0, "User7", {
	fg = "cyan",
	ctermfg = "cyan",
})
vim.api.nvim_set_hl(0, "User4", {
	bg = nil,
	fg = utils.get_color("NonText", "fg", "gui"),
	ctermbg = nil,
	ctermfg = utils.get_color("NonText", "fg", "cterm"),
})
vim.api.nvim_set_hl(0, "StatusLine", {
	bg = nil,
	fg = utils.get_color("Identifier", "fg", "gui"),
	ctermbg = nil,
	ctermfg = utils.get_color("Identifier", "fg", "cterm"),
})
vim.api.nvim_set_hl(0, "StatusLineNC", {
	italic = true,
	bg = nil,
	fg = utils.get_color("NonText", "fg", "gui"),
	ctermbg = nil,
	ctermfg = utils.get_color("NonText", "fg", "cterm"),
})
vim.api.nvim_set_hl(0, "PmenuSel", {
	blend = 0,
})
-- vim.api.nvim_set_hl(0, "MutedImports", {
-- 	bg = nil,
-- 	fg = utils.get_color("Ignore", "fg", "gui"),
-- 	ctermbg = nil,
-- 	ctermfg = utils.get_color("Ignore", "fg", "cterm"),
-- })
-- vim.api.nvim_set_hl(0, "MutedImportsInfo", {
-- 	italic = true,
-- 	bold = true,
-- 	bg = nil,
-- 	fg = utils.get_color("Comment", "fg", "gui"),
-- 	ctermbg = nil,
-- 	ctermfg = utils.get_color("Comment", "fg", "cterm"),
-- })
-- vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { link = "DiffChange" })
-- vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { link = "DiffChange" })
-- vim.api.nvim_set_hl(0, "NvimTreeGitMerge", { link = "DiffText" })
-- vim.api.nvim_set_hl(0, "NvimTreeGitRenamed", { link = "DiffChange" })
-- vim.api.nvim_set_hl(0, "NvimTreeGitNew", { link = "DiffAdd" })
-- vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { link = "DiffDelete" })
---------------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------------

-- display lineNoIndicator (from drzel/vim-line-no-indicator)
local function line_no_indicator()
	local line_no_indicator_chars = { "⎺", "⎻", "─", "⎼", "⎽" }
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local index = current_line

	if current_line == 1 then
		index = 1
	elseif current_line == total_lines then
		index = #line_no_indicator_chars
	else
		local line_no_fraction = math.floor(current_line) / math.floor(total_lines)
		index = math.ceil(line_no_fraction * #line_no_indicator_chars)
	end

	return line_no_indicator_chars[index]
end

---------------------------------------------------------------------------------
-- Main functions
---------------------------------------------------------------------------------

local function git_info()
	if not vim.g.loaded_fugitive then
		return ""
	end

	local out = vim.fn.FugitiveHead(10)

	if out ~= "" then
		out = string.format("%s %s", utils.get_icon("branch"), out)
	end

	return string.format("%%6* %s %%*", out)
end

local function update_filepath_highlights()
	if vim.bo.modified then
		hl.group("StatusLineFilePath", { link = "DiffChange" })
		hl.group("StatusLineNewFilePath", { link = "DiffChange" })
	else
		hl.group("StatusLineFilePath", { link = "User6" })
		hl.group("StatusLineNewFilePath", { link = "User4" })
	end

	return ""
end

local function get_filepath_parts()
	local base = vim.fn.expand("%:~:.:h")
	local filename = vim.fn.expand("%:~:.:t")
	local prefix = (vim.fn.empty(base) == 1 or base == ".") and "" or base .. "/"

	return { base, filename, prefix }
end

local function filepath()
	local parts = get_filepath_parts()
	local prefix = parts[3]
	local filename = parts[2]

	update_filepath_highlights()

	local line = string.format("%s%%*%%#StatusLineFilePath#%s", prefix, filename)

	if vim.fn.empty(prefix) == 1 and vim.fn.empty(filename) == 1 then
		line = "%#StatusLineNewFilePath# %f %*"
	end

	return string.format("%%4*%s%%*", line)
end

local function readonly()
	local is_modifiable = vim.bo.modifiable == true
	local is_readonly = vim.bo.readonly == true
	local line = ""

	if not is_modifiable and is_readonly then
		line = string.format("%s RO", utils.get_icon("lock"))
	end

	if is_modifiable and is_readonly then
		line = "RO"
	end

	if not is_modifiable and not is_readonly then
		line = utils.get_icon("lock")
	end

	return string.format("%%5* %s %%w %%*", line)
end

local mode_table = {
	no = "N-Operator Pending",
	v = "V.",
	V = "V·Line",
	[""] = "V·Block", -- this is not ^V, but it's , they're different
	s = "S.",
	S = "S·Line",
	[""] = "S·Block",
	i = "I.",
	ic = "I·Compl",
	ix = "I·X-Compl",
	R = "R.",
	Rc = "Compl·Replace",
	Rx = "V·Replace",
	Rv = "X-Compl·Replace",
	c = "Command",
	cv = "Vim Ex",
	ce = "Ex",
	r = "Propmt",
	rm = "More",
	["r?"] = "Confirm",
	["!"] = "Sh",
	t = "T.",
}

local function mode()
	local current_mode = vim.api.nvim_get_mode().mode

	if current_mode == "n" then
		return ""
	end

	return mode_table[current_mode] or "NOT IN MAP"
end

local function rhs()
	return vim.fn.winwidth(0) > 80 and ("%%4* %s %%3l/%%3L:%%-2c %%*"):format(line_no_indicator())
		or line_no_indicator()
end

local function spell()
	if vim.wo.spell then
		return string.format("%%#WarningMsg# %s %%*", utils.get_icon("spell"))
	end
	return ""
end

local function paste()
	if vim.o.paste then
		return string.format("%%#ErrorMsg# %s %%*", utils.get_icon("paste"))
	end
	return ""
end

local function filetype()
	local iconsok, devicons = pcall(require, "nvim-web-devicons")
	local ft = vim.bo.filetype
	if not iconsok then
		return ft
	end
	local x = devicons.get_icon_by_filetype(ft)
	if x == nil then
		return ft
	end
	return x
end
local function file_info()
	local line = filetype()
	if vim.bo.fileformat ~= "unix" then
		line = string.format("%s %s", line, vim.bo.fileformat)
	end

	if vim.bo.fileencoding ~= "utf-8" then
		line = string.format("%s %s", line, vim.bo.fileencoding)
	end

	return string.format("%%4* %s %%*", line)
end

local function word_count()
	if vim.bo.filetype == "markdown" or vim.bo.filetype == "text" then
		return string.format("%%4* %d %s %%*", vim.fn.wordcount()["words"], "words")
	end

	return ""
end

local function lsp()
	local count = {}
	local levels = {
		errors = vim.diagnostic.severity.ERROR,
		warnings = vim.diagnostic.severity.WARN,
		info = vim.diagnostic.severity.WARN,
		hints = vim.diagnostic.severity.HINT,
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count.errors ~= 0 then
		errors = string.format("%%#DiagnosticSignError#%s %s", utils.get_icon("error"), count.errors)
	end

	if count.warnings ~= 0 then
		warnings = string.format("%%#DiagnosticSignWarn#%s %s", utils.get_icon("warn"), count.warnings)
	end

	if count.hints ~= 0 then
		hints = string.format("%%#DiagnosticSignHint#%s %s", utils.get_icon("hint"), count.hints)
	end

	if count.info ~= 0 then
		info = string.format("%%#DiagnosticSignInfo#%s %s", utils.get_icon("info"), count.info)
	end

	return string.format("%s %s %s %s%%*", errors, warnings, hints, info)
end

---------------------------------------------------------------------------------
-- Statusline
---------------------------------------------------------------------------------
local M = {}

function M.get_active_statusline()
	local line = table.concat({
		filepath(),
		word_count(),
		readonly(),
		"%9*%=%* ",
		mode(),
		" %*",
		paste(),
		-- orgmode(),
		lsp(),
		spell(),
		file_info(),
		rhs(),
	})

	if vim.bo.filetype == "help" or vim.bo.filetype == "man" then
		return table.concat({
			"%#StatusLineNC# ",
			filepath(),
			line,
		})
	end

	return table.concat({
		git_info(),
		"%<",
		line,
	})
end

function M.get_inactive_statusline()
	local line = "%#StatusLineNC#%f%*"

	return line
end

function M.activate()
	au.augroup("MyStatusLine", {
		{
			event = { "WinEnter", "BufEnter" },
			pattern = "*",
			callback = function()
				vim.opt_local.statusline = [[%!luaeval("require('yasser.statusline').get_active_statusline()")]]
			end,
		},
		{
			event = { "WinLeave", "BufLeave" },
			pattern = "*",
			callback = function()
				vim.opt_local.statusline = [[%!luaeval("require('yasser.statusline').get_inactive_statusline()")]]
			end,
		},
	})
end

M.activate()
return M
