let g:nerdtree_tabs_open_on_gui_startup=0
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeHijackNetrw=0
let NERDTreeCascadeSingleChildDir=1
let NERDTreeCascadeOpenSingleChildDir=1
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowIgnoredStatus = 0
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = '-'
augroup vfinit
	autocmd FileType unite call s:uniteinit()
augroup END
function! s:uniteinit()
	nmap <buffer> <Esc> <Plug>(unite_exit)
endfunction
function! s:nerdtreeinit() abort
	nunmap <buffer> K
	nunmap <buffer> J
endf
