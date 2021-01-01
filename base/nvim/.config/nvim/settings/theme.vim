set background=dark
" gruvbox settings -------------------------------------------------------{{{
" colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
let g:gruvbox_hls_cursor = "orange"
let g:gruvbox_sign_column = "bg1"
let g:gruvbox_italicize_strings = 0
let g:gruvbox_improved_strings = 0
let g:gruvbox_italic = 0
let g:gruvbox_termcolors = 256
"  oceanic next settings ----------------------------------------------------{{{
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:oceanic_next_highlight_current_line =0
" }}}

"  nvcode settings ----------------------------------------------------{{{
hi Comment cterm=italic
let g:nvcode_hide_endofbuffer=1
let g:nvcode_terminal_italics=1
let g:nvcode_termcolors=256

if has('nvim')
lua<< EOF
	require'nvim-treesitter.configs'.setup {
ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
highlight = {
	enable = true,              -- false will disable the whole extension
	},
	}
EOF
endif
if has('nvim')
	" colorscheme nvcode " Or whatever colorscheme you make
	colorscheme onedark " Or whatever colorscheme you make
else
	colorscheme gruvbox
endif


colorscheme aurora
" checks if your terminal has 24-bit color support
if (has("termguicolors"))
	set termguicolors
	hi LineNr ctermbg=NONE guibg=NONE
endif
hi Conceal guifg=yellow
