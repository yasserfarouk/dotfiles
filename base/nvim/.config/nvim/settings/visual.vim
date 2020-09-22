
" display settings -------------------------------------------------------{{{
colorscheme gruvbox
set background=dark
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
let g:gruvbox_hls_cursor = "orange"
let g:gruvbox_sign_column = "bg1"
let g:gruvbox_italicize_strings = 0
let g:gruvbox_improved_strings = 0
let g:gruvbox_italic = 0
let g:gruvbox_termcolors = 256
if has("gui_running")
	let g:indentLine_color_gui = '#343d46'
	set guifont=JetbrainsMono\ NF:h13
	if has("gui_mac") || has("gui_macvim")
		set transparency=0
	endif
	let g:indentLine_char="|"
	let g:indentLine_char = '┆'
else
	let g:CSApprox_loaded = 1

" IndentLine
	let g:indentLine_enabled = 1
	let g:indentLine_concealcursor = 0
	let g:indentLine_char = '┆'
	let g:indentLine_faster = 1
endif
"  Themes, Commands, etc  ----------------------------------------------------{{{
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
let g:oceanic_next_highlight_current_line =0
" colorscheme OceanicNext
" colorscheme one
" set background=dark
" }}}

"  Vim-Devicons -------------------------------------------------------------{{{
	" let g:NERDTreeGitStatusNodeColorization = 1
"  
	" let g:webdevicons_enable_denite = 0
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['vim'] = ''
" let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
" let g:WebDevIconsOS = 'Darwin'
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ''
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['tsx'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['css'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['html'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['json'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['md'] = ''
" let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['sql'] = ''
" }}}

 " true color things --- {{{
 if has('nvim')
	 let $NVIM_TUI_ENABLE_TRUE_COLOR=1
 endif
hi Quote ctermbg=109 guifg=#83a598
 " }}}
 "
" to close a hanging float use <c-w>o
" Highlighting colors
" highlight CursorLine gui=underline cterm=underline

"  customize search results colors
highlight Search ctermbg=LightBlue ctermfg=LightBlue guibg=DarkBlue guifg=Yellow
highlight IncSearch guibg=LightBlue ctermbg=LightBlue term=underline
