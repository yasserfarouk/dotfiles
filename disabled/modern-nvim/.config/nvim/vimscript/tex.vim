if has('unix')
	if has('mac')
		function! UpdateSkim(status)
			if !a:status | return | endif

			let l:out = b:vimtex.out()
			let l:tex = expand('%:p')
			let l:cmd = [g:vimtex_view_general_viewer, '-r']
			if !empty(system('pgrep Skim'))
				call extend(l:cmd, ['-g'])
			endif
			if has('nvim')
				call jobstart(l:cmd + [line('.'), l:out, l:tex])
			elseif has('job')
				call job_start(l:cmd + [line('.'), l:out, l:tex])
			else
				call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
			endif
		endfunction
		" let g:vimtex_view_general_viewer
		" 			\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
		" let g:vimtex_view_general_options = '-r @line @pdf @tex'
		let g:vimtex_view_method = "skim"
		let g:vimtex_view_skim_sync = 1
		let g:vimtex_view_skim_activate = 1
		" This adds a callback hook that updates Skim after compilation
		" let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
		" let g:vimtex_view_general_options_latexmk = '--unique'
	" elseif has('win32')
	else
		let g:latex_view_general_viewer = "zathura"
		let g:vimtex_view_method = "zathura"
	endif
endif
" let g:vimtex_compiler_latexmk = {
" 			\ 'options' : [
" 			\   '-pdf',
" 			\   '-pdflatex="xelatex --shell-escape %O %S"',
" 			\   '-shell-escape',
" 			\   '-verbose',
" 			\   '-file-line-error',
" 			\   '-synctex=1',
" 			\ ],
" 			\}
" \   '-interaction=nonstopmode',
" let g:tex_flavor = "latexmk"
" let g:tex_flavor = "latex"
let g:vimtex_quickfix_open_on_warning = 0

let g:vimtex_quickfix_ignore_filters = [
	  \ 'Marginpar on page',
	  \ 'Overfull ',
	  \ 'Underfull ',
	  \ 'LaTeX warning:',
	  \ 'LaTeX Warning:',
	  \ 'Package hyperref Warning',
	  \ 'Package pgf Warning',
	  \ 'Package inputenc Warning',
	  \ 'Package listingsutf8 Warning',
	  \]
let g:vimtex_quickfix_mode = 2
" if has('nvim')
" 	let g:vimtex_compiler_progname = 'nvr'
" endif

" Concealment
let g:tex_conceal=""
set conceallevel=0

" Avoid utf-8 glyphs
let g:tex_superscripts = "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts = "[0-9aehijklmnoprstuvx,+-/().]"

" let g:vimtex_compiler_latexmk_engines = { '_': '-xelatex' }
" to enable back sync. See https://jdhao.github.io/2021/02/20/inverse_search_setup_neovim_vimtex/
function! SetServerName()
  if has('win32')
    let nvim_server_file = $TEMP . "/curnvimserver.txt"
  else
    let nvim_server_file = "/tmp/curnvimserver.txt"
  endif
  let cmd = printf("echo %s > %s", v:servername, nvim_server_file)
  call system(cmd)
endfunction

call SetServerName()

augroup tex_settings
    autocmd!
	autocmd BufEnter *.tex set conceallevel=0
augroup END
