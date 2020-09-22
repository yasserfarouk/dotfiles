" Fold, gets it's own section  ----------------------------------------------{{{
" set foldtext=MyFoldText()
" autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
" autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" autocmd FileType vim setlocal fdc=1

let g:xml_syntax_folding = 1

autocmd FileType vim setlocal foldmethod=marker
autocmd FileType vim setlocal foldlevel=0
autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
autocmd FileType css,scss,json setlocal foldmethod=marker
autocmd FileType css,scss,json setlocal foldmarker={,}
autocmd FileType coffee setl foldmethod=indent
autocmd FileType xml setl foldmethod=syntax
" autocmd FileType html setl foldmethod=expr
" autocmd FileType html setl foldexpr=HTMLFolds()
autocmd FileType javascript,typescript,json setl foldmethod=syntax
