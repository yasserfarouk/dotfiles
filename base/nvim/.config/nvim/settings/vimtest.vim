
let test#strategy = "dispatch"
let test#python#runner = 'pytest'
let g:dispatch_compilers = {}
let g:dispatch_compilers['pytest'] = 'pytest'
" vim-test mappings
nmap <silent> <localleader>tn :TestNearest<CR>
nmap <silent> <localleader>tf :TestFile<CR>
nmap <silent> <localleader>ts :TestSuite<CR>
nmap <silent> <localleader>tl :TestLast<CR>
nmap <silent> <localleader>tv :TestVisit<CR>
