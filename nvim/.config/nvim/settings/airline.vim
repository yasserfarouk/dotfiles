
" vim-airline ---------------------------------------------------------------{{{
let g:airline#extensions#virtualenv#enabled = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:webdevicons_enable_airline_statusline = 0

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#mike#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1
let g:airline_symbols.branch = ''
let g:airline_theme='gruvbox'
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
let g:airline#extensions#branch#format = 0
let g:airline_detect_spelllang=0
let g:airline_detect_spell=0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
" let g:airline_section_c = '%f%m'
" let g:airline_section_x = ''
let g:airline_section_y = ''
" let g:airline_section_z = '%l:%v'
" let g:airline_section_z = '%{LineNoIndicator()} :%2c'
let g:line_no_indicator_chars = [' ', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█']
" let g:line_no_indicator_chars = ['⎺', '⎻', '⎼', '⎽', '_']
" let g:airline_mode_map = {
" 			\ 'n'  : 'N',
" 			\ 'i' : 'I',
" 			\ 'R' : 'R',
" 			\ 'v' : 'v',
" 			\ 'V' : 'V',
" 			\ 'c' : 'C',
" 			\ 's' : 's',
" 			\ 'S' : 'S',
" 			\ ''  : '',
" 			\ 't' : 't',
" 			\}
let g:airline#extensions#tabline#buffer_idx_format = {
			\ '0': '0 ',
			\ '1': '1 ',
			\ '2': '2 ',
			\ '3': '3 ',
			\ '4': '4 ',
			\ '5': '5 ',
			\ '6': '6 ',
			\ '7': '7 ',
			\ '8': '8 ',
			\ '9': '9 ',
			\}


if !exists('g:airline_powerline_fonts')
	let g:airline#extensions#tabline#left_sep = ' '
	let g:airline#extensions#tabline#left_alt_sep = '|'
	let g:airline_left_sep          = '▶'
	let g:airline_left_alt_sep      = '»'
	let g:airline_right_sep         = '◀'
	let g:airline_right_alt_sep     = '«'
	let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
	let g:airline#extensions#readonly#symbol   = '⊘'
	let g:airline#extensions#linecolumn#prefix = '¶'
	let g:airline#extensions#paste#symbol      = 'ρ'
	let g:airline_symbols.linenr    = '␊'
	let g:airline_symbols.branch    = '⎇'
	let g:airline_symbols.paste     = 'ρ'
	let g:airline_symbols.paste     = 'Þ'
	let g:airline_symbols.paste     = '∥'
	let g:airline_symbols.whitespace = 'Ξ'
else
	let g:airline#extensions#tabline#left_sep = ''
	let g:airline#extensions#tabline#left_alt_sep = ''

	" powerline symbols
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ''
endif
" }}}
