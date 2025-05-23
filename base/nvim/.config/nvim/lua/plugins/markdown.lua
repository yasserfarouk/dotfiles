vim.cmd([[
function! PandocPDFBib()
	silent exec "Dispatch pandoc \"" . expand("%") . "\" -s --pdf-engine=xelatex --variable colorlinks=true --resource-path=.  -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm --bibliography=references.bib -o \"" . expand("%:r") . ".pdf\" " . " && open \"" . expand("%:r") . ".pdf\"&"
endfunction
function! PandocPDFBibNoContents()
	silent exec "Dispatch pandoc \"" . expand("%") . "\" -s --pdf-engine=xelatex --variable colorlinks=true --resource-path=.  -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable fontsize=10pt --variable version=2.0 -V geometry:margin=2cm --bibliography=references.bib -o \"" . expand("%:r") . ".pdf\" " . " && open \"" . expand("%:r") . ".pdf\"&"
endfunction
function! PandocWord()
	silent exec "Dispatch pandoc \"" . expand("%") . "\" -s --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --resource-path=.  -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm -o \"" . expand("%:r") . ".docx\" " . " && open \"" . expand("%:r") . ".docx\"&"
endfunction
function! PandocWordBib()
	silent exec "Dispatch pandoc \"" . expand("%") . "\" -s --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --resource-path=.  -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm --bibliography=references.bib -o \"" . expand("%:r") . ".docx\" " . " && open \"" . expand("%:r") . ".docx\"&"
endfunction
function! PandocPDF()
	silent exec "Dispatch pandoc \"" . expand("%") . "\" -s --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --resource-path=. -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=2cm -o \"" . expand("%:r") . ".pdf\" " . " && open \"" . expand("%:r") . ".pdf\"&"
endfunction
function! PandocPDFNoContents()
	silent exec "Dispatch pandoc \"" . expand("%") . "\" -s --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --resource-path=. -F mermaid-filter --filter pandoc-latex-admonition --citeproc --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 -V geometry:margin=2cm -o \"" . expand("%:r") . ".pdf\" " . " && open \"" . expand("%:r") . ".pdf\"&"
endfunction
function! PandocPDFLandscape()
	silent exec "Dispatch pandoc --pdf-engine=xelatex --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=10pt -F mermaid-filter  --filter pandoc-latex-admonition --variable version=2.0 --toc --toc-depth=2 -V geometry:margin=1cm -V geometry:landscape -o " . expand("%:r"). ".pdf -s " . expand("%") . " && open " . expand("%:r") . ".pdf&"
endfunction
function! PandocPDFLandscapeNoContents()
	silent exec "Dispatch pandoc --pdf-engine=xelatex -F mermaid-filter  --filter pandoc-latex-admonition --variable mainfont=\"Palatino\" --variable sansfont=\"Helvetica\" --variable monofont=\"Menlo\" --variable fontsize=10pt --variable version=2.0 -V geometry:margin=1cm -V geometry:landscape -o " . expand("%:r"). ".pdf -s " . expand("%") . " && open " . expand("%:r") . ".pdf&"
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
		"MeanderingProgrammer/render-markdown.nvim",
		-- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			render_modes = { "n", "c", "t" },
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
	{
		-- "iamcco/markdown-preview.nvim",
		"brianhuster/live-preview.nvim",
		ft = "markdown",
		dependencies = {
			-- You can choose one of the following pickers
			-- 'nvim-telescope/telescope.nvim',
			"ibhagwan/fzf-lua",
			-- 'echasnovski/mini.pick',
		},
		-- build = "cd app & yarn install",
		keys = {
			{ "<leader>mp", "<cmd>LivePreview start<cr>", mode = { "n" }, desc = "preview" },
		},
	},
	config = function()
		vim.cmd("source ~/.config/nvim/vimscript/markdown.vim")
	end,
}
