let g:firenvim_config = {
			\ 'globalSettings': {
			\ 'alt': 'all',
			\  },
			\ 'localSettings': {
			\ '.*': {
			\ 'cmdline': 'neovim',
			\ 'priority': 0,
			\ 'selector': 'textarea',
			\ 'takeover': 'never',
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

" starting in insert mode after the last character always.
function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, "name") &&
      \ l:ui.client.name is# "Firenvim"
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    au BufWritePost *.txt ++once call timer_start(100, {_ -> feedkeys("GA")})
  endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

