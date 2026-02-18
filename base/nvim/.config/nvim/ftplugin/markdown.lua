-- Markdown-specific formatting settings
-- This file is automatically loaded for .md files

-- Set textwidth to 90 columns for automatic wrapping
vim.opt_local.textwidth = 90

-- Configure formatoptions for Markdown
-- t = Auto-wrap text using textwidth
-- c = Auto-wrap comments using textwidth
-- q = Allow formatting of comments with "gq"
-- l = Long lines are not broken in insert mode
-- n = Recognize numbered lists when formatting
-- 2 = Use indent of second line for rest of paragraph
vim.opt_local.formatoptions = "tcqln2"

-- Define what constitutes a list item in Markdown
-- This pattern matches:
-- - 1. numbered lists (with optional spaces)
-- - - unordered lists with dash
-- - * unordered lists with asterisk
-- - + unordered lists with plus
vim.opt_local.formatlistpat = [[^\s*\(\d\+[\]:.)}\t ]\|[-*+]\)\s*]]

-- Recognize Markdown list items and code blocks in comments
vim.opt_local.comments = "fb:*,fb:-,fb:+,n:>"

-- Ensure proper indentation for continuation lines
vim.opt_local.autoindent = true
vim.opt_local.breakindent = true
vim.opt_local.breakindentopt = "shift:2"
