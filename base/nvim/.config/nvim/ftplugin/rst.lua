-- reStructuredText-specific formatting settings
-- This file is automatically loaded for .rst files

-- Set textwidth to 90 columns for automatic wrapping
vim.opt_local.textwidth = 90

-- Configure formatoptions for RST
-- t = Auto-wrap text using textwidth
-- c = Auto-wrap comments using textwidth
-- q = Allow formatting of comments with "gq"
-- l = Long lines are not broken in insert mode
-- n = Recognize numbered lists when formatting
-- 2 = Use indent of second line for rest of paragraph
vim.opt_local.formatoptions = "tcqln2"

-- Define what constitutes a list item in RST
-- This pattern matches:
-- - 1. numbered lists (with optional parenthesis or period)
-- - * unordered lists with asterisk
-- - - unordered lists with dash
-- - + unordered lists with plus
-- - #. auto-numbered lists
vim.opt_local.formatlistpat = [[^\s*\(\d\+\.\|[*+-]\|#\.\)\s\+]]

-- Recognize RST list items and directives
-- RST uses .. for directives and comments
vim.opt_local.comments = "fb:*,fb:-,fb:+,fb:#.,b:.."

-- Ensure proper indentation for continuation lines
vim.opt_local.autoindent = true
vim.opt_local.breakindent = true
vim.opt_local.breakindentopt = "shift:3"  -- RST uses 3-space indentation by convention
