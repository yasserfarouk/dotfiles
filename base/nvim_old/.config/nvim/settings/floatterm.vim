let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_autoclose = 1
let g:floaterm_autohide = 1
function! s:run_black()
	execute ':!black '.expand('%')
	execute ':e %'
endfunction

function! s:run_isort()
	execute ':!isort --profile black '.expand('%')
	execute ':e %'
endfunction

function! s:run_optimize()
	execute ':!autoflake --in-place --remove-unused-variables --remove-unused-variables --expand-star-imports --exclude=__init__.py --remove-duplicate-keys --remove-all-unused-imports --ignore-init-module-imports  '.expand('%')
	execute ':e %'
endfunction

function! s:run_black_dir()
	execute ':!black .'
	execute ':e %'
endfunction

function! s:run_isort_dir()
	execute ':!isort  --profile=black .'
	execute ':e %'
endfunction

function! s:run_optimize_dir()
	execute ':!autoflake --in-place --remove-unused-variables --remove-unused-variables --expand-star-imports --exclude=__init__.py --remove-duplicate-keys --remove-all-unused-imports --ignore-init-module-imports --recursive .'
	execute ':e %'
endfunction
" Float Term
nnoremap <leader>xb :call <SID>run_black()<CR>
nnoremap <leader>xi :call <SID>run_isort()<CR>
nnoremap <leader>xB :call <SID>run_black_dir()<CR>
nnoremap <leader>xI :call <SID>run_isort_dir()<CR>
nnoremap <leader>xI :call <SID>run_isort_dir()<CR>
nnoremap <leader>xa :call <SID>run_optimize()<CR>
nnoremap <leader>xA :call <SID>run_optimize_dir()<CR>

