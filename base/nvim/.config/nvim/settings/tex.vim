if has('unix')
	if has('mac')
		let g:vimtex_compiler_latexmk = {
					\ 'options' : [
					\   '-pdf',
					\   '-shell-escape',
					\   '-verbose',
					\   '-file-line-error',
					\   '-synctex=1',
					\   '-interaction=nonstopmode',
					\ ],
					\}
		let g:vimtex_view_method = "skim"
		let g:vimtex_view_general_viewer
					\ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
		let g:vimtex_view_general_options = '-r @line @pdf @tex'
		" This adds a callback hook that updates Skim after compilation
		" let g:vimtex_compiler_callback_hooks = ['UpdateSkim']
		let g:vimtex_view_general_options_latexmk = '--unique'
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
	else
		let g:latex_view_general_viewer = "zathura"
		let g:vimtex_view_method = "zathura"
	endif
elseif has('win32')
endif
let g:tex_flavor = "latex"
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_mode = 2
if has('nvim')
	let g:vimtex_compiler_progname = 'nvr'
endif

" One of the neosnippet plugins will conceal symbols in LaTeX which is
" confusing
let g:tex_conceal = ""

augroup texmappings
	autocmd!
	autocmd FileType tex nnoremap <buffer> <2-LeftMouse> :VimtexView<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tv :VimtexView<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tc :VimtexCompile<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tS :VimtexStop<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tX :VimtexStopAll<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tC :VimtexCompileSS<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tx :VimtexCompileSelected<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tn :VimtexClean<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tm :VimtexContextMenu<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>to :VimtexCompileOutput<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>ts :VimtexStatus<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tt :VimtexTocToggle<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tr :VimtexReload<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tR :VimtexReloadState<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tL :VimtexCountLetters<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tW :VimtexCountWords<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tl :VimtexLog<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>ti :VimtexInfo<CR>
	autocmd FileType tex nnoremap <buffer> <localleader>tp :VimtexDocPackage<CR>
augroup end
" Can hide specifc warning messages from the quickfix window
" Quickfix with Neovim is broken or something
" https://github.com/lervag/vimtex/issues/773
" let g:vimtex_quickfix_latexlog = {
" 			\ 'default' : 1,
" 			\ 'fix_paths' : 0,
" 			\ 'general' : 1,
" 			\ 'references' : 1,
" 			\ 'overfull' : 0,
" 			\ 'underfull' : 0,
" 			\ 'font' : 1,
" 			\ 'packages' : {
" 			\   'default' : 1,
" 			\   'natbib' : 1,
" 			\   'biblatex' : 1,
" 			\   'babel' : 1,
" 			\   'hyperref' : 1,
" 			\   'scrreprt' : 1,
" 			\   'fixltx2e' : 1,
" 			\   'titlesec' : 1,
" 			\ },
" 			\}
