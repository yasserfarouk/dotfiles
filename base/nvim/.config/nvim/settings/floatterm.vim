
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
nnoremap <leader>xh :FloatermNew<CR>
nnoremap <leader>xx :FloatermToggle<CR>
nnoremap <leader>xf :FloatermNew vifm<CR>
nnoremap <leader>xt :FloatermNew ytop<CR>
nnoremap <leader>xG :FloatermNew lazygit<CR>
nnoremap <leader>xP :FloatermNew ipython<CR>
nnoremap <leader>xb :call <SID>run_black()<CR>
nnoremap <leader>xi :call <SID>run_isort()<CR>
nnoremap <leader>xB :call <SID>run_black_dir()<CR>
nnorema <leader>xg :FloatermNew googler
nnoremap <leader>xn :FloatermNext<CR>
nnoremap <leader>xp :FloatermPrev<CR>

"  terminal emulation
nnoremap <silent> <leader>shr :FloatermNew --wintype=normal --position=right<CR>
nnoremap <silent> <leader>shb :FloatermNew --wintype=normal --height=0.3 --position=bottom<CR>
nnoremap <silent> <leader>shl :FloatermNew --wintype=normal --position=left<CR>
nnoremap <silent> <leader>sht :FloatermNew --wintype=normal --position=top<CR>
nnoremap <silent> <leader>run :FloatermSend<CR>
