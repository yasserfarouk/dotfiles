syntax on
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

	" Indent Line
	let g:indentLine_enabled = 1
	let g:indentLine_concealcursor = 0
	let g:indentLine_char = '┆'
	let g:indentLine_faster = 1
endif
" true color things --- {{{
hi Quote ctermbg=109 guifg=#83a598
" }}}

"  customize search results colors
highlight Search ctermbg=LightBlue ctermfg=LightBlue guibg=DarkBlue guifg=Yellow
highlight IncSearch guibg=LightBlue ctermbg=LightBlue term=underline
