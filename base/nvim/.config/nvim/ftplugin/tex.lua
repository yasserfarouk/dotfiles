-- LaTeX-specific formatting settings
-- This file is automatically loaded for .tex files

-- Set textwidth to 90 columns for automatic wrapping
vim.opt_local.textwidth = 90

-- Configure formatoptions for LaTeX
-- t = Auto-wrap text using textwidth
-- c = Auto-wrap comments using textwidth
-- q = Allow formatting of comments with "gq"
-- l = Long lines are not broken in insert mode
-- n = Recognize numbered lists when formatting
-- 2 = Use indent of second line for rest of paragraph
vim.opt_local.formatoptions = "tcqln2"

-- Define what constitutes a list item in LaTeX
-- This pattern matches:
-- - \item[...]  (description/enumerate/itemize items with optional labels)
-- - \item       (plain items)
vim.opt_local.formatlistpat = [[^\s*\\item\(\[.*\]\)\?\s*]]

-- Also recognize comments starting with %
vim.opt_local.comments = "b:%,n:\\item"

-- Set comment string for LaTeX
vim.opt_local.commentstring = "%%s"

-- Ensure proper indentation for continuation lines
vim.opt_local.autoindent = true
vim.opt_local.breakindent = true
vim.opt_local.breakindentopt = "shift:2"
