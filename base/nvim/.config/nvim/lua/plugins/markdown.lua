local platform = require("yasser.utils.platform")
local job = require("yasser.utils.job")

-- Cross-platform open command for viewing generated files
local function get_open_cmd()
	if platform.is_mac then
		return "open"
	elseif platform.is_windows then
		return "start"
	else
		return "xdg-open"
	end
end

-- Run a pandoc command in background with statusline feedback
local function run_pandoc(cmd)
	job.run(cmd)
end

local function pandoc_pdf_bib()
	local f = vim.fn.shellescape(vim.fn.expand("%"))
	local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".pdf")
	run_pandoc(string.format(
		"pandoc %s -s --pdf-engine=xelatex --variable colorlinks=true --resource-path=. -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm --bibliography=references.bib -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o %s && %s %s",
		f, o, get_open_cmd(), o
	))
end

local function pandoc_pdf_bib_no_contents()
	local f = vim.fn.shellescape(vim.fn.expand("%"))
	local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".pdf")
	run_pandoc(string.format(
		"pandoc %s -s --pdf-engine=xelatex --variable colorlinks=true --resource-path=. -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable fontsize=10pt --variable version=2.0 -V geometry:margin=2cm --bibliography=references.bib -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o %s && %s %s",
		f, o, get_open_cmd(), o
	))
end

local function pandoc_word()
	local f = vim.fn.shellescape(vim.fn.expand("%"))
	local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".docx")
	run_pandoc(string.format(
		"pandoc %s -s --pdf-engine=xelatex --variable mainfont='Palatino' --variable sansfont='Helvetica' --resource-path=. -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont='Menlo' --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o %s && %s %s",
		f, o, get_open_cmd(), o
	))
end

local function pandoc_word_bib()
	local f = vim.fn.shellescape(vim.fn.expand("%"))
	local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".docx")
	run_pandoc(string.format(
		"pandoc %s -s --pdf-engine=xelatex --variable mainfont='Palatino' --variable sansfont='Helvetica' --resource-path=. -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont='Menlo' --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm --bibliography=references.bib -V geometry:margin=2cm -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o %s && %s %s",
		f, o, get_open_cmd(), o
	))
end

local function pandoc_pdf()
	local f = vim.fn.shellescape(vim.fn.expand("%"))
	local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".pdf")
	run_pandoc(string.format(
		"pandoc %s -s --pdf-engine=xelatex --variable mainfont='Palatino' --variable sansfont='Helvetica' --resource-path=. -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont='Menlo' --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o %s && %s %s",
		f, o, get_open_cmd(), o
	))
end

local function pandoc_pdf_no_contents()
	local f = vim.fn.shellescape(vim.fn.expand("%"))
	local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".pdf")
	run_pandoc(string.format(
		"pandoc %s -s --pdf-engine=xelatex --variable mainfont='Palatino' --variable sansfont='Helvetica' --resource-path=. -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont='Menlo' --variable fontsize=10pt --variable version=2.0 -V geometry:margin=2cm -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o %s && %s %s",
		f, o, get_open_cmd(), o
	))
end

local function pandoc_pdf_landscape()
	local f = vim.fn.shellescape(vim.fn.expand("%"))
	local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".pdf")
	run_pandoc(string.format(
		"pandoc --pdf-engine=xelatex --variable mainfont='Palatino' --variable sansfont='Helvetica' --variable monofont='Menlo' --variable fontsize=10pt -F mermaid-filter --filter pandoc-latex-admonition --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=1cm -V geometry:landscape -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o %s -s %s && %s %s",
		o, f, get_open_cmd(), o
	))
end

local function pandoc_pdf_landscape_no_contents()
	local f = vim.fn.shellescape(vim.fn.expand("%"))
	local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".pdf")
	run_pandoc(string.format(
		"pandoc --pdf-engine=xelatex -F mermaid-filter --filter pandoc-latex-admonition --variable mainfont='Palatino' --variable sansfont='Helvetica' --variable monofont='Menlo' --variable fontsize=10pt --variable version=2.0 -V geometry:margin=1cm -V geometry:landscape -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o %s -s %s && %s %s",
		o, f, get_open_cmd(), o
	))
end

local function pandoc_html()
	local f = vim.fn.shellescape(vim.fn.expand("%"))
	local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".html")
	run_pandoc(string.format("pandoc -o %s -s %s; %s %s", o, f, get_open_cmd(), o))
end

local function publish_medium()
	if platform.is_windows then
		vim.notify("PublishMedium is not supported on Windows", vim.log.levels.WARN)
		return
	end
	local f = vim.fn.shellescape(vim.fn.expand("%"))
	local o = vim.fn.shellescape(vim.fn.expand("%:r") .. ".html")
	run_pandoc(string.format(
		"pandoc -o %s -s %s; ~/go/bin/md-publisher publish --medium-token `cat $HOME/bin/.medium_token` %s",
		o, f, o
	))
end

return {
	-- Markdown
	"tpope/vim-markdown",
	{
		"tadmccorkle/markdown.nvim",
		ft = "markdown", -- or 'event = "VeryLazy"'
		opts = {
			-- configuration here or empty for defaults
		},
		keys = {
			{ "<leader>mb", pandoc_pdf_bib,                  mode = { "n" }, desc = "compile (references TOC)" },
			{ "<leader>mB", pandoc_pdf_bib_no_contents,      mode = { "n" }, desc = "compile (references no-ToC)" },
			{ "<leader>ml", pandoc_pdf_landscape,            mode = { "n" }, desc = "compile (landscape)" },
			{ "<leader>mc", pandoc_pdf,                      mode = { "n" }, desc = "compile (no references TOC)" },
			{ "<leader>mw", pandoc_word,                     mode = { "n" }, desc = "word (no references)" },
			{ "<leader>mW", pandoc_word_bib,                 mode = { "n" }, desc = "word (references)" },
			{ "<leader>mh", pandoc_html,                     mode = { "n" }, desc = "compile (html)" },
			{ "<leader>mC", pandoc_pdf_no_contents,          mode = { "n" }, desc = "compile (portrait - no contents)" },
			{ "<leader>mL", pandoc_pdf_landscape_no_contents, mode = { "n" }, desc = "compile (landscape - no contents)" },
			{ "<leader>mP", publish_medium,                  mode = { "n" }, desc = "publish (medium)" },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = "cd app & yarn install",
		keys = {
			{ "<leader>mv", "<cmd>MarkdownPreview<cr>", mode = { "n" }, desc = "preview" },
		},
	},
	config = function()
		-- Source markdown.vim using cross-platform path
		vim.cmd.source(platform.join(platform.config_dir(), "vimscript", "markdown.vim"))
	end,
}
