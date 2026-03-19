local platform = require("yasser.utils.platform")

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

-- Define pandoc functions with cross-platform support
-- Note: pandoc commands use Unix-style paths which work on all platforms
-- The open command at the end is platform-specific
vim.cmd(string.format([[
function! PandocPDFBib()
	silent exec "Dispatch pandoc \"" . expand("%%") . "\" -s --pdf-engine=xelatex --variable colorlinks=true --resource-path=.  -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm --bibliography=references.bib -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o \"" . expand("%%:r") . ".pdf\" " . " && %s \"" . expand("%%:r") . ".pdf\"&"
endfunction
function! PandocPDFBibNoContents()
	silent exec "Dispatch pandoc \"" . expand("%%") . "\" -s --pdf-engine=xelatex --variable colorlinks=true --resource-path=.  -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable fontsize=10pt --variable version=2.0 -V geometry:margin=2cm --bibliography=references.bib -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o \"" . expand("%%:r") . ".pdf\" " . " && %s \"" . expand("%%:r") . ".pdf\"&"
endfunction
function! PandocWord()
	silent exec "Dispatch pandoc \"" . expand("%%") . "\" -s --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --resource-path=.  -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o \"" . expand("%%:r") . ".docx\" " . " && %s \"" . expand("%%:r") . ".docx\"&"
endfunction
function! PandocWordBib()
	silent exec "Dispatch pandoc \"" . expand("%%") . "\" -s --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --resource-path=.  -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm --bibliography=references.bib -V geometry:margin=2cm -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o \"" . expand("%%:r") . ".docx\" " . " && %s \"" . expand("%%:r") . ".docx\"&"
endfunction
function! PandocPDF()
	silent exec "Dispatch pandoc \"" . expand("%%") . "\" -s --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --resource-path=. -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o \"" . expand("%%:r") . ".pdf\" " . " && %s \"" . expand("%%:r") . ".pdf\"&"
endfunction
function! PandocPDFNoContents()
	silent exec "Dispatch pandoc \"" . expand("%%") . "\" -s --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --resource-path=. -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 -V geometry:margin=2cm -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o \"" . expand("%%:r") . ".pdf\" " . " && %s \"" . expand("%%:r") . ".pdf\"&"
endfunction
function! PandocPDFLandscape()
	silent exec "Dispatch pandoc --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=10pt -F mermaid-filter  --filter pandoc-latex-admonition --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=1cm -V geometry:landscape -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o " . expand("%%:r"). ".pdf -s " . expand("%%") . " && %s " . expand("%%:r") . ".pdf&"
endfunction
function! PandocPDFLandscapeNoContents()
	silent exec "Dispatch pandoc --pdf-engine=xelatex -F mermaid-filter  --filter pandoc-latex-admonition --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 -V geometry:margin=1cm -V geometry:landscape -V colorlinks=true -V linkcolor=blue -V urlcolor=blue -V toccolor=blue -o " . expand("%%:r"). ".pdf -s " . expand("%%") . " && %s " . expand("%%:r") . ".pdf&"
endfunction
function! PandocHTML()
	silent exec "Dispatch pandoc  -o " . expand("%%:r"). ".html -s " . expand("%%") . "; %s " . expand("%%:r") . ".html"
endfunction
]], get_open_cmd(), get_open_cmd(), get_open_cmd(), get_open_cmd(), get_open_cmd(), get_open_cmd(), get_open_cmd(), get_open_cmd(), get_open_cmd()))

-- PublishMedium is macOS/Unix-specific due to shell syntax and paths
-- Only define it on Unix systems
if not platform.is_windows then
	vim.cmd([[
function! PublishMedium()
	silent exec "Dispatch pandoc  -o " . expand("%:r"). ".html -s " . expand("%") . "; ~/go/bin/md-publisher publish --medium-token `cat $HOME/bin/.medium_token` " . expand("%:r") . ".html"
endfunction
]])
else
	-- Windows placeholder - would need PowerShell equivalent
	vim.cmd([[
function! PublishMedium()
	echo "PublishMedium is not supported on Windows"
endfunction
]])
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
			{
				"<leader>mb",
				"<cmd>call PandocPDFBib()<cr>",
				mode = { "n" },
				desc = "compile (references TOC)",
			},
			{
				"<leader>mB",
				"<cmd>call PandocPDFBibNoContents()<cr>",
				mode = { "n" },
				desc = "compile (references no-ToC)",
			},
			{ "<leader>ml", "<cmd>call PandocPDFLandscape()<cr>", mode = { "n" }, desc = "compile (landscape)" },
			{
				"<leader>mc",
				"<cmd>call PandocPDF()<cr>",
				mode = { "n" },
				desc = "compile (no references TOC)",
			},
			{ "<leader>mw", "<cmd>call PandocWord()<cr>", mode = { "n" }, desc = "word (no references)" },
			{ "<leader>mW", "<cmd>call PandocWordBib()<cr>", mode = { "n" }, desc = "word (references)" },
			{ "<leader>mh", "<cmd>call PandocHTML()<cr>", mode = { "n" }, desc = "compile (html)" },
			{
				"<leader>mC",
				"<cmd>call PandocPDFNoContents()<cr>",
				mode = { "n" },
				desc = "compile (portrait - no contents)",
			},
			{
				"<leader>mL",
				"<cmd>call PandocPDFLandscapeNoContents()<cr>",
				mode = { "n" },
				desc = "compile (landscape - no contents)",
			},
			{ "<leader>mP", "<cmd>call PublishMedium()<cr>", mode = { "n" }, desc = "publish (medium)" },
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
