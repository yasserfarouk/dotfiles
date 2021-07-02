" Fold, gets it's own section  ----------------------------------------------{{{
let g:xml_syntax_folding = 1

autocmd FileType javascript,html,css,scss,typescript setlocal foldlevel=99
autocmd FileType css,scss,json setlocal foldmethod=marker
autocmd FileType css,scss,json setlocal foldmarker={,}
autocmd FileType coffee setl foldmethod=indent
autocmd FileType xml setl foldmethod=syntax
autocmd FileType javascript,typescript,json setl foldmethod=syntax
