let g:firenvim_config = {
			\ 'globalSettings': {
			\ 'alt': 'all',
			\  },
			\ 'localSettings': {
			\ '.*': {
			\ 'cmdline': 'neovim',
			\ 'priority': 0,
			\ 'selector': 'textarea',
			\ 'takeover': 'always',
			\ },
			\ }
			\ }
let fc = g:firenvim_config['localSettings']
let fc['https?://mail.google.com'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://easychair.org'] = { 'takeover': 'always', 'priority': 0 }
if exists('g:started_by_firenvim')
	set laststatus=0
	nnoremap <Esc><Esc> :call firenvim#focus_page()<CR>
	set wrap
endif
au BufEnter github.com_*.txt set filetype=markdown
let fc['.*'] = { 'cmdline' : 'firenvim' }
