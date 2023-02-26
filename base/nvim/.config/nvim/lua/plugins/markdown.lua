vim.cmd([[
function! PandocPDFBib()
	silent exec "Dispatch pandoc \"" . expand("%") . "\" -s --pdf-engine=xelatex --variable colorlinks=true --resource-path=. --citeproc --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm --bibliography=references.bib -o \"" . expand("%:r") . ".pdf\" " . " && open \"" . expand("%:r") . ".pdf\"&"
endfunction
function! PandocPDFBibNoContents()
	silent exec "Dispatch pandoc \"" . expand("%") . "\" -s --pdf-engine=xelatex --variable colorlinks=true --resource-path=. --citeproc --variable fontsize=10pt --variable version=2.0 -V geometry:margin=2cm --bibliography=references.bib -o \"" . expand("%:r") . ".pdf\" " . " && open \"" . expand("%:r") . ".pdf\"&"
endfunction
function! PandocWord()
	silent exec "Dispatch pandoc \"" . expand("%") . "\" -s --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --resource-path=. --citeproc --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm --bibliography=references.bib -o \"" . expand("%:r") . ".docx\" " . " && open \"" . expand("%:r") . ".docx\"&"
endfunction
function! PandocPDF()
	silent exec "Dispatch pandoc \"" . expand("%") . "\" -s --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --resource-path=. -F mermaid-filter --citeproc --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm -o \"" . expand("%:r") . ".pdf\" " . " && open \"" . expand("%:r") . ".pdf\"&"
endfunction
function! PandocPDFLandscape()
	silent exec "Dispatch pandoc --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=10pt -F mermaid-filter  --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=1cm -V geometry:landscape -o " . expand("%:r"). ".pdf -s " . expand("%") . " && open " . expand("%:r") . ".pdf&"
endfunction
function! PandocPDFLandscapeNoContents()
	silent exec "Dispatch pandoc --pdf-engine=xelatex -F mermaid-filter  --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 -V geometry:margin=1cm -V geometry:landscape -o " . expand("%:r"). ".pdf -s " . expand("%") . " && open " . expand("%:r") . ".pdf&"
endfunction
function! PandocPDFNoContents()
	silent exec "Dispatch pandoc --pdf-engine=xelatex -F mermaid-filter  --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0  -V geometry:margin=2cm -o " . expand("%:r"). ".pdf -s " . expand("%") . " && open " . expand("%:r") . ".pdf&"
endfunction
function! PandocHTML()
	silent exec "Dispatch pandoc  -o " . expand("%:r"). ".html -s " . expand("%") . "; open " . expand("%:r") . ".html"
endfunction
function! PublishMedium()
	silent exec "Dispatch pandoc  -o " . expand("%:r"). ".html -s " . expand("%") . "; ~/go/bin/md-publisher publish --medium-token `cat $HOME/bin/.medium_token` " . expand("%:r") . ".html"
endfunction
]])
return {
	-- Markdown
	"tpope/vim-markdown",
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = "cd app & yarn install",
		keys = {
			-- { "<F9>", "<cmd>call PandocPDF()<cr>", mode = { "n" }, desc = "compile (portrait)" },
			-- { "<F5>", "<cmd>MarkdownPreview<cr>", mode = { "n" }, desc = "preview" },
			{ "<leader>mb", "<cmd>call PandocPDFBib()<cr>", mode = { "n" }, desc = "compile (portrait)" },
			{ "<leader>mB", "<cmd>call PandocPDFBibNoContents()<cr>", mode = { "n" }, desc = "compile (portrait)" },
			{ "<leader>mc", "<cmd>call PandocPDF()<cr>", mode = { "n" }, desc = "compile (portrait)" },
			{ "<leader>mw", "<cmd>call PandocWord()<cr>", mode = { "n" }, desc = "compile (portrait)" },
			{ "<leader>mh", "<cmd>call PandocHTML()<cr>", mode = { "n" }, desc = "compile (html)" },
			{ "<leader>ml", "<cmd>call PandocPDFLandscape()<cr>", mode = { "n" }, desc = "compile (landscape)" },
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
			{ "<leader>mv", "<cmd>MarkdownPreview<cr>", mode = { "n" }, desc = "preview" },
			{ "<leader>mp", "<cmd>MarkdownPreview<cr>", mode = { "n" }, desc = "preview" },
		},
	},
	config = function()
		vim.cmd("source ~/.config/nvim/vimscript/markdown.vim")
	end,
}