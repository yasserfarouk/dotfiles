
function! s:run_black()
	execute ':!black '.expand('%')
	execute ':e %'
endfunction

function! s:run_isort()
	execute ':!isort '.expand('%')
	execute ':e %'
endfunction

function! s:run_black_dir()
	execute ':!black .'
	execute ':e %'
endfunction

" Float Term
nnoremap <leader>xb :call <SID>run_black()<CR>
nnoremap <leader>xi :call <SID>run_isort()<CR>
nnoremap <leader>xB :call <SID>run_black_dir()<CR>

