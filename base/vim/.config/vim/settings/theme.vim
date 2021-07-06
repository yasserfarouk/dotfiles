set background=dark
" gruvbox settings -------------------------------------------------------{{{
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
let g:gruvbox_hls_cursor = "orange"
let g:gruvbox_sign_column = "bg1"
let g:gruvbox_italicize_strings = 0
let g:gruvbox_improved_strings = 0
let g:gruvbox_italic = 0
let g:gruvbox_termcolors = 256
colorscheme gruvbox
"  oceanic next settings ----------------------------------------------------{{{
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:oceanic_next_highlight_current_line =0
" colorscheme oceanic_next
" colorscheme onedark
" }}}

" checks if your terminal has 24-bit color support
" if (has("termguicolors"))
	" set termguicolors
	" hi LineNr ctermbg=NONE guibg=NONE
" endif

" hi Conceal guifg=yellow, ctermfg=yellow
